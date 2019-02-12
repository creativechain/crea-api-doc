---
title: 'JS: Blog Feed'
position: 1
description: "_By the end of this tutorial you should know how to fetch most recent five posts from particular user on Crea._"
layout: full
---              
<span class="fa-pull-left top-of-tutorial-repo-link"><span class="first-word">Full</span>, runnable src of [Blog Feed](https://github.com/creativechain/crea-api-doc-tutorials-js/tree/master/tutorials/01_blog_feed) can be downloaded as part of the [JS tutorials repository](https://github.com/creativechain/crea-api-doc-tutorials-js).</span>
<br>



This tutorial pulls a list of the most recent five user's posts from the blockchain and displays them in simple list. Also some notes about usage of `client.database.getDiscussions` API.

## Intro

Tutorial is demonstrates the typical process of fetching account blog posts. It is quite useful if you want to embedd your blog posts on your website these tutorial will help you achieve that goal as well. This tutorial will explain and show you how to access the **Crea** blockchain using the [dcrea](https://github.com/jnordberg/dcrea) library to build a basic blog list of posts filtered by a _tag_

## Steps

1.  [**Configure connection**](#Configure-connection) Configuration of dcrea to use proper connection and network
1.  [**Query format**](#Query-format) Simple query format to help use fetch data
1.  [**Fetch data and format**](#Fetch-data-and-format) Fetch data and display in proper interface

---

#### 1. Configure connection<a name="Configure-connection"></a>

In order to connect to the live Crea network, all we have to do is provide connection url to a server that runs on the network. `dcrea` by default set up to use live network but it has flexibility to adjust connection to any other testnet or custom networks, more on that in future tutorials.

In first couple lines we require package and define connection server:

```
const { Client } = require('dcrea');

const client = new Client('https://node1.creary.net');
```

#### 2. Query format<a name="Query-format"></a>

*   You can add a tag to filter the blog posts that you receive from the server, since we are aiming to fetch blog posts of particular user, we will define username as tag.
*   You can also limit the number of results you would like to receive from the query

```javascript
var query = {
    tag: 'crearyblog', // This tag is used to filter the results by a specific post tag
    limit: 5, // This limit allows us to limit the overall results returned to 5
};
```

#### 3. Fetch data and format<a name="Fetch-data-and-format"></a>

`client.database.getDiscussions` function is used for fetching discussions or posts. The first argument to this function determines which equivalent of the appbase `condenser_api.get_discussions_by_*` api calls it's going to use.  Below is example of query and keyword **'blog'** indicates `condenser_api.get_discussions_by_blog` and somewhat counter-intuitively _query.tag_ indicates the account from which we want to get posts.

```
    client.database
        .getDiscussions('blog', query)
        .then(result => {
            var posts = [];
            result.forEach(post => {
                const json = JSON.parse(post.json_metadata);
                const image = json.image ? json.image[0] : '';
                const title = post.title;
                const author = post.author;
                const created = new Date(post.created).toDateString();
                posts.push(
                    `<div class="list-group-item"><h4 class="list-group-item-heading">${title}</h4><p>by ${author}</p><center><img src="${image}" class="img-responsive center-block" style="max-width: 450px"/></center><p class="list-group-item-text text-right text-nowrap">${created}</p></div>`
                );
            });

            document.getElementById('postList').innerHTML = posts.join('');
        })
        .catch(err => {
            alert('Error occured' + err);
        });
```

The result returned form the service is a `JSON` object with the following properties:

```json
[
    {
        "id": 37338948,
        "author": "crearyblog",
        "permlink": "join-team-creary-at-tokenfest",
        "category": "creary",
        "parent_author": "",
        "parent_permlink": "creary",
        "title": "Join Team Creary at TokenFest!",
        "body":
            "<a href=\"https://tokenfest.adria.digital\"><img src=\"https://i.imgur.com/fOScDIW.png\"/></a>\n\nHello Crearians! If you’d like to meet Team Creary live-in-person, or are just interested in attending what promises to be a great blockchain conference, join us at <a href=\"https://tokenfest.adria.digital/\">TokenFest</a> in San Francisco from March 15th to 16th. \n\nCreary CEO, Ned Scott, will be participating in a fireside chat alongside Creary’s CTO, Harry Schmidt, as well as the creator of Utopian.io, Diego Pucci. Creary will also be hosting the opening party on Thursday night and we’d certainly love to meet as many of you as possible IRL, so head on over to https://tokenfest.adria.digital/ and get your tickets while you can. \n\n*Team Creary*",
        "json_metadata":
            "{\"tags\":[\"creary\",\"tokenfest\",\"conference\"],\"image\":[\"https://i.imgur.com/fOScDIW.png\"],\"links\":[\"https://tokenfest.adria.digital\",\"https://tokenfest.adria.digital/\"],\"app\":\"creary/0.1\",\"format\":\"markdown\"}",
        "last_update": "2018-03-07T23:22:54",
        "created": "2018-03-07T20:56:36",
        "active": "2018-03-13T01:40:21",
        "last_payout": "1970-01-01T00:00:00",
        "depth": 0,
        "children": 29,
        "net_rshares": "11453442114933",
        "abs_rshares": "11454054795840",
        "vote_rshares": "11454054795840",
        "children_abs_rshares": "13568695606090",
        "cashout_time": "2018-03-14T20:56:36",
        "max_cashout_time": "1969-12-31T23:59:59",
        "total_vote_weight": 3462435,
        "reward_weight": 10000,
        "total_payout_value": "0.000 CBD",
        "curator_payout_value": "0.000 CBD",
        "author_rewards": 0,
        "net_votes": 77,
        "root_comment": 37338948,
        "max_accepted_payout": "0.000 CBD",
        "percent_crea_dollars": 10000,
        "allow_replies": true,
        "allow_votes": true,
        "allow_curation_rewards": true,
        "beneficiaries": [],
        "url": "/creary/@crearyblog/join-team-creary-at-tokenfest",
        "root_title": "Join Team Creary at TokenFest!",
        "pending_payout_value": "46.436 CBD",
        "total_pending_payout_value": "0.000 CREA",
        "active_votes": [
            {
                "voter": "crearyblog",
                "weight": 0,
                "rshares": "1870813909383",
                "percent": 10000,
                "reputation": "128210130644387",
                "time": "2018-03-07T20:56:36"
            },
            {
                "voter": "kevinwong",
                "weight": 526653,
                "rshares": "2208942520687",
                "percent": 5000,
                "reputation": "374133832002581",
                "time": "2018-03-08T04:27:00"
            }
        ],
        "replies": [],
        "author_reputation": "128210130644387",
        "promoted": "0.000 CBD",
        "body_length": 754,
        "reblogged_by": []
    }
]
```

From this result we have access to everything associated to the post including additional metadata which is a `JSON` string that must be decoded to use. This `JSON` object has additional information and properties for the post including a reference to the image uploaded. And we are displaying this data in meaningful user interface. _Note: it is truncated to one element, but you would get five posts in array_

That's all there is to it.

### To Run the tutorial

1.  clone this repo
1.  `cd tutorials/01_blog_feed`
1.  `npm i`
1.  `npm run dev-server` or `npm run start`
1.  After a few moments, the server should be running at [http://localhost:3000/](http://localhost:3000/)


---
