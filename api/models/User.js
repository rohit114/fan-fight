module.exports = {
   attributes: {
    name: {
      type: 'string',
      columnType: 'text'
    },
    imageUrl: {
      type: 'string',
      columnType: 'text'
    },
    //to maintain the uniqueness allowNull: true
    phone: {
      type: 'string',
      columnType: 'text',
      allowNull: true,
      unique: true
    },
    email: {
      type: 'string',
      columnType: 'text'
    },
    registeredAt: {
      type: 'string',
      allowNull: true,
      columnType: 'timestamp with time zone'
    },
    userWallet: {
      collection: 'Wallet',
      via: 'user'
    }
  }

};
