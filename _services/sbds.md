---
title: CBDS
position: 5
---

**sbds** is a tool for easily querying the data of the Crea Blockchain.

While providing direct interfaces to several pluggable storage architectures that may be used for querying the blockchain, sbds may also be used as a lower level API upon which other applications can be built.

**Docker Hub**

```
docker run -d creary/sbds
```

**Python 3**
```
pip3 install -e git+git@github.com:creary/sbds.git#egg=sbds
```

**Examples**

Stream blocks 1 to 3450000 from our dev S3 bucket
```
sbds checkpoints get-blocks s3://creary-dev-sbds-checkpoints/gzipped --start 1 --end 3450000
```

Stream blocks 8000000 to the last block from your local copy of our S3 bucket
```
sbds checkpoints get-blocks /home/ubuntu/checkpoints/gzipped --start 8000000
```

Stream all blocks from your local copy of our S3 bucket

```
sbds checkpoints get-blocks /home/ubuntu/checkpoints/gzipped
```

**Routes**

Coming soon.
