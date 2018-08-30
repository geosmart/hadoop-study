#!/bin/bash
bin/hdfs namenode -format -nonInteractive

echo "start namenode daemon"
bin/hdfs --daemon start namenode
sleep 2

echo "set 777 permissions to /"
bin/hdfs dfs -chmod 777 /

echo "set dr.who owner from all /"
bin/hdfs dfs -chown -R dr.who:dr.who /

while :; do
  sleep 5
	echo "Isso será executado infinitamente até que seja pressionado [CTRL+C]."
done