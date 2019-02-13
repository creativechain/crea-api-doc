---
title: Crea Testnet
position: 3
layout: full
---

Crea blockchain software is written in C++ and in order to modify the source code you need some understanding of the C++ programming language. Each Crea node runs an instance of this software, so in order to test your changes, you will need to know how to install dependencies which can be found in the [Crea repo](https://github.com/creativechain/crea/blob/master/doc/building.md). This also means that some knowledge of System administration is also required. There are multiple advantages of running a testnet, you can test your scripts or applications on a testnet without extra spam on the live network, which allows much more flexibility to try new things. 
Having access to a testnet also helps you to work on new features and possibly submit new or improved pull requests to official the Crea GitHub repository.

## Running Testnet

By following official [build steps](https://github.com/creativechain/crea/blob/master/doc/building.md#build_crea_testnetoffon) and enabling the `BUILD_CREA_TESTNET` flag during compilation, you should be able to run the Crea Testnet locally on your workstation and join the development testnet. Docker can also be used to get started quickly. Compilation generates the `cread` executable which is the main daemon for the Crea network. Additional `cli_wallet` can also be compiled to test/connect to an instance of `cread` and request some data from the network, but it is not necessary to run a node.

The development testnet requires a certain minimum set of hardware requirements, depending on the type of compile flags that have been enabled. Because it is a mirror of the live network, private keys are the same for accounts up to the point of the snapshot timestamp of the testnet.

Joining/Running the development testnet requires around 10 GB for block log on an SSD and 8 GB RAM. The CPU requirements are the same.

Testnet has the following parameters by default (as of this writing):

* Initial supply (250 billion) - `CREA_INIT_SUPPLY 250,000,000,000`
* Max number of blocks to be produced - `TESTNET_BLOCK_LIMIT 3,000,000`
* Address prefix, prefix on public addresses - `CREA_ADDRESS_PREFIX "TST"`
* Chain id name, used for chain id - `CREA_CHAIN_ID_NAME "testnet"`
* Chain id, unique id hash of chain - `CREA_CHAIN_ID (fc::sha256::hash(CREA_CHAIN_ID_NAME))`
* Public key of genesis account - `CREA_INIT_PUBLIC_KEY_STR `
* Account creation fee - `CREA_MIN_ACCOUNT_CREATION_FEE 0`

There are a number of other subtle changes that we don't need to focus on right now.

#### Live testnet

* ChainID: `46d82ab7d8db682eb1959aed0ada039a6d49afa1602491f93dde9cac3e8e6c32`
* Address prefix: `TST`
* API node: `https://testnet.crearydev.com`

Anyone can join the Live testnet and start testing their node and applications, become a witness, and provide API (RPC) node for public use.

## Custom Testnet

In order to create a custom testnet, separate from the development one, we need to modify a few parameters mentioned in the previous section.

In the file named `crea/libraries/protocol/include/crea/protocol/config.hpp`, we can see the first few lines dedicated to the Testnet section.  The line starts with `#ifdef IS_TEST_NET`.

Let's say we want to create a custom testnet with an initial supply of **1,000,000 CREA**. We can change `CREA_INIT_SUPPLY 1,000,000` and by changing `CREA_CHAIN_ID_NAME "testnet"`, **testnet** to **mytestnet** we will automatically get a unique Chain ID for our testnet. The address prefix can be set to something like **MTN** and of course, we need to change the public and private keys to the genesis account. Note that the genesis account will receive the entire pre-mined supply of 1,000,000.  That way, you can execute a setup script to fund any newly created accounts. Such a custom testnet will not have any additional hardware requirements to run. 

A minimum of 8GB RAM should be sufficient to run a custom testnet. Currently, Crea only has Linux and Mac compiling guides to build. A testnet can either be hosted locally, on a rented AWS, or dedicated bare metal servers so one can start testing functionality, explore different APIs, and start developing.

One more crucial point to modify is to change the number of witnesses required to accept hardforks for a custom testnet, by default it is set to 17, we can change it to **1** `CREA_HARDFORK_REQUIRED_WITNESSES 1` so that only one node instance would be sufficient and the network will be still functional and fast.

Another thing to note is that you can start a new chain with all previous hardforks already accepted, by changing the file named `crea/blob/master/libraries/chain/database.cpp` with the following function:

`void database::init_genesis( uint64_t init_supply )` inside `try` add this line:

`set_hardfork( 19, true );`

This would mean that 19 hardforks have been accepted by witnesses and the new chain will start with all previous forks included.

After these changes, all we have to do is compile the source code and get the `cread` executable. And once we fire up the custom testnet we can start testing and experimenting.

If you want to port some data from Crea main network you can use [Chinman](https://github.com/creativechain/chinman), also developed by Creary, to help with taking snapshots of the main network.

#### Custom live testnet

* ChainID: `0000000000000000000000000000000000000000000000000000000000000000`
* Address prefix: `CREA`
* API node: `https://node1.creary.net`

The above testnet is experimental network. 
