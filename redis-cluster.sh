#!/bin/sh
#下载redis
wget http://download.redis.io/releases/redis-5.0.5.tar.gz
#解压
tar -zxvf redis-5.0.5.tar.gz

REDIS=redis-5.0.5
VERSION=3.0.0

# 安装gcc
yum -y install gcc

cd $REDIS

port=600
ip=192.168.3.29
#编译 
make
make install

#创建文件夹
for i in `seq 1 6`;
do
mkdir ../$port$i;
cp -r redis.conf ../$port$i;

sed -i "s/daemonize no/daemonize yes/g" ../$port$i/redis.conf;
sed -i "s/port 6379/port $port$i/g" ../$port$i/redis.conf;
sed -i "s/bind 127.0.0.1/bind $ip/g" ../$port$i/redis.conf;
sed -i "s/dir ./dir .\/$port$i/g" ../$port$i/redis.conf;
sed -i "s/# cluster-enabled yes/cluster-enabled yes/g" ../$port$i/redis.conf;
sed -i "s/# cluster-config-file nodes-6379.conf/cluster-config-file nodes-$port$i.conf/g" ../$port$i/redis.conf;
sed -i "s/# cluster-node-timeout 15000/cluster-node-timeout 15000/g" ../$port$i/redis.conf;
sed -i "s/appendonly no/appendonly yes/g" ../$port$i/redis.conf;

done

#安装ruby
yum -y install ruby
yum -y install rubygems
gem install redis  --version $VERSION

echo 'success!'

