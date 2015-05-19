#!/bin/bash

# Check if user is root
if [ $(id -u) != "0" ]; then
    printf "Error: You must be root to run this script!\n"
    exit 1
fi

printf "\n"
printf "===============================\n"
printf " MongoDB v2.6.7 Yum Install	   \n"
printf " copyright: www.doitphp.com    \n"
printf "===============================\n"
printf "\n\n"

if [ ! -s websrc ]; then    
    mkdir websrc
    printf "Folder:websrc has been created.\n\n"
fi

cd websrc

printf "\n========= Configure yum sourse start =========\n\n"

if [ ! -f /etc/yum.repos.d/mongodb.repo ]; then
	cat >/etc/yum.repos.d/mongodb.repo<<EOF
[mongodb]
name=MongoDB Repository
baseurl=http://downloads-distro.mongodb.org/repo/redhat/os/x86_64/
gpgcheck=0
enabled=1
EOF
fi

printf "\n========= Configure yum sourse completed =========\n\n"
printf "========= mongo install start... =========\n\n"

yum install -y mongodb-org

yum install -y mongodb-org-2.6.7 mongodb-org-server-2.6.7 mongodb-org-shell-2.6.7 mongodb-org-mongos-2.6.7 mongodb-org-tools-2.6.7

mkdir -p /data/mongodb
chown -R mongod:mongod /data/mongodb

sed -i 's/^dbpath=\/var\/lib\/mongo/dbpath=\/data\/mongodb/g' /etc/mongod.conf

service mongod start

chkconfig mongod on

service mongod restart

printf "\n========== mongo install Completed! =======\n\n"
ps aux | grep mongod | grep -v "grep"
printf "============== The End. ==============\n"