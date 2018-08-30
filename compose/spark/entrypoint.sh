#!/bin/bash

echo "start YARN resourcemanager"
/opt/hadoop/bin/yarn --daemon start resourcemanager
sleep 2

echo "start YARN nodemanager"
/opt/hadoop/bin/yarn --daemon start nodemanager

echo "start YARN proxyserver"
/opt/hadoop/bin/yarn --daemon start proxyserver

echo "start historyServer"
/opt/hadoop/bin/mapred --daemon start historyserver

echo "init spark interactive"
SPARK_HOME=/opt/spark/ HADOOP_CONF_DIR=/opt/hadoop/etc/hadoop/ bin/pyspark --master yarn

# while :; do
#   sleep 5
# 	echo "Isso será executado infinitamente até que seja pressionado [CTRL+C]."
# done