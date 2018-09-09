hadoop 3 ecosystem
===
# Table of Contents
* [Start](start)
* hdfs
  - namenode
  - datanode
* yarn
  - nodemanager
  - resourcemanager
* spark
* hive


# Start
## 1) create hadoop image

```bash
$ docker build -t hadoop-3 hadoop/
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
$ docker run -it  --network hadoop_hadoop hadoop-3 hive
```



# HDFS
hdfs is the hadoop distributed file system

# YARN

# SPARK

# HIVE



