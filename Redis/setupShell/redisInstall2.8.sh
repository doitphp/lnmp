#!/bin/bash

# Check if user is root
if [ $(id -u) != "0" ]; then
    printf "Error: You must be root to run this script!\n"
    exit 1
fi

printf "\n"
printf "==========================\n"
printf " redis v2.8.20 Install	  \n"
printf " copyright:www.doitphp.com \n"
printf "==========================\n"
printf "\n\n"

if [ ! -s websrc ]; then    
    mkdir websrc
    printf "Folder:websrc has been created.\n\n"
fi

cd websrc

printf "\n========= source package download start =========\n\n"

if [ -s redis-2.8.20.tar.gz ]; then
    echo "redis-2.8.20.tar.gz [found]"
else
    echo "redis-2.8.20.tar.gz download now..."
    wget http://download.redis.io/releases/redis-2.8.20.tar.gz	
fi

if [ ! -f redis-2.8.20.tar.gz ]; then
    printf "Error: redis-2.8.20.tar.gz not found!\n"
    exit 1
fi

if [ -s tcl8.6.3-src.tar.gz ]; then
    echo "tcl8.6.3-src.tar.gz [found]"
else
    echo "tcl8.6.3-src.tar.gz download now..."
    wget http://downloads.sourceforge.net/tcl/tcl8.6.3-src.tar.gz	
fi

if [ ! -f tcl8.6.3-src.tar.gz ]; then
    printf "Error: tcl8.6.3-src.tar.gz not found!\n"
    exit 1
fi

if [ -s redis-2.8.20 ]; then
    rm -rf redis-2.8.20
fi
tar zxvf redis-2.8.20.tar.gz

if [ -s tcl8.6.3 ]; then
    rm -rf tcl8.6.3
fi
tar zxvf tcl8.6.3-src.tar.gz

printf "\n========= source package download completed =========\n\n"

printf "========= tcl install start... =========\n\n"

cd tcl8.6.3/unix
./configure
make
make install
cd -

printf "\n========== tcl install Completed! =======\n\n"

printf "========= redis install start... =========\n\n"

groupadd redis
useradd -g redis redis -s /bin/false

mkdir -p /data/redis
mkdir -p /var/log/redis
chown -R redis:redis /data/redis
chmod 0777 -R /var/log/redis

mkdir -p /usr/local/redis/etc

cd redis-2.8.20
make PREFIX=/usr/local/redis test
make PREFIX=/usr/local/redis install

if [ ! -f /usr/local/redis/bin/redis-server ]; then
    printf "Error: redis compile install failed!\n"
    exit 1
fi

if [ -s /usr/local/redis/etc/redis.conf ]; then
    rm /usr/local/redis/etc/redis.conf
fi
cp ./redis.conf /usr/local/redis/etc/redis.conf

cd -

sed -i 's/^daemonize no/daemonize yes/g' /usr/local/redis/etc/redis.conf
sed -i 's/^dir .\//dir \/data\/redis/g' /usr/local/redis/etc/redis.conf
sed -i 's/^logfile ""/logfile \/var\/log\/redis\/redislog/g' /usr/local/redis/etc/redis.conf

cp ../redis.rcd.txt /etc/init.d/redisd
chmod 0755 /etc/init.d/redisd

chkconfig redisd on

isExists=`grep 'vm.overcommit_memory' /etc/sysctl.conf | wc -l`
if [ "$isExists" != "1" ]; then
	echo "vm.overcommit_memory = 1">>/etc/sysctl.conf
	sysctl -p
fi

service redisd start

printf "\n========== redis install Completed! =======\n\n"
ps aux | grep redis | grep -v "grep"
printf "============== The End. ==============\n"