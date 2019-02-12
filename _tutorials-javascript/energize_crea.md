---
title: 'JS: Energize Crea'
position: 24
description: "_Energize an account's Crea using either Creaconnect or a client-side signing._"
layout: full
---              
<span class="fa-pull-left top-of-tutorial-repo-link"><span class="first-word">Full</span>, runnable src of [Energize Crea](https://github.com/creativechain/crea-api-doc-tutorials-js/tree/master/tutorials/24_energize_crea) can be downloaded as part of the [JS tutorials repository](https://github.com/creativechain/crea-api-doc-tutorials-js).</span>
<br>



This tutorial runs on the main Crea blockchain. And accounts queried are real users with liquid CREA balances.

## Intro

This tutorial will show few functions such as querying account by name and getting account balance. We are using the `call` function provided by the `dcrea` library to pull account from the Crea blockchain. A simple HTML interface is used to capture the account and its CREA balance as well as allowing interactively energize part or all of CREA to choose account.

## Steps

1.  [**App setup**](#app-setup) Setup `dcrea` to use the proper connection and network.
2.  [**Search account**](#search-account) Get account details after input has account name
3.  [**Fill form**](#fill-form) Fill form with account reward balances
4.  [**Energize**](#power-up) Energize CREA with Creaconnect or Client-side signing.

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
    const _account = await client.database.call('get_accounts', [[accSearch]]);
    console.log(`_account:`, _account);
```

#### 3. Fill form <a name="fill-form"></a>

After we fetched account data, we will fill form with CREA balance and show current balance details.

```javascript
const name = _account[0].name;
const crea_balance = _account[0].balance;
const balance = `Available Crea balance for ${name}: ${crea_balance}<br/>`;
document.getElementById('accBalance').innerHTML = balance;
document.getElementById('crea').value = crea_balance;
const receiver = document.getElementById('receiver').value;
```

#### 4. Energize <a name="power-up"></a>

We have 2 options on how to Energize. Creaconnect and Client-side signing options. By default we generate Creaconnect link to Energize (transfer to vesting), but you can use client signing option to Energize right inside tutorial, note client-side signing will require Active private key to perform operation.

In order to enable client signing, we will generate operation and also show Active Private key (wif) field to sign transaction right there client side.
Below you can see example of operation and signing transaction, after successful operation broadcast result will be shown in user interface. It will be block number that transaction was included.

```javascript
window.submitTx = async () => {
    const privateKey = dcrea.PrivateKey.fromString(
        document.getElementById('wif').value
    );
    const op = [
        'transfer_to_vesting',
        {
            from: document.getElementById('username').value,
            to: document.getElementById('receiver').value,
            amount: document.getElementById('crea').value,
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
1.  `cd tutorials/22_energize_crea`
1.  `npm i`
1.  `npm run dev-server` or `npm run start`
1.  After a few moments, the server should be running at [http://localhost:3000/](http://localhost:3000/)


---
