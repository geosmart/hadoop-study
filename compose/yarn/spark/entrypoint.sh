#!/bin/bash

echo "start YARN resourcemanager"
/opt/hadoop/bin/yarn --daemon start resourcemanager

# echo "start YARN proxyserver"
# /opt/hadoop/bin/yarn --daemon start proxyserver


# echo "init spark interactive"
# SPARK_HOME=/opt/spark/ HADOOP_CONF_DIR=/opt/hadoop/etc/hadoop/ bin/pyspark --master yarn

while :; do
  sleep 5
	echo "Isso será executado infinitamente até que seja pressionado [CTRL+C]."
done