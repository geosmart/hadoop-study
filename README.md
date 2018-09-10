hadoop 3 ecosystem
===
This project have a intent to study the hadoop ecosystem for BigData,
starting on haddop 3.1 and going on the newest versions.


# Table of Contents
* [Start](start)
* [hdfs](hdfs)
  - [namenode](namenode)
  - [datanode](datanode)
* [yarn](yarn)
  - [resourcemanager](resource-manager)
  - [nodemanager](node-manager)
* [spark](spark)
* [hive](hive)


# Start
Has created a image that contemples mostly hadoop dependencies and 
according the command pass to entrypoint start one or another service.
This save resources and build time in the final.


## 1) create images

hadoop image
```bash
$ docker build -t hadoop-3 images/hadoop/
```

hue image
```bash
$ docker build -t hue images/hue/
```

**obs1:** The download parts are the more slow, if this is a problem to you if you try refac this image, i recommend to you download the .tar files and use COPY in Dockerfile else download


**obs2:** The data example are from https://www.kaggle.com/abecklas/fifa-world-cup/data


## 2) up docker-compose
```bash
$ docker-compose up
```

## 3) enter in spark docker
```bash
$ docker exec -it spark bash
```

## 4) enter in hive
```bash
$ docker exec -it --network hadoop-3 hive
```


# HDFS
hdfs is the hadoop distributed file system, has divided primarily into 2 main components, that acts like master/slaves

## namenode
Is a master node, that hold metadata, about data localization, permissions, and locations os data blocks etc

```bash
# format metadata 
$ hdfs namenode -format -nonInteractive

# start namenode
$ hdfs --daemon start namenode

# set permissions to all users in root folter
$ hdfs dfs -chmod 777 /

# TODO - ckeck this need
$ hdfs dfs -chown -R dr.who:dr.who /
```

## datanode
Is a slave node, thad holds data, splited in blocks and send herthbeats to namonode, to mantain namenode with updated infos.

```bash
# start datanode
$ hdfs --daemon start namenode
```

# YARN
yarn is the resource manager, has divided in 2 main components to, that acts like master/slaves

## resorce manager
The master node, holds info abount total resources of cluster(memory and cpus) total, useds,
and used jobs.

```bash
# start resourcemanager
$ yarn --daemon start resourcemanager
```

## node manager
The node manager, sends info abount your resources to resource manager.

```bash
# start nodemanager
$ yarn --daemon start nodemanager
```

# SPARK
Spart is a alternative to Hadoop mapReduce layer, but uses memory else disk.


To works, need distribute your dependencies across
system by hdfs

```bash
# make a jar with spark jars
jar cv0f spark-libs.jar -C $SPARK_HOME/jars/ .

# using hdfs cli to send libs to hdsf
$ hdfs dfs -put spark-libs.jar /spark-jars.jar
```

Start a interactive shell of spark
```bash
$ pyspark --master yarn
```

or submit a job to be run
```bash
$ spark-submit \
    --executor-memory 1G \
    --total-executor-cores 1 \
    --master yarn \
    --deploy-mode cluster \
    /pyspark-job.py argument1
```
# HIVE


# HUE
Hue is a django web service UI to manage cluster and hadoop ecosystem services

init hue web service
```bash
$ ./build/env/bin/hue runserver_plus 0.0.0.0:8888
```

docker run -it --network hadoop3study_hadoop -p 8888:8888 hue:latest ./build/env/bin/hue runserver_plus 0.0.0.0:8888