DROP TABLE assets;
DROP TABLE bonds;
DROP TABLE buyorder;
DROP TABLE companies;
DROP TABLE options;
DROP TABLE sellorder;
DROP TABLE stocks;
DROP TABLE tradingaccount;
DROP TABLE transactions;
DROP TABLE users;
DROP TABLE positions;
CREATE TABLE users
(
    user_id INTEGER NOT NULL
                  ,
    full_name VARCHAR(30) NOT NULL
                  ,
    email VARCHAR(30) NOT NULL
                  ,
    pw VARCHAR(30) NOT NULL
                  ,
    address VARCHAR(30) NOT NULL
                  ,
    phone_no INTEGER NOT NULL
                  ,
    dob DATE NOT NULL
                  ,
    PRIMARY KEY (user_id)
);
CREATE TABLE buyorder
(
    buy_id INTEGER NOT NULL
                     ,
    buydate DATE NOT NULL
                     ,
    buystatus VARCHAR(30) NOT NULL
                     ,
    buytype VARCHAR(30) NOT NULL
                     ,
    buyopenclose VARCHAR(30) NOT NULL
                     ,
    buyunitprice DECIMAL(10,2) NOT NULL
                     ,
    buyquantity INTEGER NOT NULL
                     ,
    acc_id INTEGER NOT NULL
                     ,
    PRIMARY KEY(buy_id)
                     ,
    FOREIGN KEY(acc_id) REFERENCES tradingaccount(acc_id)
);
CREATE TABLE sellorder
(
    sell_id INTEGER NOT NULL
                     ,
    selldate DATE NOT NULL
                     ,
    sellstatus VARCHAR(30) NOT NULL
                     ,
    selltype VARCHAR(30) NOT NULL
                     ,
    sellopenclose VARCHAR(30) NOT NULL
                     ,
    sellunitprice DECIMAL(10,2) NOT NULL
                     ,
    sellquantity INTEGER NOT NULL
                     ,
    acc_id INTEGER NOT NULL
                     ,
    PRIMARY KEY(sell_id)
                     ,
    FOREIGN KEY(acc_id) REFERENCES tradingaccount(acc_id)
);
CREATE TABLE transactions
(
    trans_id INTEGER NOT NULL
                         ,
    transdate DATE NOT NULL
                         ,
    transunitprice DECIMAL(10,2) NOT NULL
                         ,
    transquantity INTEGER NOT NULL
                         ,
    transfee DECIMAL(10,2) NOT NULL
                         ,
    transcost DECIMAL(10,2) NOT NULL
                         ,
    sell_id INTEGER NOT NULL
                         ,
    buy_id INTEGER NOT NULL
                         ,
    PRIMARY KEY(trans_id)
                         ,
    FOREIGN KEY(sell_id) REFERENCES sellorder(sell_id)
                         ,
    FOREIGN KEY(buy_id) REFERENCES buyorder(buy_id)
);
CREATE TABLE assets
(
    ticker VARCHAR(30) NOT NULL
                   ,
    volume INTEGER NOT NULL
                   ,
    PRIMARY KEY(ticker)
);
--Bonds may not have a price reflected on certain dates (eg. default of bonds)
CREATE TABLE bonds
(
    ticker VARCHAR(30) NOT NULL
                  ,
    bond_open DECIMAL(10,2)
                  ,
    bond_close DECIMAL(10,2)
                  ,
    bond_high DECIMAL(10,2)
                  ,
    bond_low DECIMAL(10,2)
                  ,
    bond_netchange DECIMAL(10,2)
                  ,
    PRIMARY KEY(ticker)
);
CREATE TABLE stocks
(
    ticker VARCHAR(30) NOT NULL
                   ,
    mkt_cap DECIMAL(10,2)
                   ,
    stock_open DECIMAL(10,2)
                   ,
    stock_close DECIMAL(10,2)
                   ,
    stock_high DECIMAL(10,2)
                   ,
    stock_low DECIMAL(10,2)
                   ,
    stock_netchange DECIMAL(10,2)
                   ,
    PRIMARY KEY(ticker)
);
CREATE TABLE options
(
    ticker VARCHAR(30) NOT NULL
                    ,
    strike_price DECIMAL(10,2)
                    ,
    pricepercontract DECIMAL(10,2)
                    ,
    PRIMARY KEY(ticker)
);
CREATE TABLE companies
(
    comp_id INTEGER NOT NULL
                      ,
    comp_name VARCHAR(30) NOT NULL
                      ,
    PRIMARY KEY(comp_id)
);
--Maybe we can change the account name to account ID since it is no longer a weak entity?
CREATE TABLE tradingaccount
(
    acc_id INTEGER NOT NULL
                           ,
    bank_swift INTEGER NOT NULL
                           ,
    bank_acc_no INTEGER NOT NULL
                           ,
    available_cash DECIMAL(10,2) NOT NULL
                           ,
    user_id INTEGER NOT NULL
                           ,
    PRIMARY KEY(acc_id)
                           ,
    FOREIGN KEY(user_id) REFERENCES users
(user_id)
);
CREATE TABLE positions
(
    acc_id INTEGER NOT NULL
                      ,
    ticker VARCHAR(30) NOT NULL
                      ,
    pos_quantity INTEGER NULL
                      ,
    pos_profit_loss DECIMAL(10,2) NULL
                      ,
    PRIMARY KEY(acc_id, ticker)
                      ,
    FOREIGN KEY(ticker) REFERENCES assets(ticker)
                      ,
    FOREIGN KEY(acc_id) REFERENCES tradingaccount(acc_id)
);
                           
