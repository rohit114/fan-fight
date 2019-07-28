# fan-fight

a [Sails v1](https://sailsjs.com) application


### Links

+ [Sails framework documentation](https://sailsjs.com/get-started)
+ [Version notes / upgrading](https://sailsjs.com/documentation/upgrading)
+ [Deployment tips](https://sailsjs.com/documentation/concepts/deployment)
+ [Community support options](https://sailsjs.com/support)
+ [Professional / enterprise options](https://sailsjs.com/enterprise)


### Version info

This app was originally generated on Sat Jul 27 2019 20:16:29 GMT+0530 (India Standard Time) using Sails v1.1.0.

<!-- Internally, Sails used [`sails-generate@1.16.4`](https://github.com/balderdashy/sails-generate/tree/v1.16.4/lib/core-generators/new). -->



<!--
Note:  Generators are usually run using the globally-installed `sails` CLI (command-line interface).  This CLI version is _environment-specific_ rather than app-specific, thus over time, as a project's dependencies are upgraded or the project is worked on by different developers on different computers using different versions of Node.js, the Sails dependency in its package.json file may differ from the globally-installed Sails CLI release it was originally generated with.  (Be sure to always check out the relevant [upgrading guides](https://sailsjs.com/upgrading) before upgrading the version of Sails used by your app.  If you're stuck, [get help here](https://sailsjs.com/support).)
-->
### 1.SETUP POSTGRES (V 11.2) DATABASE on MacOS / Linux

    Step1: brew install postgresql
    Step2: pg_ctl -D /usr/local/var/postgres start && brew services start postgresql

For LINUX https://www.digitalocean.com/community/tutorials/how-to-install-and-use-postgresql-on-ubuntu-14-04 

### 2. steps to create user for db and import data from dump file
    1. psql postgres;
    2. CREATE ROLE fanfight WITH LOGIN PASSWORD 'fanfight' CREATEDB;  //create a user with login password createdb priviledge
    3. \q                                                             //quits current psql console
    4. psql postgres -U fanfight;                                     //login in psql with user fanfight
    5. CREATE DATABASE fanfight;                                      //create database fanfight
    6. \q                                                             //quits current psql console
    7. To dump the fanfight-dump.sql (first clone the repo: https://github.com/rohit114/fan-fight.git),
       1. cd fan-fight
       2. psql fanfight < fanfight-dump.sql
    8. psql postgres -U fanfight -d fanfight;                         //login in psql with database fanfight user fanfight
    9. Voilla! PostgreSQL setup done with all data from fanfight-dump.sql, you may INSERT more data in wallet table manually for testing purpose.

### 3 To run the Sails App
    1. clone the repo: https://github.com/rohit114/fan-fight.git
    2. cd fan-fight
    3. npm install
    4. NODE_PATH=. NODE_ENV=development sails lift
    Your sails app is running in localhost at port 1337

### 4 Calling APIs
    All routes exists in config/routes.js file.
    Problem Statement:
    API that takes the input variable as discounting %age for contest
    entry fee and discounts for the user and when user joins the contest after getting discount it
    deducts the money with above logic from user’s wallet

    route: `contest/join`
    method: POST
    params: { user, entryFee, discount }
    response: { updated wallet statement after successfull transection}
    where user is userID, entryFee is fee required to enter contest, discount in percent
    make a POST request uisng the route `contest/join` with given params (as body params) using postman or CURL command.

    dummy example:
    POST /contest/join | params: { user: 1, entryFee: 400, discount:20 } | wallet Before Txn: { bonus:60, deposit:100 winnings:340 } |
    wallet After Txn: { bonus:28, deposit:0 winnings:152 }



