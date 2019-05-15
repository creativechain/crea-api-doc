---
title: cread Nodes
position: 2
exclude: true
---

Applications that interface directly with the Crea blockchain will need to connect to a `cread` node. Developers may choose to use one of the public API nodes that are available, or run their own instance of a node.

### Public Nodes

Although all the nodes listed here support Websocket (`wss://`) and HTTPS (`https://`), it is preferable that you consider the option to use only HTTPS connections.

| URL                             | Owner         |
| ------------------------------- | ------------- |
| nodes.creary.net                | @creary       |
| crea.owldevelopers.site         | @ander7agar   |



For a report on the latest public full nodes, check the latest posts on [@fullnodeupdate](https://creary.net/@fullnodeupdate) by [@holger80](https://creary.net/@holger80).  Another excellent tool for checking real-time full node status is [geo.crea.pl](https://geo.crea.pl) by [@jamzed](https://creary.net/@jamzed).


### Private Nodes

The simplest way to get started is by deploying a pre-built dockerized container.

##### Dockerized p2p Node

_To run a p2p node (ca. 2GB of memory is required at the moment):_

##### Dockerized Full Node

_to run a node with all the data (e.g. for supporting a content website) that uses ca. 14GB of memory and growing:_

### Syncing blockchain

Normally syncing blockchain starts from very first, `0` genesis block. It might take long time to catch up with live network. Because it connectes to various p2p nodes in the Crea network and requests blocks from 0 to head block. It stores blocks in block log file and builds up the current state in the shared memory file. But there is a way to bootstrap syncing by using trusted `block_log` file. The block log is an external append only log of the blocks. It contains blocks that are only added to the log after they are irreversible because the log is append only.

Trusted block log file helps to download blocks faster. 

##### Few other tricks that might help: 

For Linux users, virtual memory writes dirty pages of the shared file out to disk more often than is optimal which results in cread being slowed down by redundant IO operations. These settings are recommended to optimize reindex time.

```
echo    75 | sudo tee /proc/sys/vm/dirty_background_ratio
echo  1000 | sudo tee /proc/sys/vm/dirty_expire_centisecs
echo    80 | sudo tee /proc/sys/vm/dirty_ratio
echo 30000 | sudo tee /proc/sys/vm/dirty_writeback_centisecs
```

Another settings that can be changed in `config.ini` is `flush` - it is to specify a target number of blocks to process before flushing the chain database to disk. This is needed on Linux machines and a value of 100000 is recommended. It is not needed on OS X, but can be used if desired.

``` bash
docker run \
    -d -p 2001:2001 -p 8090:8090 --name cread-default \
    creary/crea

docker logs -f cread-default  # follow along
``` 
``` bash
docker run \
    --env USE_WAY_TOO_MUCH_RAM=1 \
    -d -p 2001:2001 -p 8090:8090 --name cread-full \
    creary/crea

docker logs -f cread-full
```  
