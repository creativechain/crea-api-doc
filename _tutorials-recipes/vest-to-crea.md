---
title: Converting VESTS to CREA
position: 1
description: How to convert VESTS to CREA or CREA POWER
exclude: true
layout: full
---

### Intro

Crea's has base unit is VESTS and usually user doesn't know about this unit because everything is dynamically calucated and presented in CREA form for convenience of the user. In this recipe we will talk about how converting is working behind the scenes on all Crea apps. Dynamic Global Properties are used in this recipe to fetch the current values of global blockchain properties.

## Steps

1. [**Get Dynamic Global Properties**](#get-global) Fetch current values of global blockchain properties
1. [**Formulate VESTS_TO_CREA**](#formula) Formulate function that will convert given VESTS to CREA.    


#### 1. Get Dynamic Global Properties <a name="get-global"></a>

Following method can be used to fetch global values

```bash
curl -s --data '{"jsonrpc":"2.0", "method":"condenser_api.get_dynamic_global_properties", "params":[], "id":1}' https://nodes.creary.net
```

##### Example Output<a style="float: right" href="#steps"><i class="fas fa-chevron-up fa-sm" /></a>

```json
{
   "id":1,
   "jsonrpc":"2.0",
   "result":{
      "head_block_number":24238248,
      "head_block_id":"0171d8a833dc369abd034b0c67d8725f96df9e5b",
      "time":"2018-07-16T22:41:24",
      "current_witness":"xeldal",
      "total_pow":514415,
      "num_pow_witnesses":172,
      "virtual_supply":"283434761.199 CREA",
      "current_supply":"271729171.190 CREA",
      "confidential_supply":"0.000 CREA",
      "current_sbd_supply":"15498201.173 CBD",
      "confidential_sbd_supply":"0.000 CBD",
      "total_vesting_fund_crea":"192913644.627 CREA",
      "total_vesting_shares":"391296886352.617261 VESTS",
      "total_reward_fund_crea":"0.000 CREA",
      "total_reward_shares2":"0",
      "pending_rewarded_vesting_shares":"379159224.860656 VESTS",
      "pending_rewarded_vesting_crea":"185294.019 CREA",
      "sbd_interest_rate":0,
      "sbd_print_rate":2933,
      "maximum_block_size":65536,
      "current_aslot":24315228,
      "recent_slots_filled":"340282366920938463463374607431768211400",
      "participation_count":128,
      "last_irreversible_block_num":24238230,
      "vote_power_reserve_rate":10,
      "average_block_size":10950,
      "current_reserve_ratio":200000000,
      "max_virtual_bandwidth":"264241152000000000000"
   }
}
```

#### 2. Formulate VESTS_TO_CREA <a name="formula"></a><a style="float: right" href="#steps"><i class="fas fa-chevron-up fa-sm" /></a>

From above results we have everything we need to calculate CREA from given VESTS value.

Let's say we have been given `availableVESTS` variable, value in VESTS and we want to convert that to CREA. By using values from above returned object our formula would be as follows:

```
vestCrea = ( result.total_vesting_fund_crea x availableVESTS ) / result.total_vesting_shares
```

That's it!
