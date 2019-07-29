module.exports = {
  friendlyName: `Join Game`,
  description: `Joins a game and process wallet transections for the given user`,
  inputs: {
    user: {
      description: `User's ID`,
      type: `number`,
      required: true
    },
    entryFee: {
      description: `Entry fee for game`,
      type: `number`,
      required: true
    },
    discount: {
      description: 'Discount in percentage',
      type: 'number',
      required: true
    }
  },

  exits: {
    failure: {
      description: `Couldn't Join game! Something went wrong`,
      responseType: 'serverError'
    },
    inSufficientAmount: {
      description: `No sufficient amount in wallet`,
      statusCode: 406
    },
    success: {
      description: `Game Joined Successfully!`,
      statusCode: 201
    },
  },

  fn: async function (inputs, exits) {
    try {
      const user = await User.findOne({ id: inputs.user }); //find user object

      const wallet = await Wallet.findOne({ user: user.id }); //find wallet object of user

      const discountAmount = ((inputs.discount)/100)*inputs.entryFee;
      var payableAmount = inputs.entryFee - discountAmount;

      if( wallet.bonus + wallet.deposit + wallet.winnings < payableAmount ){
        return exits.inSufficientAmount({ status: `No sufficient amount in wallet` });
      }

      var txnMetaData;
      var updatedWallet;
      /********* TXN FROM WALLET'S BONUS BUCKET STARTS *********/
      txnMetaData = await BonusBucketWalletTxn(payableAmount, wallet, exits);
      payableAmount = txnMetaData.payableAmount;
      const remainingBounsAmount = txnMetaData.remainingBounsAmount;
      if( payableAmount === 0){

        updatedWallet = await Wallet.updateOne({user: inputs.user}).set({ bonus: remainingBounsAmount}); //updating wallet of user

        return exits.success({
          success: true,
          user: updatedWallet.user,
          bonus: updatedWallet.bonus,
          deposit: updatedWallet.deposit,
          winnings: updatedWallet.winnings,
          remainingWalletBalance: updatedWallet.bonus+updatedWallet.deposit+updatedWallet.winnings
        });
      }
      /********** TXN FROM WALLET'S BONUS BUCKET ENDS **********/


      /********** TXN FROM WALLET'S DEPOSIT BUCKET STARTS  **********/
      txnMetaData = await DepositBucketWalletTxn( payableAmount, wallet, exits);
      payableAmount = txnMetaData.payableAmount;
      const remainingDepositAmount = txnMetaData.remainingDepositAmount;
      if( payableAmount === 0){
        updatedWallet = await Wallet.updateOne({ user: inputs.user }).set({ deposit: remainingDepositAmount , bonus: remainingBounsAmount}); //updating wallet of user
        
        return exits.success({
          success: true,
          user: updatedWallet.user,
          bonus: updatedWallet.bonus,
          deposit: updatedWallet.deposit,
          winnings: updatedWallet.winnings,
          remainingWalletBalance: updatedWallet.bonus+updatedWallet.deposit+updatedWallet.winnings
        });
      }
      /********** TXN FROM WALLET'S DEPOSIT BUCKET ENDS  **********/

      /********** TXN FROM WALLET'S WINNINGS BUCKET STARTS **********/
      txnMetaData = await WinningsBucketWalletTxn( payableAmount, wallet, exits);
      const remainingWinningsAmount = txnMetaData.remainingWinningsAmount;

      updatedWallet = await Wallet.updateOne({ user: inputs.user }).set({
        bonus: remainingBounsAmount,
        deposit: remainingDepositAmount,
        winnings: remainingWinningsAmount
       });

      return exits.success({
          success: true,
          user: updatedWallet.user,
          bonus: updatedWallet.bonus,
          deposit: updatedWallet.deposit,
          winnings: updatedWallet.winnings,
          remainingWalletBalance: updatedWallet.bonus+updatedWallet.deposit+updatedWallet.winnings
        });
      /********** TXN FROM WALLET'S WINNINGS BUCKET ENDS  **********/
    } catch(err) {
      return exits.failure(err);
    }
  }

};


async function BonusBucketWalletTxn(payableAmount, wallet, exits){

  try {

    var remainingBounsAmount = 0;
    const usableBonusAmount = (0.1)*payableAmount;  //only 10% is usable from bonus bucket
    if( wallet.bonus >= usableBonusAmount){
      payableAmount -= usableBonusAmount;
      remainingBounsAmount = wallet.bonus - usableBonusAmount;
    } else {
      payableAmount -= wallet.bonus;
      remainingBounsAmount = 0;
    }

    return { payableAmount: payableAmount, remainingBounsAmount: remainingBounsAmount };

  } catch(err){
      return exits.failure(err);
  }
}

async function DepositBucketWalletTxn(payableAmount, wallet, exits){

  try {
    var remainingDepositAmount = 0;

    if( wallet.deposit >= payableAmount ) {
      remainingDepositAmount = wallet.deposit - payableAmount;
      payableAmount = 0;
    } else {
      payableAmount -= wallet.deposit;
      remainingDepositAmount =0;
    }

    return { payableAmount: payableAmount, remainingDepositAmount: remainingDepositAmount };

  } catch(err){
      return exits.failure(err);
  }

}

async function WinningsBucketWalletTxn(payableAmount, wallet, exits){
  try {
    var remainingWinningsAmount = 0;
    if( wallet.winnings >= payableAmount ){
      remainingWinningsAmount = wallet.winnings - payableAmount;
      payableAmount = 0;
    } else {
      payableAmount -= wallet.winnings;
      remainingWinningsAmount = 0;
    }

    return { payableAmount: payableAmount, remainingWinningsAmount: remainingWinningsAmount };

  } catch(err){
      return exits.failure(err);
  }

}
