---
title: 'PY: Claim Rewards'
position: 23
description: "How to claim rewards using Python."
layout: full
---              
<span class="fa-pull-left top-of-tutorial-repo-link"><span class="first-word">Full</span>, runnable src of [Claim Rewards](https://github.com/creativechain/crea-api-doc-tutorials-py/tree/master/tutorials/23_claim_rewards) can be downloaded as part of the [PY tutorials repository](https://github.com/creativechain/crea-api-doc-tutorials-py).</span>
<br>



In this tutorial we show you how to check the CREA, CBD and CREA POWER rewards balances of an account on the **Crea** blockchain, and how to claim either a portion or all of the rewards for an account using the `commit` class found within the [crea-python](https://github.com/creativechain/crea-python) library.

## Intro

The Crea python library has a built-in function to transmit transactions to the blockchain. We are using the `claim_reward_balance` method found within the `commit` class in the library. Before we transmit a claim, we use the `get_account` function to check the current rewards balance of the account to see what is available to claim. The `claim` method has 4 parameters:

1.  _reward crea_ - The amount of CREA to claim
1.  _reward sbd_ - The amount of CBD to claim
1.  _reward vests_ - The amount of VESTS (CREA POWER) to claim
1.  _account_ - The source account for the claim

## Steps

1.  [**App setup**](#setup) - Library install and import. Connection to testnet
1.  [**User information and crea node**](#userinfo) - Input user information and connection to Crea node
1.  [**Check reward balance**](#balance) - Check current rewards balances of user account
1.  [**Claim commit**](#commit) - Input amount of rewards to claim and commit to blockchain
1.  [**Balance update**](#update) - Check new rewards balances after completed claim

#### 1. App setup <a name="setup"></a>

In this tutorial we use 2 packages:

- `crea` - crea-python library and interaction with Blockchain
- `pick` - helps select the query type interactively

We import the libraries and connect to the `testnet`.

```python
import creabase
import crea
from pick import pick
from crea.amount import Amount

creabase.chains.known_chains['CREA'] = {
    'chain_id': '79276aea5d4877d9a25892eaa01b0adf019d3e5cb12a97478df3298ccdd01673',
    'prefix': 'STX', 'crea_symbol': 'CREA', 'sbd_symbol': 'CBD', 'vests_symbol': 'VESTS'
}
```

Because this tutorial alters the blockchain we connect to a testnet so we don't create spam on the production server.

#### 2. User information and crea node <a name="userinfo"></a>

We require the `private active key` of the user in order for the claim to be committed to the blockchain. This is why we are using a testnet. The values are supplied via the terminal/console before we initialise the crea class. There are some demo accounts available but we encourage you to create your own accounts on this testnet and create balances you can claim; it's good practice.

```python
#capture user information
username = input('Enter username: ') #demo account: cdemo
wif = input('Enter private ACTIVE key: ') #demo account: 5KaNM84WWSqzwKzY82fXPaUW43idbLnPqf5SfjGxLfw6eV2kAP3

#connect node
client = crea.Crea(nodes=['https://testnet.crea.vc'],keys=[wif])
```

#### 3. Check reward balance <a name="balance"></a>

We send a query to the blockchain using the `get_account` function to check if the username exists on the blockchain. We also use this function to get a clear picture of the available rewards that can be claimed and display this on the console/terminal.

```python
#get account reward balances
userinfo = client.get_account(username)

if(userinfo is None) :
    print('Oops. Looks like user ' + username + ' doesn\'t exist on this chain!')
    exit()

reward_crea = userinfo['reward_crea_balance']
reward_sbd = userinfo['reward_sbd_balance']
reward_sp = userinfo['reward_vesting_crea']
reward_vests = userinfo['reward_vesting_balance']

print('Reward Balances:' + '\n' + 
    'CREA: ' + reward_crea + '\n' + 
    'CBD: ' + reward_sbd + '\n' + 
    'CREA POWER: ' + reward_sp + '\n' +
    'VESTS: ' + reward_vests
    )

input('\n' + 'Press enter to continue to claim selection')
```

#### 4. Claim commit <a name="commit"></a>

An option is provided to either claim all rewards at once or to specify specific amounts to be claimed for each individual reward balance. If you are using one of Creary's demo accounts, please leave some rewards for others to claim!

```python
#choice of claim
title = 'Please choose claim type: '
options = ['ALL', 'SELECTED', 'CANCEL']
option, index = pick(options, title)
```

When the option to claim all rewards is selected, the claim parameters are automatically assigned from the `get_accounts` query. We also check that there are in fact outstanding rewards balances before we commit the claim.

```python
#commit claim based on selection
if option == 'ALL':
    if Amount(reward_crea).amount + Amount(reward_sbd).amount + Amount(reward_vests).amount == 0:
        print('\n' + 'No rewards to claim')
        exit()
    else:
        client.claim_reward_balance(reward_crea, reward_sbd, reward_vests, username)
        print('\n' + 'All reward balances have been claimed. New reward balances are:' + '\n')
else:
    if option == 'CANCEL':
        print('\n' + 'Operation cancelled')
        exit()
    else:
        claim_crea = input('\n' + 'Please enter the amount of CREA to claim: ') + ' CREA'
        claim_sbd = input('Please enter the amount of CBD to claim: ') + ' CBD'
        claim_vests = input('Please enter the amount of VESTS to claim: ') + ' VESTS'
        if Amount(claim_crea).amount + Amount(claim_sbd).amount + Amount(claim_vests).amount == 0:
            print('\n' + 'Zero values entered, no claim to submit')
            exit()
        else:
            if claim_crea > reward_crea or claim_sbd > reward_sbd or claim_vests > reward_vests:
                print('\n' + 'Requested claim value higher than available rewards')
                exit()
            else:
                client.claim_reward_balance(claim_crea, claim_sbd, claim_vests, username)
                print('\n' + 'Claim has been processed. New reward balances are:' + '\n')

```

When doing only a selected claim of available rewards, the values are captured in the console/terminal. The inputs cannot be negative, must be less than or equal to the available reward and at least ONE of the inputs needs to be greater than zero for the claim to be able to transmit. The result of the selected option is printed on the UI.

#### 5. Balance update <a name="update"></a>

As a final check we run the account query again to get updated values for the available rewards balances.

```python
#get updated account reward balances
input("Press enter for new account balances")

userinfo = client.get_account(username)

reward_crea = userinfo['reward_crea_balance']
reward_sbd = userinfo['reward_sbd_balance']
reward_sp = userinfo['reward_vesting_crea']
reward_vests = userinfo['reward_vesting_balance']

print('CREA: ' + reward_crea + '\n' + 
    'CBD: ' + reward_sbd + '\n' + 
    'CREA POWER: ' + reward_sp + '\n' +
    'VESTS: ' + reward_vests
    )
```

We encourage users to play around with different values and data types to fully understand how this process works. You can also check the balances and transaction history on the [testnet portal](http://condenser.crea.vc/).

### To Run the tutorial

1.  [review dev requirements](getting_started)
1.  clone this repo
1.  `cd tutorials/23_claim_rewards`
1.  `pip install -r requirements.txt`
1.  `python index.py`
1.  After a few moments, you should see a prompt for input in terminal screen.


---
