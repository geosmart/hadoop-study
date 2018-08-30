# HDFS Docker
Docker image for single HDFS node for study.

Based on [https://github.com/mdouchement/docker-hdfs](https://github.com/mdouchement/docker-hdfs)

# Table of Content
* [Build](build)
* [Run](run)
* [Http Api](http-api)

## Build
```bash
$ docker build -t mdouchement/hdfs .
```

## Run

Use network host to can access datanodes
```bash
# Running and get a Bash interpreter
$ docker run --network=host -it mdouchement/hdfs
```

### Mapped Ports
- Ports
  - webapi -> `9870`


## HTTP Api

**Explore In Browser:**

[http://localhost:9870](http://localhost:9870)


## Create a folder

PUT  http://localhost:9870/webhdfs/v1/clicks?op=MKDIRS

**Use as reference:**
[https://hadoop.apache.org/docs/3.1.1/webhdfs.html](https://hadoop.apache.org/docs/3.1.1/webhdfs.html)


## CLI
inside docker

```bash
$ hadoop fs -ls /
```
OR

```bash
$ hdfs dfs -ls /
```