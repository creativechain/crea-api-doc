<p align="center">
  <img src="https://raw.githubusercontent.com/creary/devportal/master/images/creadev.png" alt="Creary API Portal" width="226">
  <br>
  <br>
  
</p>

# Creary API Portal

Creary is the social media platform where everyone gets paid for creating and curating content.

The following API documents provide details on how to interact with the Crea blockchain database API which can get information on accounts, content, blocks and much more!

The developer portal will also serve as a toolbox for crea clients, libraries, and language wrappers.

## Develop

Creary Portal was built with [Jekyll](http://jekyllrb.com/) version 3.1.6, but should support newer versions as well.

Install the dependencies with [Bundler](http://bundler.io/):

~~~bash
$ bundle install
~~~

Run `jekyll` commands through Bundler to ensure you're using the right versions:

~~~bash
$ bundle exec jekyll serve
~~~

You can now test locally at
~~~bash
http://localhost:4000
~~~

Optionally, when running `jekyll` commands through Bundler, append `--host x.x.x.x` with the external IP address of the server to be able to connect remotely:
~~~bash
$ bundle exec jekyll serve --host x.x.x.x
~~~
~~~bash
http://x.x.x.x:4000
~~~

## Rake Tasks

This application uses `rake` (Ruby's make command) to execute maintenance tasks.  You can see the complete list of tasks by typing:

```bash
$ bundle exec rake -T
```

### Production Deploy

When you're ready to deploy this application to production, make sure you have nothing to commit and your working tree is clean, then type:

```bash
$ bundle exec rake production:deploy
```

The above command will deploy the current site to `gh-pages`.

To reverse a previous bad deploy, use:

```bash
$ bundle exec rake production:rollback
```

### Managing API Definitions

This application maintains a copy of API Definitions in `_data/apidefinitions` in YAML format.  The purpose of these `.yml` files is to reflect details of each method.

In order to accurately synchronize the `.yml` files, we've added a `rake` task to evaluate the current state of the actual API, as reflected by the `jsonrpc` methods.

This command will check the current state of the API Definitions, report any differences, and write a new `.yml` file if these differences exist:

```bash
$ bundle exec rake scrape:api_defs
```

Typical output:

```
Definitions for: account_by_key_api, methods: 1
Definitions for: account_history_api, methods: 3
Definitions for: condenser_api, methods: 85
Definitions for: database_api, methods: 46
Definitions for: follow_api, methods: 10
Definitions for: jsonrpc, methods: 2
Definitions for: market_history_api, methods: 7
Definitions for: network_broadcast_api, methods: 3
Definitions for: tags_api, methods: 20
Definitions for: witness_api, methods: 2
Methods added or changed: 0
```

If you're interested in running the scrape against a different server, run the command like so:

```bash
$ TEST_NODE=<some server url> bundle exec rake scrape:api_defs
```

An example pointing at the crearydev testnet:

```bash
$ TEST_NODE=https://testnet.crearydev.com bundle exec rake scrape:api_defs
```

### Importing

To import all new tutorials from all known tutorial repositories, which is the typical use case:

```bash
bundle exec rake scrape:tutorials
```

#### Targeted Import: [devportal-tutorials-js](https://github.com/creativechain/crea-api-doc-tutorials-js/tree/master/tutorials)

This command will check for new tutorials in `devportal-tutorials-js` and import them into this project.

```bash
bundle exec rake scrape:tutorials:js
```

To force update on a particular tutorial, use the following command:

```bash
bundle exec rake scrape:tutorials:js[1,true]
```

Where `1` represents the numerical prefix like in `01_blog_feed` and `true` instructs the task to overwrite what's there, even if it exists.

Other Targeted imports supported are `:py` and `:js` using the same syntax.

#### Targeted Import: [devportal-tutorials-py](https://github.com/creativechain/crea-api-doc-tutorials-py/tree/master/tutorials)

```bash
bundle exec rake scrape:tutorials:py
```

#### Targeted Import: [devportal-tutorials-rb](https://github.com/creativechain/crea-api-doc-tutorials-rb/tree/master/tutorials)

```bash
bundle exec rake scrape:tutorials:rb
```

### Tests

To test all `curl` examples, use the following `rake` task:

```bash
$ bundle exec rake test:curl
```

Or, to test specific API namespaces, use:

```bash
$ bundle exec rake test:curl["follow_api witness_api"]
```

If you're interested in running this test against a different server, run the command like so

```bash
$ TEST_NODE=<some server url> bundle exec rake test:curl
```

An example pointing at the crearydev testnet

```bash
$ TEST_NODE=https://testnet.crearydev.com bundle exec rake test:curl
```
