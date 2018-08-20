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

```bash
# Running and get a Bash interpreter
$ docker run -p 22022:22 -p 8020:8020 -p 50010:50010 -p 50020:50020 -p 50070:50070 -p 50075:50075 -it mdouchement/hdfs

# With NFS
$ docker run -p 22022:22 -p 8020:8020 -p 50010:50010 -p 50020:50020 -p 50070:50070 -p 50075:50075 -p 111:111 -p 2049:2049 -it mdouchement/hdfs

# Running as daemon
$ docker run -p 22022:22 -p 8020:8020 -p 50010:50010 -p 50020:50020 -p 50070:50070 -p 50075:50075 -d mdouchement/hdfs
```

### Mapped Ports
- Ports
  - Portmap -> `111`
  - NFS -> `2049`
  - HDFS namenode -> `8020` (hdfs://localhost:8020)
  - HDFS datanode -> `50010`
  - HDFS datanode (ipc) -> `50020`
  - HDFS Web browser -> `50070`
  - HDFS datanode (http) -> `50075`
  - HDFS secondary namenode -> `50090`
  - SSH -> `22`


## HTTP Api

**Explore In Browser:**

[http://localhost:50070](http://localhost:50070)


## Create a folder

PUT  http://localhost:50070/webhdfs/v1/clicks?op=MKDIRS

**Use as reference:**
[https://hadoop.apache.org/docs/r1.0.4/webhdfs.html](https://hadoop.apache.org/docs/r1.0.4/webhdfs.html)


## CLI
inside docker

```bash
$ hadoop fs  -ls /
```
OR

```bash
$ hdfs dfs -ls /
```