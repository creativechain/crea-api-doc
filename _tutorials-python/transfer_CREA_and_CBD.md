---
title: 'PY: Transfer Crea And Sbd'
position: 21
description: "How to transfer CREA and CBD to another account using Python."
layout: full
---              
<span class="fa-pull-left top-of-tutorial-repo-link"><span class="first-word">Full</span>, runnable src of [Transfer Crea And Sbd](https://github.com/creativechain/crea-api-doc-tutorials-py/tree/master/tutorials/21_transfer_crea_and_sbd) can be downloaded as part of the [PY tutorials repository](https://github.com/creativechain/crea-api-doc-tutorials-py).</span>
<br>



In this tutorial we will explain and show you how to to check the CREA and CBD balance of an account and also how to transfer a portion of that to another user on the **Crea** blockchain using the `commit` class found within the [crea-python](https://github.com/creativechain/crea-python) library.

## Intro

The Crea python library has a built-in function to transmit transactions to the blockchain. We are using the `transfer` method found within the `commit` class in the library. Before we do the transfer, we check the current balance of the account to ensure that there are sufficient funds available. We also check if the intended recipient of the transfer is a valid user account. This is not strictly necessary as the process will automatically abort with the corresponding error, but it does give some insight into the process as a whole. We use the `get_account` function to check for this. The `transfer` method has 5 parameters:

1.  _to_ - The intended recipient of the funds transfer
1.  _amount_ - The amount of CREA or CBD that the user wants to transfer. This parameter has to be of the `float` data type and is rounded up to 3 decimal spaces
1.  _asset_ - A string value specifying whether `CREA` or `CBD` is being transferred
1.  _memo_ - An optional text field containing comments on the transfer. This value may begin with '#' for encrypted messaging
1.  _account_ - The account that the funds are being transferred from

## Steps

1.  [**App setup**](#setup) - Library install and import. Connection to testnet
1.  [**User information and crea node**](#userinfo) - Input user information and connection to Crea node
1.  [**Check balance**](#balance) - Check current CREA and CBD balance of user account
1.  [**Recipient input**](#recipient) - Check for valid recipient account name
1.  [**Transfer type and amount**](#amount) - Input of transfer type and the amount to transfer
1.  [**Transfer commit**](#commit) - Commit of transfer to blockchain

#### 1. App setup <a name="setup"></a>

In this tutorial we use 2 packages:

- `crea` - crea-python library and interaction with Blockchain
- `pick` - helps select the query type interactively

We import the libraries and connect to the `testnet`.

```python
import creabase
import crea
from pick import pick

creabase.chains.known_chains['CREA'] = {
    'chain_id': '79276aea5d4877d9a25892eaa01b0adf019d3e5cb12a97478df3298ccdd01673',
    'prefix': 'STX', 'crea_symbol': 'CREA', 'sbd_symbol': 'CBD', 'vests_symbol': 'VESTS'
}
```

Because this tutorial alters the blockchain we connect to the testnet so we don't create spam on the production server.

#### 2. User information and crea node <a name="userinfo"></a>

We require the `private active key` of the user in order for the transfer to be committed to the blockchain. This is why we have to specify this alongside the `testnet` node. The values are supplied via the terminal/console before we initialise the crea class. There is a demo account available to use with this tutorial but any account that is set up on the testnet can be used.

```python
#capture user information
username = input('Enter username: ') #demo account: cdemo
wif = input('Enter private ACTIVE key: ') #demo account: 5KaNM84WWSqzwKzY82fXPaUW43idbLnPqf5SfjGxLfw6eV2kAP3

#connect node and private active key
client = crea.Crea(nodes=['https://testnet.crea.vc'], keys=[wif])
```

#### 3. Check balance <a name="balance"></a>

In order to give the user enough information to make the transfer we check the current balance of the account using the `get_account` function.

```python
#get account balance for CREA and CBD
userinfo = client.get_account(username)
total_crea = userinfo['balance']
total_sbd = userinfo['sbd_balance']

print('CURRENT ACCOUNT BALANCE:' + '\n' + total_crea + '\n' + total_sbd + '\n')
```

The result of the query is displayed in the console/terminal.

#### 4. Recipient input <a name="recipient"></a>

The recipient account is input via the console/terminal and then a check is done whether that username does in fact exist.

```python
#get recipient name
recipient = input('Enter the user you wish to transfer funds to: ')

#check for valid recipient name
result = client.get_account(recipient)
```

The query will return a null value if the account does not match to anything on the blockchain. This result is then used to determine the next step.

#### 5. Transfer type and amount <a name="amount"></a>

If the query in the previous step returns a valid result the user is then given a choice of transfer types or to cancel the operation completely. If the username is not found the process aborts.

```python
if result:
    #choice of transfer
    title = 'Please choose transfer type: '
    options = ['CREA', 'CBD', 'Cancel Transfer']
    # get index and selected transfer type
    option, index = pick(options, title)
else:
    print('Invalid recipient for funds transfer')
    exit()
```

Once the user chooses the type of transfer we proceed to assign the amount as well as the `asset` parameter.

```python
if option == 'Cancel Transfer':
    print('Transaction cancelled')
    exit()
else:
    if option == 'CREA':
        #get CREA transfer amount
        amount = input('Enter amount of CREA to transfer to ' + recipient + ': ')
        asset = 'CREA'
    else:
        #get CBD transfer amount
        amount = input('Enter amount of CBD to transfer to ' + recipient + ': ')
        asset = 'CBD'
```

#### 6. Transfer commit <a name="commit"></a>

Once all the parameters have been assigned we can proceed with the actual commit to the blockchain.

```python
#parameters: to, amount, asset, memo='', account
client.transfer(recipient, float(amount), asset, '', username)
print('\n' + amount + ' ' + asset + ' has been transferred to ' + recipient)
```

The `memo` parameter can be left empty as in the above example. A simple confirmation is printed on the UI.
As an added confirmation we check the balance of the user again and display it on the UI. This is not required at all but it serves as a more definitive confirmation that the transfer has been completed correctly.

```python
#get remaining account balance for CREA and CBD
userinfo = client.get_account(username)
total_crea = userinfo['balance']
total_sbd = userinfo['sbd_balance']

print('\n' + 'REMAINING ACCOUNT BALANCE:' + '\n' + total_crea + '\n' + total_sbd + '\n')
```

We encourage users to play around with different values and data types to fully understand how this process works. You can also check the balances and transaction history on the [testnet portal](http://condenser.crea.vc/).

### To Run the tutorial

1.  [review dev requirements](getting_started)
1.  clone this repo
1.  `cd tutorials/21_transfer_crea_and_sbd`
1.  `pip install -r requirements.txt`
1.  `python index.py`
1.  After a few moments, you should see a prompt for input in terminal screen.

---
