---
title: Understanding Configuration Values
position: 1
description: Low level blockchain constants
exclude: true
layout: full
---

### Intro

These values underpin the behavior of the entire blockchain.  In a sense, each witness votes for these configuration values every time they sign a block.  Unlike many of the [Dynamic Global Properties]({{ '/tutorials-recipes/understanding-dynamic-global-properties' | relative_url }}), these values never change at runtime (e.g., as a witness, in order to change them, you typically must shut down your node, make the change, recompile, and run).

See: [config.hpp](https://github.com/creativechain/crea/blob/master/libraries/protocol/include/crea/protocol/config.hpp)

Usually, these configuration values are universally adhered to, but there are situations where these values can and should be altered, like in the case of deploying a new blockchain (typically a testnet).  Some of the values that do not affect consensus, like [`CREA_SOFT_MAX_COMMENT_DEPTH`](#crea_soft_max_comment_depth), are allowed to change to some extent.

### Sections

* Fields
  * [`IS_TEST_NET`](#is_test_net)
  * [`CREA_ENABLE_SMT`](#crea_enable_smt)
  * [`CREA_INITIAL_VOTE_POWER_RATE`](#crea_initial_vote_power_rate)
  * [`CREA_REDUCED_VOTE_POWER_RATE`](#crea_reduced_vote_power_rate)
  * [`CREA_ADDRESS_PREFIX`](#crea_address_prefix)
  * [`CREA_BLOCK_INTERVAL`](#crea_block_interval)
  * [`CREA_CASHOUT_WINDOW_SECONDS`](#crea_cashout_window_seconds)
  * [`CREA_CHAIN_ID`](#crea_chain_id)
  * [`CREA_CHAIN_ID_NAME`](#crea_chain_id_name)
  * [`CREA_CREATE_ACCOUNT_DELEGATION_RATIO`](#crea_create_account_delegation_ratio)
  * [`CREA_CREATE_ACCOUNT_DELEGATION_TIME`](#crea_create_account_delegation_time)
  * [`CREA_FEED_HISTORY_WINDOW`](#crea_feed_history_window)
  * [`CREA_GENESIS_TIME`](#crea_genesis_time)
  * [`CREA_HARDFORK_REQUIRED_WITNESSES`](#crea_hardfork_required_witnesses)
  * [`CREA_INFLATION_NARROWING_PERIOD`](#crea_inflation_narrowing_period)
  * [`CREA_MAX_ACCOUNT_NAME_LENGTH`](#crea_max_account_name_length)
  * [`CREA_MAX_ACCOUNT_WITNESS_VOTES`](#crea_max_account_witness_votes)
  * [`CREA_MAX_WITNESSES`](#crea_max_witnesses)
  * [`CREA_MAX_PERMLINK_LENGTH`](#crea_max_permlink_length)
  * [`CREA_MAX_WITNESS_URL_LENGTH`](#crea_max_witness_url_length)
  * [`CREA_MIN_REPLY_INTERVAL`](#crea_min_reply_interval)
  * [`CREA_MIN_REPLY_INTERVAL_HF20`](#crea_min_reply_interval_hf20)
  * [`CREA_MIN_ROOT_COMMENT_INTERVAL`](#crea_min_root_comment_interval)
  * [`CREA_MIN_PAYOUT_CBD`](#crea_min_payout_sbd)
  * [`CREA_NULL_ACCOUNT`](#crea_null_account)
  * [`CREA_REVERSE_AUCTION_WINDOW_SECONDS`](#crea_reverse_auction_window_seconds)
  * [`CREA_SOFT_MAX_COMMENT_DEPTH`](#crea_soft_max_comment_depth)
  * [`CREA_SAVINGS_WITHDRAW_TIME`](#crea_savings_withdraw_time)
  * [`CREA_UPVOTE_LOCKOUT_HF17`](#crea_upvote_lockout_hf17)
  * [`CREA_VESTING_WITHDRAW_INTERVALS`](#crea_vesting_withdraw_intervals)
* [Not Covered](#not-covered)
* [Example Method Call](#example-method-call)
* [Example Output](#example-output)

### `IS_TEST_NET`<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

Indicates if this node is running on testnet.  See: [Crea Testnet]({{ '/quickstart/#quickstart-testnet' | relative_url }})

### `CREA_ENABLE_SMT`<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

Indicates if Smart Media Tokens have been enabled (future hardfork).

### `CREA_INITIAL_VOTE_POWER_RATE`<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

The rate used prior to HF19.  The number of votes an account may cast per day before voting power is impacted (originally 40 votes per day).

### `CREA_REDUCED_VOTE_POWER_RATE`<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

The rate used since HF19.  The number of votes an account may cast per day before voting power is impacted (10 votes per day).

### `CREA_ADDRESS_PREFIX`<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

Address prefix used on mainnet is `STM` and on testnet is `TST`.  See: [Crea Testnet]({{ '/quickstart/#quickstart-testnet' | relative_url }})

### `CREA_BLOCK_INTERVAL`<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

Block interval in seconds is `3`.  This is the target for block production.  This constant is also used as a component for determining valid peer inventory, bandwidth calculations, and block production gaps.

### `CREA_CASHOUT_WINDOW_SECONDS`<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

This value was simply set to 7 days, [since HF17](https://github.com/creativechain/crea/releases/tag/v0.17.0).

Prior to this, other very complicated machinations were tried like multiple payouts and an initial 24 hours (prior to HF12) and even initial 12 hours ([in HF12](https://github.com/creativechain/crea/issues/177)) all with time extensions depending on how much of an upvote the content got.

Note, on testnet, this is typically much shorter: 1 hour.  See: [Crea Testnet]({{ '/quickstart/#quickstart-testnet' | relative_url }})

### `CREA_CHAIN_ID`<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

The chain ID to connect to, which is used to seed signing and prevent transaction crosstalk between two chains, typically mainnet and testnet.  See: [Crea Testnet]({{ '/quickstart/#quickstart-testnet' | relative_url }})

### `CREA_CHAIN_ID_NAME`<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

Tyically used to automatically get a unique chain id for a testnet.  See: [Crea Testnet]({{ '/quickstart/#quickstart-testnet' | relative_url }})

### `CREA_CREATE_ACCOUNT_DELEGATION_RATIO`<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

This ratio is set to 5 and is used to determine the cost of an account created with delegation.

As an example, imagine the account creation fee is currently `3.000 CREA`.  Instead of creating the account using pure CREA, there is an option to use delegation so that the blockchain would reduce the creation fee to `0.100 CREA`.  Going this route would require a delegation of `15.000 CREA`, that can be revoked at any time, but will stay in limbo for 30 days after the creation date ([`CREA_CREATE_ACCOUNT_DELEGATION_TIME`](#crea_create_account_delegation_time)).

This minimum CREA ensures that those accounts can transact if the delegation is removed.

### `CREA_CREATE_ACCOUNT_DELEGATION_TIME`<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

There is a minimum delegation period (30 days) and a minimum fee in CREA even when delegating for account creation (derived with [`CREA_CREATE_ACCOUNT_DELEGATION_RATIO`](#crea_create_account_delegation_ratio)).  The minimum period enforces a rate limit on account creation.

Note that delegation can be revoked before 30 days have elapsed from the creation date, but stays in limbo.

### `CREA_FEED_HISTORY_WINDOW`<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

Price feed history window, which is 3.5 days since HF16.

### `CREA_GENESIS_TIME`<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

Scheduled time that the blockchain waited until the first block was produced.  It is represented as the unix epoch of `1458835200`, which is `Thu Mar 24 16:00:00 UTC 2016`.  About five seconds later, the first block was produced.  See: https://cread.com/b/1

### `CREA_HARDFORK_REQUIRED_WITNESSES`<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

The minimum number of Delegated Proof of Stake witnesses required for hardfork.  This guarantees 75% participation on all subsequent rounds.

By default it is set to 17, but when running a testnet, we can change it to 1 so that only one node instance would be sufficient and the network will be still functional and fast.  See: [Crea Testnet]({{ '/quickstart/#quickstart-testnet' | relative_url }})

### `CREA_INFLATION_NARROWING_PERIOD`<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

Inflation narrows 0.01% every 250k blocks, since HF16.  At block 7,000,000, there was a 9.5% instantaneous inflation rate, decreasing to 0.95% at this rate of 0.01% every 250k blocks.  This narrowing will take approximately 20.5 years and will complete on block 220,750,000.

| Year |   Supply    | Inflation | New Supply || Year |   Supply    | Inflation | New Supply |
|------|-------------|-----------|------------||------|-------------|-----------|------------|
| 2016 | 250,000,000 |     9.50% | 23,750,000 || 2031 | 646,511,386 |     3.19% | 20,613,886 |
| 2017 | 273,750,000 |     9.08% | 24,854,398 || 2032 | 667,125,272 |     2.77% | 18,464,106 |
| 2018 | 298,604,398 |     8.66% | 25,854,554 || 2033 | 685,589,378 |     2.35% | 16,090,399 |
| 2019 | 324,458,952 |     8.24% | 26,727,942 || 2034 | 701,679,777 |     1.93% | 13,515,587 |
| 2020 | 351,186,894 |     7.82% | 27,452,027 || 2035 | 715,195,364 |     1.51% | 10,766,608 |
| 2021 | 378,638,921 |     7.40% | 28,004,740 || 2036 | 725,961,973 |     1.08% | 7,874,074 |
| 2022 | 406,643,661 |     6.98% | 28,364,989 || 2037 | 733,836,047 |     0.95% | 6,971,442 |
| 2023 | 435,008,650 |     6.55% | 28,513,181 || 2038 | 740,807,489 |     0.95% | 7,037,671 |
| 2024 | 463,521,832 |     6.13% | 28,431,762 || 2039 | 747,845,160 |     0.95% | 7,104,529 |
| 2025 | 491,953,593 |     5.71% | 28,105,742 || 2040 | 754,949,689 |     0.95% | 7,172,022 |
| 2026 | 520,059,335 |     5.29% | 27,523,204 || 2041 | 762,121,711 |     0.95% | 7,240,156 |
| 2027 | 547,582,539 |     4.87% | 26,675,768 || 2042 | 769,361,868 |     0.95% | 7,308,938 |
| 2028 | 574,258,308 |     4.45% | 25,558,997 || 2043 | 776,670,805 |     0.95% | 7,378,373 |
| 2029 | 599,817,304 |     4.03% | 24,172,733 || 2044 | 784,049,178 |     0.95% | 7,448,467 |
| 2030 | 623,990,038 |     3.61% | 22,521,348 || 2045 | 791,497,645 |     0.95% | 7,519,228 |

### `CREA_MAX_ACCOUNT_NAME_LENGTH`<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

Names must comply with the following grammar ([RFC 1035](https://tools.ietf.org/html/rfc1035#section-2.3.1)), i.e.: a valid name consists of a dot-separated sequence of one or more labels consisting of the following rules:

- Each label is three characters or more
- Each label begins with a letter
- Each label ends with a letter or digit
- Each label contains only letters, digits or hyphens

In addition we require the following:

- All letters are lowercase
- Length is between (inclusive) [CREA_MIN_ACCOUNT_NAME_LENGTH](#crea_min_account_name_length) (3 characters) and CREA_MAX_ACCOUNT_NAME_LENGTH (16 characters)

### `CREA_MAX_ACCOUNT_WITNESS_VOTES`<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

Each account may cast up to 30 witness votes.

### `CREA_MAX_WITNESSES`<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

This value is set to 21, which means there are 21 witnesses cycling to produce blocks.

Every round of block production begins with the shuffling of 21 witnesses: the top 20 witnesses (by vote), plus one randomly-selected standby witness.  Each is given a turn to produce a single block at a fixed rate of one block every 3 seconds.  If a witness does not produce a block in their time slot, then that time slot is skipped, and the next witness produces the next block.

### `CREA_MAX_PERMLINK_LENGTH`<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

A permlink is a unique string identifier for a post/comment, linked to the author of the post/comment.  It must not exceed 256 characters.

### `CREA_MAX_WITNESS_URL_LENGTH`<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

Witnesses may provide a URL in their witness proposal.  It must not exceed 2,048 characters.

### `CREA_MIN_REPLY_INTERVAL`<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

Prior to HF20, comments (replies) could only be broadcasted once every 20 seconds, per account.

### `CREA_MIN_REPLY_INTERVAL_HF20`<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

In HF20, comments (replies) can be broadcasted once every 3 seconds, per account (one comment per account per block).  See: [#2019](https://github.com/creativechain/crea/issues/2019)

### `CREA_MIN_ROOT_COMMENT_INTERVAL`<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

Posts (root comments) can only be broadcasted once every 5 minutes, per account.

### `CREA_MIN_PAYOUT_CBD`<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

Rewards of less than `0.020 CBD` are considered "dust" and will not receive payout.

### `CREA_NULL_ACCOUNT`<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

This defines the `null` account used by the blockchain as the canonical account designated to burn assets.

The blockchain checks *all* asset types transferred to this account, thus, even reward balances and VESTS are burned.  See: [operation_time_tests.cpp](https://github.com/creativechain/crea/blob/d04a62953c3b9ec9aab8ba8051848d8d1da18f0c/tests/tests/operation_time_tests.cpp#L2854)

### `CREA_REVERSE_AUCTION_WINDOW_SECONDS`<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

Prior to HF6, there was no reverse auction logic.  From HF6 to HF19, the reverse auction window is 30 minutes.

In HF20, the reverse action is being reduced to 15 minutes.  See: [#1874](https://github.com/creativechain/crea/issues/1874), [#1878](https://github.com/creativechain/crea/issues/1878)

### `CREA_SOFT_MAX_COMMENT_DEPTH`<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

A comment is nested at a maximum depth of 255.  As a soft limit, it is enforced by the `witness_plugin`.  See: [witness_plugin.cpp](https://github.com/creativechain/crea/blob/62b48877d9f731c3fe00ef818e3324a0a3de3e63/libraries/plugins/witness/witness_plugin.cpp#L224)

Prior to HF17, the maximum comment depth was 6.  See: [#767](https://github.com/creativechain/crea/issues/767)

### `CREA_SAVINGS_WITHDRAW_TIME`<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

This value sets the timelock of 3 days for funds being withdrawn from savings.  Funds can be transferred into savings instantly, but require 72 hours (3 days) to withdraw from savings. This will guarantee there is at least 1 business day during which you can contact your recovery agent.

### `CREA_UPVOTE_LOCKOUT_HF17`<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

Accounts may not increase payout within last 12 hours before payout, since HF17.

### `CREA_VESTING_WITHDRAW_INTERVALS`<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

Sets the power-down rate, which is fulfilled once a week over 13 weeks.

Prior to HF16, this value was 104 weeks.

### `Not Covered`<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

Fields not covered in this recipe are:

* `CBD_SYMBOL`
* `CREA_100_PERCENT`
* `CREA_1_PERCENT`
* `CREA_ACCOUNT_RECOVERY_REQUEST_EXPIRATION_PERIOD`
* `CREA_ACTIVE_CHALLENGE_COOLDOWN`
* `CREA_ACTIVE_CHALLENGE_FEE`
* `CREA_APR_PERCENT_MULTIPLY_PER_BLOCK`
* `CREA_APR_PERCENT_MULTIPLY_PER_HOUR`
* `CREA_APR_PERCENT_MULTIPLY_PER_ROUND`
* `CREA_APR_PERCENT_SHIFT_PER_BLOCK`
* `CREA_APR_PERCENT_SHIFT_PER_HOUR`
* `CREA_APR_PERCENT_SHIFT_PER_ROUND`
* `CREA_BANDWIDTH_AVERAGE_WINDOW_SECONDS`
* `CREA_BANDWIDTH_PRECISION`
* `CREA_BLOCKCHAIN_PRECISION`
* `CREA_BLOCKCHAIN_PRECISION_DIGITS`
* `CREA_BLOCKCHAIN_HARDFORK_VERSION`
* `CREA_BLOCKCHAIN_VERSION`
* `CREA_BLOCKS_PER_DAY`
* `CREA_BLOCKS_PER_HOUR`
* `CREA_BLOCKS_PER_YEAR`
* `CREA_CASHOUT_WINDOW_SECONDS_PRE_HF12`
* `CREA_CASHOUT_WINDOW_SECONDS_PRE_HF17`
* `CREA_COMMENT_REWARD_FUND_NAME`
* `CREA_CONTENT_APR_PERCENT`
* `CREA_CONTENT_CONSTANT_HF0`
* `CREA_CONTENT_REWARD_PERCENT`
* `CREA_CONVERSION_DELAY`
* `CREA_CONVERSION_DELAY_PRE_HF_16`
* `CREA_CREATE_ACCOUNT_WITH_CREA_MODIFIER`
* `CREA_CURATE_APR_PERCENT`
* `CREA_DEFAULT_CBD_INTEREST_RATE`
* `CREA_EQUIHASH_K`
* `CREA_EQUIHASH_N`
* `CREA_FEED_HISTORY_WINDOW_PRE_HF_16`
* `CREA_FEED_INTERVAL_BLOCKS`
* `CREA_INFLATION_RATE_START_PERCENT`
* `CREA_INFLATION_RATE_STOP_PERCENT`
* `CREA_INIT_MINER_NAME`
* `CREA_INIT_PUBLIC_KEY_STR`
* `CREA_INIT_SUPPLY`
* `CREA_INIT_TIME`
* `CREA_IRREVERSIBLE_THRESHOLD`
* `CREA_LIQUIDITY_APR_PERCENT`
* `CREA_LIQUIDITY_REWARD_BLOCKS`
* `CREA_LIQUIDITY_REWARD_PERIOD_SEC`
* `CREA_LIQUIDITY_TIMEOUT_SEC`
* `CREA_MAX_ASSET_WHITELIST_AUTHORITIES`
* `CREA_MAX_AUTHORITY_MEMBERSHIP`
* `CREA_MAX_BLOCK_SIZE`
* `CREA_SOFT_MAX_BLOCK_SIZE`
* `CREA_MAX_CASHOUT_WINDOW_SECONDS`
* `CREA_MAX_COMMENT_DEPTH`
* `CREA_MAX_COMMENT_DEPTH_PRE_HF17`
* `CREA_MAX_FEED_AGE_SECONDS`
* `CREA_MAX_INSTANCE_ID`
* `CREA_MAX_MEMO_SIZE`
* `CREA_MAX_MINER_WITNESSES_HF0`
* `CREA_MAX_MINER_WITNESSES_HF17`
* `CREA_MAX_PROXY_RECURSION_DEPTH`
* `CREA_MAX_RATION_DECAY_RATE`
* `CREA_MAX_RESERVE_RATIO`
* `CREA_MAX_RUNNER_WITNESSES_HF0`
* `CREA_MAX_RUNNER_WITNESSES_HF17`
* `CREA_MAX_SATOSHIS`
* `CREA_MAX_SHARE_SUPPLY`
* `CREA_MAX_SIG_CHECK_DEPTH`
* `CREA_MAX_TIME_UNTIL_EXPIRATION`
* `CREA_MAX_TRANSACTION_SIZE`
* `CREA_MAX_UNDO_HISTORY`
* `CREA_MAX_URL_LENGTH`
* `CREA_MAX_VOTE_CHANGES`
* `CREA_MAX_VOTED_WITNESSES_HF0`
* `CREA_MAX_VOTED_WITNESSES_HF17`
* `CREA_MAX_WITHDRAW_ROUTES`
* `CREA_MIN_ACCOUNT_CREATION_FEE`
* `CREA_MIN_ACCOUNT_NAME_LENGTH`
* `CREA_MIN_BLOCK_SIZE_LIMIT`
* `CREA_MIN_BLOCK_SIZE`
* `CREA_MIN_CONTENT_REWARD`
* `CREA_MIN_CURATE_REWARD`
* `CREA_MIN_PERMLINK_LENGTH`
* `CREA_MIN_VOTE_INTERVAL_SEC`
* `CREA_MINER_ACCOUNT`
* `CREA_MINER_PAY_PERCENT`
* `CREA_MIN_FEEDS`
* `CREA_MINING_REWARD`
* `CREA_MINING_TIME`
* `CREA_MIN_LIQUIDITY_REWARD`
* `CREA_MIN_LIQUIDITY_REWARD_PERIOD_SEC`
* `CREA_MIN_POW_REWARD`
* `CREA_MIN_PRODUCER_REWARD`
* `CREA_MIN_TRANSACTION_EXPIRATION_LIMIT`
* `CREA_MIN_TRANSACTION_SIZE_LIMIT`
* `CREA_MIN_UNDO_HISTORY`
* `CREA_NUM_INIT_MINERS`
* `CREA_OWNER_AUTH_HISTORY_TRACKING_START_BLOCK_NUM`
* `CREA_OWNER_AUTH_RECOVERY_PERIOD`
* `CREA_OWNER_CHALLENGE_COOLDOWN`
* `CREA_OWNER_CHALLENGE_FEE`
* `CREA_OWNER_UPDATE_LIMIT`
* `CREA_POST_AVERAGE_WINDOW`
* `CREA_POST_REWARD_FUND_NAME`
* `CREA_POST_WEIGHT_CONSTANT`
* `CREA_POW_APR_PERCENT`
* `CREA_PRODUCER_APR_PERCENT`
* `CREA_PROXY_TO_SELF_ACCOUNT`
* `CREA_CBD_INTEREST_COMPOUND_INTERVAL_SEC`
* `CREA_SECONDS_PER_YEAR`
* `CREA_RECENT_RSHARES_DECAY_TIME_HF19`
* `CREA_RECENT_RSHARES_DECAY_TIME_HF17`
* `CREA_ROOT_POST_PARENT`
* `CREA_SAVINGS_WITHDRAW_REQUEST_LIMIT`
* `CREA_CBD_START_PERCENT`
* `CREA_CBD_STOP_PERCENT`
* `CREA_SECOND_CASHOUT_WINDOW`
* `CREA_START_MINER_VOTING_BLOCK`
* `CREA_START_VESTING_BLOCK`
* `CREA_TEMP_ACCOUNT`
* `CREA_UPVOTE_LOCKOUT_HF7`
* `CREA_VESTING_FUND_PERCENT`
* `CREA_VESTING_WITHDRAW_INTERVALS_PRE_HF_16`
* `CREA_VESTING_WITHDRAW_INTERVAL_SECONDS`
* `CREA_VOTE_DUST_THRESHOLD`
* `CREA_VOTE_REGENERATION_SECONDS`
* `CREA_SYMBOL`
* `VESTS_SYMBOL`
* `CREA_VIRTUAL_SCHEDULE_LAP_LENGTH`
* `CREA_VIRTUAL_SCHEDULE_LAP_LENGTH2`
* `CREA_MAX_LIMIT_ORDER_EXPIRATION`
* `CREA_DELEGATION_RETURN_PERIOD_HF0`
* `CREA_DELEGATION_RETURN_PERIOD_HF20`

### Example Method Call<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

```bash
curl -s --data '{"jsonrpc":"2.0", "method":"condenser_api.get_config", "params":[], "id":1}' https://nodes.creary.net
```

### Example Output<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

```json
{
   "id":1,
   "jsonrpc":"2.0",
   "result":{
      "IS_TEST_NET":false,
      "CREA_ENABLE_SMT":false,
      "CBD_SYMBOL":null,
      "CREA_INITIAL_VOTE_POWER_RATE":40,
      "CREA_REDUCED_VOTE_POWER_RATE":10,
      "CREA_100_PERCENT":10000,
      "CREA_1_PERCENT":100,
      "CREA_ACCOUNT_RECOVERY_REQUEST_EXPIRATION_PERIOD":"86400000000",
      "CREA_ACTIVE_CHALLENGE_COOLDOWN":"86400000000",
      "CREA_ACTIVE_CHALLENGE_FEE":{"amount":"2000", "precision":3, "nai":"@@000000021"},
      "CREA_ADDRESS_PREFIX":"STM",
      "CREA_APR_PERCENT_MULTIPLY_PER_BLOCK":"102035135585887",
      "CREA_APR_PERCENT_MULTIPLY_PER_HOUR":"119577151364285",
      "CREA_APR_PERCENT_MULTIPLY_PER_ROUND":"133921203762304",
      "CREA_APR_PERCENT_SHIFT_PER_BLOCK":87,
      "CREA_APR_PERCENT_SHIFT_PER_HOUR":77,
      "CREA_APR_PERCENT_SHIFT_PER_ROUND":83,
      "CREA_BANDWIDTH_AVERAGE_WINDOW_SECONDS":604800,
      "CREA_BANDWIDTH_PRECISION":1000000,
      "CREA_BLOCKCHAIN_PRECISION":1000,
      "CREA_BLOCKCHAIN_PRECISION_DIGITS":3,
      "CREA_BLOCKCHAIN_HARDFORK_VERSION":"0.19.0",
      "CREA_BLOCKCHAIN_VERSION":"0.19.10",
      "CREA_BLOCK_INTERVAL":3,
      "CREA_BLOCKS_PER_DAY":28800,
      "CREA_BLOCKS_PER_HOUR":1200,
      "CREA_BLOCKS_PER_YEAR":10512000,
      "CREA_CASHOUT_WINDOW_SECONDS":604800,
      "CREA_CASHOUT_WINDOW_SECONDS_PRE_HF12":86400,
      "CREA_CASHOUT_WINDOW_SECONDS_PRE_HF17":43200,
      "CREA_CHAIN_ID":"0000000000000000000000000000000000000000000000000000000000000000",
      "CREA_CHAIN_ID_NAME":"",
      "CREA_COMMENT_REWARD_FUND_NAME":"comment",
      "CREA_CONTENT_APR_PERCENT":3875,
      "CREA_CONTENT_CONSTANT_HF0":"2000000000000",
      "CREA_CONTENT_REWARD_PERCENT":7500,
      "CREA_CONVERSION_DELAY":"302400000000",
      "CREA_CONVERSION_DELAY_PRE_HF_16":"604800000000",
      "CREA_CREATE_ACCOUNT_DELEGATION_RATIO":5,
      "CREA_CREATE_ACCOUNT_DELEGATION_TIME":"2592000000000",
      "CREA_CREATE_ACCOUNT_WITH_CREA_MODIFIER":30,
      "CREA_CURATE_APR_PERCENT":3875,
      "CREA_DEFAULT_CBD_INTEREST_RATE":1000,
      "CREA_EQUIHASH_K":6,
      "CREA_EQUIHASH_N":140,
      "CREA_FEED_HISTORY_WINDOW":84,
      "CREA_FEED_HISTORY_WINDOW_PRE_HF_16":168,
      "CREA_FEED_INTERVAL_BLOCKS":1200,
      "CREA_GENESIS_TIME":"2016-03-24T16:00:00",
      "CREA_HARDFORK_REQUIRED_WITNESSES":17,
      "CREA_INFLATION_NARROWING_PERIOD":250000,
      "CREA_INFLATION_RATE_START_PERCENT":978,
      "CREA_INFLATION_RATE_STOP_PERCENT":95,
      "CREA_INIT_MINER_NAME":"initminer",
      "CREA_INIT_PUBLIC_KEY_STR":"STM8GC13uCZbP44HzMLV6zPZGwVQ8Nt4Kji8PapsPiNq1BK153XTX",
      "CREA_INIT_SUPPLY":0,
      "CREA_INIT_TIME":"1970-01-01T00:00:00",
      "CREA_IRREVERSIBLE_THRESHOLD":7500,
      "CREA_LIQUIDITY_APR_PERCENT":750,
      "CREA_LIQUIDITY_REWARD_BLOCKS":1200,
      "CREA_LIQUIDITY_REWARD_PERIOD_SEC":3600,
      "CREA_LIQUIDITY_TIMEOUT_SEC":"604800000000",
      "CREA_MAX_ACCOUNT_NAME_LENGTH":16,
      "CREA_MAX_ACCOUNT_WITNESS_VOTES":30,
      "CREA_MAX_ASSET_WHITELIST_AUTHORITIES":10,
      "CREA_MAX_AUTHORITY_MEMBERSHIP":10,
      "CREA_MAX_BLOCK_SIZE":393216000,
      "CREA_SOFT_MAX_BLOCK_SIZE":2097152,
      "CREA_MAX_CASHOUT_WINDOW_SECONDS":1209600,
      "CREA_MAX_COMMENT_DEPTH":65535,
      "CREA_MAX_COMMENT_DEPTH_PRE_HF17":6,
      "CREA_MAX_FEED_AGE_SECONDS":604800,
      "CREA_MAX_INSTANCE_ID":"281474976710655",
      "CREA_MAX_MEMO_SIZE":2048,
      "CREA_MAX_WITNESSES":21,
      "CREA_MAX_MINER_WITNESSES_HF0":1,
      "CREA_MAX_MINER_WITNESSES_HF17":0,
      "CREA_MAX_PERMLINK_LENGTH":256,
      "CREA_MAX_PROXY_RECURSION_DEPTH":4,
      "CREA_MAX_RATION_DECAY_RATE":1000000,
      "CREA_MAX_RESERVE_RATIO":20000,
      "CREA_MAX_RUNNER_WITNESSES_HF0":1,
      "CREA_MAX_RUNNER_WITNESSES_HF17":1,
      "CREA_MAX_SATOSHIS":"4611686018427387903",
      "CREA_MAX_SHARE_SUPPLY":"1000000000000000",
      "CREA_MAX_SIG_CHECK_DEPTH":2,
      "CREA_MAX_TIME_UNTIL_EXPIRATION":3600,
      "CREA_MAX_TRANSACTION_SIZE":65536,
      "CREA_MAX_UNDO_HISTORY":10000,
      "CREA_MAX_URL_LENGTH":127,
      "CREA_MAX_VOTE_CHANGES":5,
      "CREA_MAX_VOTED_WITNESSES_HF0":19,
      "CREA_MAX_VOTED_WITNESSES_HF17":20,
      "CREA_MAX_WITHDRAW_ROUTES":10,
      "CREA_MAX_WITNESS_URL_LENGTH":2048,
      "CREA_MIN_ACCOUNT_CREATION_FEE":1,
      "CREA_MIN_ACCOUNT_NAME_LENGTH":3,
      "CREA_MIN_BLOCK_SIZE_LIMIT":65536,
      "CREA_MIN_BLOCK_SIZE":115,
      "CREA_MIN_CONTENT_REWARD":{"amount":"1000", "precision":3, "nai":"@@000000021"},
      "CREA_MIN_CURATE_REWARD":{"amount":"1000", "precision":3, "nai":"@@000000021"},
      "CREA_MIN_PERMLINK_LENGTH":0,
      "CREA_MIN_REPLY_INTERVAL":20000000,
      "CREA_MIN_REPLY_INTERVAL_HF20":3000000,
      "CREA_MIN_ROOT_COMMENT_INTERVAL":300000000,
      "CREA_MIN_VOTE_INTERVAL_SEC":3,
      "CREA_MINER_ACCOUNT":"miners",
      "CREA_MINER_PAY_PERCENT":100,
      "CREA_MIN_FEEDS":7,
      "CREA_MINING_REWARD":{"amount":"1000", "precision":3, "nai":"@@000000021"},
      "CREA_MINING_TIME":"2016-03-24T17:00:00",
      "CREA_MIN_LIQUIDITY_REWARD":{"amount":"1200000", "precision":3, "nai":"@@000000021" },
      "CREA_MIN_LIQUIDITY_REWARD_PERIOD_SEC":60000000,
      "CREA_MIN_PAYOUT_CBD":{"amount":"20", "precision":3, "nai":"@@000000013"},
      "CREA_MIN_POW_REWARD":{"amount":"1000", "precision":3, "nai":"@@000000021"},
      "CREA_MIN_PRODUCER_REWARD":{"amount":"1000", "precision":3, "nai":"@@000000021"},
      "CREA_MIN_TRANSACTION_EXPIRATION_LIMIT":15,
      "CREA_MIN_TRANSACTION_SIZE_LIMIT":1024,
      "CREA_MIN_UNDO_HISTORY":10,
      "CREA_NULL_ACCOUNT":"null",
      "CREA_NUM_INIT_MINERS":1,
      "CREA_OWNER_AUTH_HISTORY_TRACKING_START_BLOCK_NUM":3186477,
      "CREA_OWNER_AUTH_RECOVERY_PERIOD":"2592000000000",
      "CREA_OWNER_CHALLENGE_COOLDOWN":"86400000000",
      "CREA_OWNER_CHALLENGE_FEE":{"amount":"30000", "precision":3, "nai":"@@000000021"},
      "CREA_OWNER_UPDATE_LIMIT":3600000000,
      "CREA_POST_AVERAGE_WINDOW":86400,
      "CREA_POST_REWARD_FUND_NAME":"post",
      "CREA_POST_WEIGHT_CONSTANT":1600000000,
      "CREA_POW_APR_PERCENT":750,
      "CREA_PRODUCER_APR_PERCENT":750,
      "CREA_PROXY_TO_SELF_ACCOUNT":"",
      "CREA_CBD_INTEREST_COMPOUND_INTERVAL_SEC":2592000,
      "CREA_SECONDS_PER_YEAR":31536000,
      "CREA_RECENT_RSHARES_DECAY_TIME_HF19":"1296000000000",
      "CREA_RECENT_RSHARES_DECAY_TIME_HF17":"2592000000000",
      "CREA_REVERSE_AUCTION_WINDOW_SECONDS":1800,
      "CREA_ROOT_POST_PARENT":"",
      "CREA_SAVINGS_WITHDRAW_REQUEST_LIMIT":100,
      "CREA_SAVINGS_WITHDRAW_TIME":"259200000000",
      "CREA_CBD_START_PERCENT":200,
      "CREA_CBD_STOP_PERCENT":500,
      "CREA_SECOND_CASHOUT_WINDOW":2592000,
      "CREA_SOFT_MAX_COMMENT_DEPTH":255,
      "CREA_START_MINER_VOTING_BLOCK":864000,
      "CREA_START_VESTING_BLOCK":201600,
      "CREA_TEMP_ACCOUNT":"temp",
      "CREA_UPVOTE_LOCKOUT_HF7":60000000,
      "CREA_UPVOTE_LOCKOUT_HF17":"43200000000",
      "CREA_VESTING_FUND_PERCENT":1500,
      "CREA_VESTING_WITHDRAW_INTERVALS":13,
      "CREA_VESTING_WITHDRAW_INTERVALS_PRE_HF_16":104,
      "CREA_VESTING_WITHDRAW_INTERVAL_SECONDS":604800,
      "CREA_VOTE_DUST_THRESHOLD":50000000,
      "CREA_VOTE_REGENERATION_SECONDS":432000,
      "CREA_SYMBOL":null,
      "VESTS_SYMBOL":null,
      "CREA_VIRTUAL_SCHEDULE_LAP_LENGTH":"18446744073709551615",
      "CREA_VIRTUAL_SCHEDULE_LAP_LENGTH2":"340282366920938463463374607431768211455",
      "CREA_MAX_LIMIT_ORDER_EXPIRATION":2419200,
      "CREA_DELEGATION_RETURN_PERIOD_HF0":604800,
      "CREA_DELEGATION_RETURN_PERIOD_HF20":864000
   }
}
```
