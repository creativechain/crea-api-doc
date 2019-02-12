---
title: 'JS: Transfer Crea And Sbd'
position: 21
description: "_Transfer both CREA and CBD from one account to another._"
layout: full
---              
<span class="fa-pull-left top-of-tutorial-repo-link"><span class="first-word">Full</span>, runnable src of [Transfer Crea And Sbd](https://github.com/creativechain/crea-api-doc-tutorials-js/tree/master/tutorials/21_transfer_crea_and_sbd) can be downloaded as part of the [JS tutorials repository](https://github.com/creativechain/crea-api-doc-tutorials-js).</span>
<br>



This tutorial will take you through the process of preparing and submitting a `transfer` using the `broadcast` operation. Two demo accounts are provided to use on the `testnet` but all variables can be easily changed and applied to the `production server`.

There is also an alternative method to transfer from one account to another using a `hot signing` link that can be generated via [Creaconnect](https://creaconnect.com/sign/). You create a link using the `to` account, the amount, and a `memo` (optional comments). This [link](https://creaconnect.com/sign/transfer?to=crearyblog&amount=1.000%20CREA) then allows you to do a transfer simply by adding the login details of the `from` account. This is a very simple way to send a payment request to any other user with the correct details already provided by the link.

## Intro

We are using the `broadcast.transfer` function provided by the `dcrea` library to send the transaction through to the network. In order to do the transfer, two accounts are required. One the sender and the other the recipient. You also can't transfer from and to the same account, which is why two accounts have been provided for this tutorial. There are 6 parameters required for the transfer operation:

1.  _Username_ - The username of the account making the transfer (`from` account)
2.  _Privatekey_ - This is the private `active` key of the sender
3.  _Recipient_ - The account that is receiving the CREA or CBD (`to` account)
4.  _Memo_ - This is a text field which can be used for a comment on the transfer or it can be left empty
5.  _Amount_ - This is the amount of CREA to transfer. This has to be a positive value with 3 decimals in order for the transaction to be completed
6.  _Type_ - This is the currency of the transfer, CREA or CBD. This value has to be written ALL CAPS in order for the transaction to be completed

It is noteworthy that Crea Power (VESTS) cannot be transferred with this operation.

## Steps

1.  [**Configure connection**](#connection) Configuration of `dcrea` to communicate with a Crea blockchain
2.  [**Input variables**](#input) Collecting the required inputs via an HTML UI
3.  [**Object creation**](#object) Creating an object to use in the broadcast operation
4.  [**Broadcast**](#broadcast) Broadcasting the transfer to the blockchain

#### 1. Configure connection<a name="connection"></a>

As usual, we have a `public/app.js` file which holds the Javascript segment of the tutorial. In the first few lines we define the configured library and packages:

```javascript
const dcrea = require('dcrea');
//define network parameters
let opts = {};
opts.addressPrefix = 'STX';
opts.chainId =
    '79276aea5d4877d9a25892eaa01b0adf019d3e5cb12a97478df3298ccdd01673';
//connect to a crea node, testnet in this case
const client = new dcrea.Client('https://testnet.crea.vc', opts);
```

Above, we have `dcrea` pointing to the test network with the proper chainId, addressPrefix, and endpoint.  
Because this tutorial modifies the blockchain, we will use a testnet and predefined accounts to demonstrate the transfer process.

#### 2. Input variables<a name="input"></a>

The required parameters for the transfer operation is recorded via an HTML UI that can be found in the `public/index.html` file. The values are prepopulated in this case with testnet `demo` accounts. The transfer amount is set to `1.000` but any value can be input as long as the sender has enough CREA to send.

The parameter values are allocated as seen below, once the user clicks on the "Transfer" button.

```javascript
window.submitTransfer = async () => {
    //get all values from the UI
    //get account name of sender
    const username = document.getElementById('username').value;
    //get private active key
    const privateKey = dcrea.PrivateKey.fromString(
        document.getElementById('privateKey').value
    );
    //get recipient
    const recipient = document.getElementById('recipient').value;
    //get comments
    const comments = document.getElementById('comments').value;
    //get transfer amount
    const quantity = document.getElementById('quantity').value;
    //get transfer type
    const type = document.getElementById('type').value;
```

#### 3. Object creation<a name="object"></a>

In the `broadcast.transfer` operation, the `amount` parameter is a combination of the transfer `value` and `type` which is why we concatenate the two values into a single variable. We then create a `transfer object` with the input variables to use within the broadcast operation.

```javascript
const transfer = quantity.concat(' ', type);

//create transfer object
const transf = new Object();
transf.from = username;
transf.to = recipient;
transf.amount = transfer;
transf.memo = comments;
```

#### 4. Broadcast<a name="broadcast"></a>

We can complete the `broadcast` operation using the created object and the private active key received from the input UI. The result of the transfer is displayed on the UI to confirm whether it was a success or an error occurred. The result is also displayed in the console with the relevant block number or transfer error.

```javascript
client.broadcast.transfer(transf, privateKey).then(
    function(result) {
        console.log(
            'included in block: ' + result.block_num,
            'expired: ' + result.expired
        );
        document.getElementById('transferResultContainer').style.display =
            'flex';
        document.getElementById('transferResult').className =
            'form-control-plaintext alert alert-success';
        document.getElementById('transferResult').innerHTML = 'Success';
    },
    function(error) {
        console.error(error);
        document.getElementById('transferResultContainer').style.display =
            'flex';
        document.getElementById('transferResult').className =
            'form-control-plaintext alert alert-danger';
        document.getElementById('transferResult').innerHTML =
            error.jse_shortmsg;
    }
);
```

### To run this tutorial

1.  clone this repo
2.  `cd tutorials/20_transfer_CREA_and_CBD`
3.  `npm i`
4.  `npm run dev-server` or `npm run start`
5.  After a few moments, the server should be running at http://localhost:3000/


---
