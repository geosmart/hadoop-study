#!/bin/bash

echo "start YARN resourcemanager"
/opt/hadoop/bin/yarn --daemon start resourcemanager


while :; do
  sleep 10 
  echo "Isso será executado infinitamente até que seja pressionado [CTRL+C]."
done