#!/bin/bash

if [ "$1" = 'datanode' ]; then
  
  echo "start HDFS datanode"
  hdfs --daemon start datanode

  tail -f $(find logs/*.log)
fi


if [ "$1" = 'namenode' ]; then

  echo "start HDFS namenode"
  hdfs namenode -format -nonInteractive

  echo "start namenode daemon"
  hdfs --daemon start namenode
  sleep 2

  echo "set 777 permissions to /"
  hdfs dfs -chmod 777 /

  echo "set dr.who owner from all /"
  hdfs dfs -chown -R dr.who:dr.who /

  tail -f $(find logs/*.log)
fi



if [ "$1" = 'nodemanager' ]; then

  echo "start YARN nodemanager"
  yarn --daemon start nodemanager


  tail -f $(find logs/*.log)
fi


if [ "$1" = 'resourcemanager' ]; then

  echo "start YARN resourcemanager"
  yarn --daemon start resourcemanager

  echo "disable safe mode in hdfs"
  hadoop dfsadmin -safemode leave


  
  # echo "start YARN proxyserver"
  # /opt/hadoop/bin/yarn --daemon start proxyserver

  tail -f $(find /opt/hadoop/logs/*.log)
fi

if [ "$1" = 'spark' ]; then

  sleep 10

  echo "distribute spark jars in hdfs"
  hdfs dfs -put spark-libs.jar /spark-jars.jar

  echo "send data to hdfs"
  hdfs dfs -mkdir /data
  hdfs dfs -put /data/* /data/

  # echo "start SPARK master"
  # /opt/spark/sbin/start-master.sh
  
  # echo "start SPARK slave"
  # /opt/spark/sbin/start-slave.sh spark:7077

  # echo "init spark interactive"
  # using spark cluster 
  # pyspark --master spark://spark:7077

  # using yarn cluster
  # pyspark --master yarn

  # example of submit spark
  spark-submit \
    --executor-memory 2G \
    --total-executor-cores 1 \
    --master yarn \
    --deploy-mode cluster \
    /pyspark-examples/$2 $3

fi
