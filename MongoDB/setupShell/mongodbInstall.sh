#!/bin/bash

# Check if user is root
if [ $(id -u) != "0" ]; then
    printf "Error: You must be root to run this script!\n"
    exit 1
fi

printf "\n"
printf "===========================\n"
printf " MongoDB v2.6.7 Install	   \n"
printf " copyright:www.doitphp.com \n"
printf "===========================\n"
printf "\n\n"

if [ ! -s websrc ]; then    
    mkdir websrc
    printf "Folder:websrc has been created.\n\n"
fi

cd websrc

printf "\n========= source package download start =========\n\n"

if [ -s mongodb-linux-x86_64-2.6.7.tgz ]; then
    echo "mongodb-linux-x86_64-2.6.7.tgz [found]"
else
    echo "mongodb-linux-x86_64-2.6.7.tgz download now..."
    wget http://downloads.mongodb.org/linux/mongodb-linux-x86_64-2.6.7.tgz
fi

if [ ! -f mongodb-linux-x86_64-2.6.7.tgz ]; then
    printf "Error: mongodb-linux-x86_64-2.6.7.tgz not found!\n"
    exit 1
fi

if [ -s mongodb-linux-x86_64-2.6.7 ]; then
    rm -rf mongodb-linux-x86_64-2.6.7
fi
tar zxvf mongodb-linux-x86_64-2.6.7.tgz

printf "\n========= source package download completed =========\n\n"
printf "========= mongo install start... =========\n\n"

groupadd mongod
useradd -g mongod mongod -s /bin/false

mkdir -p /data/mongodb
chown -R mongod:mongod /data/mongodb
mkdir -m 0777 -p /var/log/mongodb

mv mongodb-linux-x86_64-2.6.7 mongodb
cp -R -n mongodb/ /usr/local

if [ ! -f /usr/local/mongodb/bin/mongod ]; then
    printf "Error: mongodb compile install failed!\n"
    exit 1
fi

export PATH=/usr/local/mongodb/bin:$PATH

mkdir -p /usr/local/mongodb/etc
mkdir -p /usr/local/mongodb/logs
chown -R mongod:mongod /usr/local/mongodb/logs

if [ -s /usr/local/mongodb/etc/mongodb.conf ]; then
    rm /usr/local/mongodb/etc/mongodb.conf
fi

cat >/usr/local/mongodb/etc/mongodb.conf<<EOF
# mongod.conf

#where to log
logpath=/var/log/mongodb/mongodb.log

logappend=true

# fork and run in background
fork=true

#port=27017

dbpath=/data/mongodb

# location of pidfile
pidfilepath=/usr/local/mongodb/logs/mongod.pid

# Listen to local interface only. Comment out to listen on all interfaces. 
bind_ip=127.0.0.1

# Disables write-ahead journaling
# nojournal=true

# Enables periodic logging of CPU utilization and I/O wait
#cpu=true

# Turn on/off security.  Off is currently the default
#noauth=true
#auth=true

# Verbose logging output.
#verbose=true

# Inspect all client data for validity on receipt (useful for
# developing drivers)
#objcheck=true

# Enable db quota management
#quota=true

# Set oplogging level where n is
#   0=off (default)
#   1=W
#   2=R
#   3=both
#   7=W+some reads
#diaglog=0

# Ignore query hints
#nohints=true

# Enable the HTTP interface (Defaults to port 28017).
#httpinterface=true

# Turns off server-side scripting.  This will result in greatly limited
# functionality
#noscripting=true

# Turns off table scans.  Any query that would do a table scan fails.
#notablescan=true

# Disable data file preallocation.
#noprealloc=true

# Specify .ns file size for new databases.
# nssize=<size>

# Replication Options

# in replicated mongo databases, specify the replica set name here
#replSet=setname
# maximum size in megabytes for replication operation log
#oplogSize=1024
# path to a key file storing authentication info for connections
# between replica set members
#keyFile=/path/to/keyfile
EOF

cp ../mongodb.rcd.txt /etc/init.d/mongod
chmod 0755 /etc/init.d/mongod

cd -

chkconfig mongod on

service mongod start

printf "\n========== mongo install Completed! =======\n\n"
ps aux | grep mongod | grep -v "grep"
printf "============== The End. ==============\n"