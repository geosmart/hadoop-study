hadoop 3 ecosystem
===
This project have a intent to study the hadoop ecosystem for BigData,
starting on haddop 3.1 and going on the newest versions.


# Table of Contents
* [Start](#start)
* [Components](#components)
  - [Hdfs](#hdfs)
    * [Namenode](#namenode)
    * [Datanode](#datanode)
  - [Yarn](#yarn)
    * [Resourcemanager](#resource-manager)
    * [Nodemanager](#node-manager)
  - [Spark](#spark)
    * [Livy](#livy)
    * [Oozie](#oozie)
  - [Hive](#hive)
* [Roadmap](#roadmap)
* [Contributors](#contributors)


# Start
Has created a image that contemples mostly hadoop dependencies and 
according the command pass to entrypoint start one or another service.
This save resources and build time in the final.

About Hue
https://www.cloudera.com/documentation/enterprise/6/latest/topics/hue.html
## 1) Images

```bash
# hadoop image
$ docker build -t hadoop-3 hadoop/
```

 - The download steps are the more slow, if this is a problem for you try refac this image, i recommend to you download the .tar files and use `COPY` in Dockerfile else download


 - The data examples are from https://www.kaggle.com/abecklas/fifa-world-cup/data


## 2) Compose
```bash
$ docker-compose up
```

## 3) Open Hue
Open 
[Hue](http://localhost:8888)
in your favorite web browser

other UI

* [Hive](localhost:10002)
* [Hdfs - Namenode](localhost:9870)
* [Yarn - Resource Manager](localhost:8088)
* [Spark - Worker](localhost:8081)
* [Spark - Master](localhost:8080)
* [Spark - Livy](localhost:8998/ui)



# Components

## HDFS
**hdfs** is the hadoop distributed file system, has divided primarily into 2 main components, that acts like **master** & **slaves**

### Namenode
Is a master node, that hold metadata, about data localization, permissions, and locations of data blocks etc

```bash
# format metadata 
$ hdfs namenode -format -nonInteractive

# start namenode
$ hdfs --daemon start namenode

# set permissions to all users in root folder
$ hdfs dfs -chmod 777 /

# TODO - ckeck this need
$ hdfs dfs -chown -R dr.who:dr.who /
```

### Datanode
Is a slave node, that holds data, splited in blocks and send heartbeats to namenode, to keep namenode with updated infos.

```bash
# start datanode
$ hdfs --daemon start namenode
```

## Yarn
yarn is the resource manager, has divided in 2 main components to, that acts like **master** & **slaves**

### resorce manager
The master node, holds info about total resources of cluster(memory and cpus): total, used, and used by jobs.

```bash
# start resourcemanager
$ yarn --daemon start resourcemanager
```

### node manager
The node manager, sends info about your resources to resource manager.

```bash
# start nodemanager
$ yarn --daemon start nodemanager
```

### yarn-mapreduce-example
```s
hadoop jar  share/hadoop/mapreduce/hadoop-mapreduce-examples-3.1.1.jar  \
wordcount /hello.txt /output
```

## Spark
**Spark** is a alternative to Hadoop mapReduce layer, but uses memory else disk.


To works, need distribute your dependencies across system by hdfs.

```bash
# make a jar with spark jars
jar cv0f spark-libs.jar -C $SPARK_HOME/jars/ .

# using hdfs cli to send libs to hdsf
$ hdfs dfs -put spark-libs.jar /spark-jars.jar
```

Start a interactive shell
```bash
$ pyspark --master yarn --deploy-mode cluster
```

or submit a job
```bash
$ spark-submit \
    --executor-memory 1G \
    --total-executor-cores 1 \
    --master yarn \
    --deploy-mode cluster \
    /pyspark-job.py argument1
```

### Livy
Originally as part of **Hue** project **Lyve**
has webservice that provide a interactive spark session by rest API.
In a way that can be integrated with other UI, to helps the development of spark jobs.

### Oozie
TODO - install oozie in cluester and explain

## Hive
**hive** is a SQL engine atop jobs as mapr or spark.
```bash
# define a metastore engine(pg, mysql, derby) to store your metadatas and init it (derby in this case)
$ schematool -dbType derby -initSchema

# init hive server
$ hive --service hiveserver2
```


# Hue
**Hue** is a Django based web service UI to manage cluster and hadoop ecosystem services.

init hue web service
```bash
$ ./build/env/bin/hue runserver_plus 0.0.0.0:8888
```

# Roadmap

* Install Oozie and integrates with **Hue**
* ~Config **Hue** to not show unused services~
* Use a secondary namenode
* Integrate Build of images with docker-compose (if possible)

# Contributors
- Luiz Carlos Zamboni: luizamboni2002@hotmail.com

And a special thanks for my lovely companion: **Gerusa Fernandes** for patience in long hours of study.