#!/bin/sh

PORT=600
REDIS=redis-5.0.5
IP=192.168.3.29
read=STR

for i in `seq 1 6`;
do
./$REDIS/src/redis-server $PORT$i/redis.conf
STR+="$IP:$PORT$i "

done

./$REDIS/src/redis-cli --cluster create $STR --cluster-replicas 1
