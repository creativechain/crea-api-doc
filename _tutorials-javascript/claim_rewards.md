---
title: 'JS: Claim Rewards'
position: 23
description: "_Learn how to claim rewards from unclaimed reward balance using Creaconnect as well as client signing method._"
layout: full
---              
<span class="fa-pull-left top-of-tutorial-repo-link"><span class="first-word">Full</span>, runnable src of [Claim Rewards](https://github.com/creativechain/crea-api-doc-tutorials-js/tree/master/tutorials/23_claim_rewards) can be downloaded as part of the [JS tutorials repository](https://github.com/creativechain/crea-api-doc-tutorials-js).</span>
<br>



This tutorial runs on the main Crea blockchain. And accounts queried are real users with unclaimed balances.

## Intro

This tutorial will show few functions such as querying account by name and getting unclaimed rewards. We are using the `call` function provided by the `dcrea` library to pull accounts from the Crea blockchain. A simple HTML interface is used to capture the account and its unclaimed balance as well as allowing interactively claim rewards.

## Steps

1.  [**App setup**](#app-setup) Setup `dcrea` to use the proper connection and network.
2.  [**Search account**](#search-account) Get account details after input has account name
3.  [**Fill form**](#fill-form) Fill form with account reward balances
4.  [**Claim reward**](#claim-reward) Claim reward with Creaconnect or Client signing options

#### 1. App setup <a name="app-setup"></a>

Below we have `dcrea` pointing to the production network with the proper chainId, addressPrefix, and endpoint. There is a `public/app.js` file which holds the Javascript segment of this tutorial. In the first few lines we define the configured library and packages:

```javascript
const dcrea = require('dcrea');
let opts = {};
//connect to production server
opts.addressPrefix = 'STM';
opts.chainId =
    '0000000000000000000000000000000000000000000000000000000000000000';
//connect to server which is connected to the network/production
const client = new dcrea.Client('https://node1.creary.net');
```

#### 2. Search account <a name="search-account"></a>

After account name field is filled with some name, we do automatic search for account by name when input is focused out. HTML input forms can be found in the `index.html` file. The values are pulled from that screen with the below:

```javascript
    const accSearch = document.getElementById('username').value;
    const _accounts = await client.database.call('get_accounts', [[accSearch]]);
    console.log(`_accounts:`, _accounts);
```

#### 3. Fill form <a name="fill-form"></a>

After we fetched account data, we will fill form with reward balance and show current reward balance details.

```javascript
const name = _accounts[0].name;
const reward_crea = _accounts[0].reward_crea_balance.split(' ')[0];
const reward_sbd = _accounts[0].reward_sbd_balance.split(' ')[0];
const reward_sp = _accounts[0].reward_vesting_crea.split(' ')[0];
const reward_vests = _accounts[0].reward_vesting_balance.split(' ')[0];
const unclaimed_balance = `Unclaimed balance for ${name}: ${reward_crea} CREA, ${reward_sbd} CBD, ${reward_sp} SP = ${reward_vests} VESTS<br/>`;
document.getElementById('accList').innerHTML = unclaimed_balance;
document.getElementById('crea').value = reward_crea;
document.getElementById('sbd').value = reward_sbd;
document.getElementById('sp').value = reward_vests;
```

#### 4. Claim reward <a name="claim-reward"></a>

We have 2 options on how to claim rewards. Creaconnect and Client signing options. We generate Creaconnect link to claim rewards, but you can also choose client signing option to claim rewards right inside tutorial.

In order to enable client signing, we will generate operation and also show Posting Private key (wif) field to sign transaction right there client side.
Below you can see example of operation and signing transaction, after successful operation broadcast result will be shown in user interface. It will be block number that transaction was included.

```javascript
window.submitTx = async () => {
    const privateKey = dcrea.PrivateKey.fromString(
        document.getElementById('wif').value
    );
    const op = [
        'claim_reward_balance',
        {
            account: document.getElementById('username').value,
            reward_crea: document.getElementById('crea').value + ' CREA',
            reward_sbd: document.getElementById('sbd').value + ' CBD',
            reward_vests: document.getElementById('sp').value + ' VESTS',
        },
    ];
    client.broadcast.sendOperations([op], privateKey).then(
        function(result) {
            document.getElementById('result').style.display = 'block';
            document.getElementById(
                'result'
            ).innerHTML = `<br/><p>Included in block: ${
                result.block_num
            }</p><br/><br/>`;
        },
        function(error) {
            console.error(error);
        }
    );
};
```

That's it!

### To run this tutorial

1.  clone this repo
1.  `cd tutorials/21_claim_rewards`
1.  `npm i`
1.  `npm run dev-server` or `npm run start`
1.  After a few moments, the server should be running at [http://localhost:3000/](http://localhost:3000/)


---
