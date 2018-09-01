#!/bin/bash
bin/hdfs --daemon start datanode

while :; do
  sleep 10 
  echo "Isso será executado infinitamente até que seja pressionado [CTRL+C]."
done