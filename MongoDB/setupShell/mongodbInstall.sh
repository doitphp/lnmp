#!/bin/bash

# Check if user is root
if [ $(id -u) != "0" ]; then
    printf "Error: You must be root to run this script!\n"
    exit 1
fi

printf "\n"
printf "===========================\n"
printf " MongoDB v3.0.6 Install	   \n"
printf " copyright:www.doitphp.com \n"
printf "===========================\n"
printf "\n\n"

if [ ! -s websrc ]; then    
    mkdir websrc
    printf "Folder:websrc has been created.\n\n"
fi

cd websrc

printf "\n========= source package download start =========\n\n"

if [ -s mongodb-linux-x86_64-3.0.6.tgz ]; then
    echo "mongodb-linux-x86_64-3.0.6.tgz [found]"
else
    echo "mongodb-linux-x86_64-3.0.6.tgz download now..."
    wget https://fastdl.mongodb.org/linux/mongodb-linux-x86_64-3.0.6.tgz
fi

if [ ! -f mongodb-linux-x86_64-3.0.6.tgz ]; then
    printf "Error: mongodb-linux-x86_64-3.0.6.tgz not found!\n"
    exit 1
fi

if [ -s mongodb-linux-x86_64-3.0.6 ]; then
    rm -rf mongodb-linux-x86_64-3.0.6
fi
tar zxvf mongodb-linux-x86_64-3.0.6.tgz

printf "\n========= source package download completed =========\n\n"
printf "========= mongo install start... =========\n\n"

groupadd mongod
useradd -g mongod mongod -s /bin/false

mkdir -p /data/mongodb
chown -R mongod:mongod /data/mongodb
mkdir -m 0777 -p /var/log/mongodb

if [ ! -d /var/run/mongod ]; then
	mkdir -m 0777 /var/run/mongod
	chown -R mongod:mongod /var/run/mongod
fi

mv mongodb-linux-x86_64-3.0.6 mongodb
cp -R -n mongodb/ /usr/local

if [ ! -f /usr/local/mongodb/bin/mongod ]; then
    printf "Error: mongodb compile install failed!\n"
    exit 1
fi

export PATH=/usr/local/mongodb/bin:$PATH

mkdir -p /usr/local/mongodb/etc

if [ -s /usr/local/mongodb/etc/mongodb.conf ]; then
    rm /usr/local/mongodb/etc/mongodb.conf
fi

cat >/usr/local/mongodb/etc/mongodb.conf<<EOF
# mongod.conf
port=27017
dbpath=/data/mongodb
maxConns = 1024
noauth=true
#auth=true
pidfilepath=/var/run/mongod/mongod.pid
bind_ip=127.0.0.1
logpath=/var/log/mongodb/mongodb.log
logappend=true
quota=true
quotaFiles = 1024
nounixsocket = false
unixSocketPrefix = /var/run/mongod
EOF

cp ../mongodb.rcd.txt /etc/init.d/mongod
chmod 0755 /etc/init.d/mongod

cd -

chkconfig mongod on

service mongod start

printf "\n========== mongo install Completed! =======\n\n"
ps aux | grep mongod | grep -v "grep"
printf "============== The End. ==============\n"