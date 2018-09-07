#!/bin/bash

if [ "$1" = 'datanode' ]; then
  
  echo "start HDFS datanode"
  bin/hdfs --daemon start datanode

  tail -f $(find logs/*.log)
fi


if [ "$1" = 'namenode' ]; then

  echo "start HDFS namenode"
  bin/hdfs namenode -format -nonInteractive

  echo "start namenode daemon"
  bin/hdfs --daemon start namenode
  sleep 2

  echo "set 777 permissions to /"
  bin/hdfs dfs -chmod 777 /

  echo "set dr.who owner from all /"
  bin/hdfs dfs -chown -R dr.who:dr.who /

  tail -f $(find logs/*.log)
fi



if [ "$1" = 'nodemanager' ]; then

  echo "start YARN nodemanager"
  /opt/hadoop/bin/yarn --daemon start nodemanager


  tail -f $(find logs/*.log)
fi


if [ "$1" = 'resourcemanager' ]; then

  echo "start YARN resourcemanager"
  /opt/hadoop/bin/yarn --daemon start resourcemanager

  echo "start SPARK master"
  /opt/spark/sbin/start-master.sh
  
  echo "start SPARK slave"
  /opt/spark/sbin/start-slave.sh spark:7077


  echo "disable safe mode in hdfs"
  /opt/hadoop/bin/hadoop dfsadmin -safemode leave

  echo "distribute spark jars in hdfs"
  /opt/hadoop/bin/hdfs dfs -put spark-libs.jar /spark-jars.jar
  
  # echo "start YARN proxyserver"
  # /opt/hadoop/bin/yarn --daemon start proxyserver

  echo "send data to hdfs"
  /opt/hadoop/bin/hdfs dfs -mkdir /data
  /opt/hadoop/bin/hdfs dfs -put /data/* /data/

  # echo "init spark interactive"
  # using spark cluster 
  # bin/pyspark --master spark://spark:7077

  # using yarn cluster
  # bin/pyspark --master yarn
  tail -f $(find /opt/hadoop/logs/*.log)
fi

# example of submit spark
# spark-submit \
# --executor-memory 20G \
# --total-executor-cores 100 \
# --master yarn \
# --deploy-mode cluster \
# /pyspark-examples/count_lines.py argument1
