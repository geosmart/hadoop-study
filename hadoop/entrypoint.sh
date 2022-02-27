#!/bin/bash

ip=$(tail -n 1 /etc/hosts | awk '{ print $1}')

echo "Containe IP: $ip"

if [ "$1" = 'datanode' ]; then
  
  sed "s/0.0.0.0/$ip/g" /templates/hdfs-site.xml > /opt/hadoop/etc/hadoop/hdfs-site.xml

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
  hdfs dfs -chmod -R 777 /

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
  /opt/hadoop/bin/yarn --daemon start proxyserver

  tail -f $(find /opt/hadoop/logs/*.log)
fi

if [ "$1" = 'spark' ]; then

  echo "distribute spark jars in hdfs"

  if hdfs dfs -test -e /spark-jars.jar; then
    echo "/spark-jars.jar exists on HDFS"
  else
    { 
      hdfs dfs -put -f spark-libs.jar /spark-jars.jar;
    } || {
      echo "send spark-libs.jar error" && exit 1; 
    }
  fi

  # exec hdfs dfs -put spark-libs.jar /spark-jars.jar

  echo "make dir /data in hdfs"
  if hdfs dfs -test -d /data/; then
    echo "/data dir already exists on HDFS"
  else
    { hdfs dfs -mkdir -p /data; } || { echo "make dir /data error" && exit 1; }
  fi

  # assume that if one of files existes all them exists too
  if hdfs dfs -test -e /data/WorldCups.csv; then
    echo "/data/* already exists on HDFS"
  else
    { hdfs dfs -put /data/* /data/; } || { echo "send data error" && exit 1; }
  fi

  if hdfs dfs -test -d /spark/logs; then
    echo "/spark/logs dir already exists on HDFS"
  else
    { hdfs dfs -mkdir -p /spark/logs; } || { echo "make dir /spark/logs" && exit 1; }
  fi


  # echo "start SPARK master"
  # /opt/spark/sbin/start-master.sh
  
  # echo "start SPARK slave"
  # /opt/spark/sbin/start-slave.sh spark:7077

  # livy has developed initialy by HUE
  echo "start livy Server"
  livy-server start
  
  tail -f /opt/livy/logs/livy--server.out 

  # echo "init spark interactive"
  # using spark cluster 
  # pyspark --master spark://spark:7077

  # using yarn cluster
  # pyspark --master yarn

  # local
  # pyspark --master local[4]



  # example of submit spark
  # --executor-memory:
  # is related to yarn.scheduler.maximum-allocation-mb' and 'yarn.nodemanager.resource.memory-mb
  # example
  spark-submit --master yarn --deploy-mode cluster --executor-memory 2G /pyspark-examples/rdd/count_lines.py /data/report5.txt


  # spark-submit \
  #   --executor-memory 2G \
  #   --total-executor-cores 1 \
  #   --master yarn \
  #   --deploy-mode cluster \
  #   /pyspark-examples/$2 $3
fi

if [ "$1" = 'hive' ]; then
  
  sleep 15
 
  hdfs dfs -mkdir       /tmp
  hdfs dfs -mkdir       /user/hive/warehouse
  hdfs dfs -chmod g+w   /tmp
  hdfs dfs -chmod g+w   /user/hive/warehouse
  # https://cwiki.apache.org/confluence/display/Hive/Hive+Schema+Tool
  schematool -dbType derby -initSchema
  hive --service hiveserver2
#  create database world_cups;
#  beeline -u jdbc:hive2://localhost:10000/default --hiveconf hive.execution.engine=spark

fi