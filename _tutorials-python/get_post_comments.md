---
title: 'PY: Get Post Comments'
position: 7
description: "Fetch comments made on each content or post using Python."
layout: full
---              
<span class="fa-pull-left top-of-tutorial-repo-link"><span class="first-word">Full</span>, runnable src of [Get Post Comments](https://github.com/creativechain/crea-api-doc-tutorials-py/tree/master/tutorials/07_get_post_comments) can be downloaded as part of the [PY tutorials repository](https://github.com/creativechain/crea-api-doc-tutorials-py).</span>
<br>



This tutorial will explain and show you how to access the **Crea** blockchain using the [crea-python](https://github.com/creativechain/crea-python) library to fetch list of posts and get replies info on selected post.

## Intro

Crea python library has built-in function to get active voters information if post with author and permlink as an argument. Since we don't have predefined post or author/permlink. We will fetch post list from previous tutorial and give option to choose one post to get its active voters. `get_content_replies` function fetches list of replies on content. Note that `get_discussions_by_skyrockets` filter is used for fetching 5 posts and after selection of post tutorial uses `author` and `permlink` of the post to fetch replies. 

## Steps

1.  [**App setup**](#app-setup) - Library install and import
1.  [**Post list**](#post-list) - List of posts to select from created filter 
1.  [**Replies list**](#replies-list) - Get replies list for selected post
1.  [**Print output**](#print-output) - Print results in output

#### 1. App setup <a name="app-setup"></a>

In this tutorial we use 3 packages, `pick` - helps us to select filter interactively. `crea` - crea-python library, interaction with Blockchain. `pprint` - print results in better format.

First we import all three library and initialize Crea class

```python
    import pprint
    from pick import pick
    # initialize Crea class
    from crea import Crea

    s = Crea()
```

#### 2. Post list <a name="post-list"></a>


Next we will fetch and make list of posts and setup `pick` properly.

```python
    query = {
        "limit":5, #number of posts
        "tag":"" #tag of posts
        }
    #post list for selected query
    posts = s.get_discussions_by_skyrockets(query)

    title = 'Please choose post: '
    options = []
    #posts list options
    for post in posts:
        options.append(post["author"]+'/'+post["permlink"])
    # get index and selected filter name
    option, index = pick(options, title)
```

This will show us list of posts to select in terminal/command prompt. And after selection we will get index and post name to `index` and `option` variables.

#### 3. Replies list <a name="replies-list"></a>

Next we will replies on selected post with `get_content_replies`. 

```python
  # get replies for given post
  replies = s.get_content_replies(posts[index]["author"],posts[index]["permlink"])
```


#### 4. Print output <a name="print-output"></a>

Next, we will print result, replies on selected post, selected post details and number of replies.

```python
  # print post details for selected post
  pprint.pprint(replies)
  pprint.pprint("Selected: "+option)
  pprint.pprint("Number of replies: "+str(len(replies)))
```

The example of result returned from the service is a `JSON` object with the following properties:

```json
[{'abs_rshares': 0,
  'active': '2018-06-15T10:43:36',
  'active_votes': [],
  'allow_curation_rewards': True,
  'allow_replies': True,
  'allow_votes': True,
  'author': 'sarcasms',
  'author_reputation': 1086863019,
  'author_rewards': 0,
  'beneficiaries': [],
  'body': 'follow us for news, media, memes, sports updates and lots '
          'more...',
  'body_length': 0,
  'cashout_time': '2018-06-22T10:43:36',
  'category': 'fiction',
  'children': 0,
  'children_abs_rshares': 0,
  'created': '2018-06-15T10:43:36',
  'curator_payout_value': '0.000 CBD',
  'depth': 1,
  'id': 53110589,
  'json_metadata': '{"tags":["fiction"],"users":["sarcasms"],"app":"creary/0.1"}',
  'last_payout': '1970-01-01T00:00:00',
  'last_update': '2018-06-15T10:43:36',
  'max_accepted_payout': '1000000.000 CBD',
  'max_cashout_time': '1969-12-31T23:59:59',
  'net_rshares': 0,
  'net_votes': 0,
  'parent_author': 'muratkbesiroglu',
  'parent_permlink': 'short-sci-fi-story-the-android-that-sell-meaning',
  'pending_payout_value': '0.000 CBD',
  'percent_crea_dollars': 10000,
  'permlink': 're-muratkbesiroglu-short-sci-fi-story-the-android-that-sell-meaning-20180615t104323737z',
  'promoted': '0.000 CBD',
  'reblogged_by': [],
  'replies': [],
  'reward_weight': 10000,
  'root_author': 'muratkbesiroglu',
  'root_permlink': 'short-sci-fi-story-the-android-that-sell-meaning',
  'root_title': 'Short Sci-Fi Story: The Android That Sell Meaning',
  'title': '',
  'total_payout_value': '0.000 CBD',
  'total_pending_payout_value': '0.000 CREA',
  'total_vote_weight': 0,
  'url': '/fiction/@muratkbesiroglu/short-sci-fi-story-the-android-that-sell-meaning#@sarcasms/re-muratkbesiroglu-short-sci-fi-story-the-android-that-sell-meaning-20180615t104323737z',
  'vote_rshares': 0},
 {'abs_rshares': 0,
  'active': '2018-06-15T11:26:15',
  'active_votes': [],
  'allow_curation_rewards': True,
  'allow_replies': True,
  'allow_votes': True,
  'author': 'vicky3585',
  'author_reputation': 40338001,
  'author_rewards': 0,
  'beneficiaries': [],
  'body': 'lovely story keep it up...',
  'body_length': 0,
  'cashout_time': '2018-06-22T11:26:15',
  'category': 'fiction',
  'children': 0,
  'children_abs_rshares': 0,
  'created': '2018-06-15T11:26:15',
  'curator_payout_value': '0.000 CBD',
  'depth': 1,
  'id': 53114015,
  'json_metadata': '{"tags":["fiction"],"app":"creary/0.1"}',
  'last_payout': '1970-01-01T00:00:00',
  'last_update': '2018-06-15T11:26:15',
  'max_accepted_payout': '1000000.000 CBD',
  'max_cashout_time': '1969-12-31T23:59:59',
  'net_rshares': 0,
  'net_votes': 0,
  'parent_author': 'muratkbesiroglu',
  'parent_permlink': 'short-sci-fi-story-the-android-that-sell-meaning',
  'pending_payout_value': '0.000 CBD',
  'percent_crea_dollars': 10000,
  'permlink': 're-muratkbesiroglu-short-sci-fi-story-the-android-that-sell-meaning-20180615t112615204z',
  'promoted': '0.000 CBD',
  'reblogged_by': [],
  'replies': [],
  'reward_weight': 10000,
  'root_author': 'muratkbesiroglu',
  'root_permlink': 'short-sci-fi-story-the-android-that-sell-meaning',
  'root_title': 'Short Sci-Fi Story: The Android That Sell Meaning',
  'title': '',
  'total_payout_value': '0.000 CBD',
  'total_pending_payout_value': '0.000 CREA',
  'total_vote_weight': 0,
  'url': '/fiction/@muratkbesiroglu/short-sci-fi-story-the-android-that-sell-meaning#@vicky3585/re-muratkbesiroglu-short-sci-fi-story-the-android-that-sell-meaning-20180615t112615204z',
  'vote_rshares': 0}]
'Selected: muratkbesiroglu/short-sci-fi-story-the-android-that-sell-meaning'
'Number of replies: 18'
```

From this result you have access to everything associated to the replies including content of reply, author, timestamp, etc., so that you can be use in further development of application with Python.

That's it!

### To Run the tutorial

1.  [review dev requirements](getting_started)
1.  clone this repo
1.  `cd tutorials/07_get_post_comments`
1.  `pip install -r requirements.txt`
1.  `python index.py`
1.  After a few moments, you should see output in terminal/command prompt screen.



---
