#!/bin/bash

echo "start YARN nodemanager"
/opt/hadoop/bin/yarn --daemon start nodemanager


while :; do
  sleep 10 
  echo "Isso será executado infinitamente até que seja pressionado [CTRL+C]."
done