#!/bin/bash

# Check if user is root
if [ $(id -u) != "0" ]; then
    printf "Error: You must be root to run this script!\n"
    exit 1
fi

printf "\n"
printf "============================\n"
printf " Memcached 1.4.22 Install   \n"
printf " copyright:www.doitphp.com  \n"
printf "============================\n"
printf "\n\n"

if [ ! -s websrc ]; then    
    printf "Error: directory websrc not found.\n"
    exit 1
fi

cd websrc

printf "========= Memcached install start... =========\n\n"

if [ ! -f /usr/local/lib/libevent.so ]; then
	if [ -s libevent-2.0.22-stable.tar.gz ]; then
		echo "libevent-2.0.22-stable.tar.gz [found]"
	else
		echo "libevent-2.0.22-stable.tar.gz download now..."
		wget http://jaist.dl.sourceforge.net/project/levent/libevent/libevent-2.0/libevent-2.0.22-stable.tar.gz		
	fi

	if [ -s libevent-2.0.22-stable ]; then
		rm -rf libevent-2.0.22-stable
	fi
	tar zxvf libevent-2.0.22-stable.tar.gz

	cd libevent-2.0.22-stable
	./configure --prefix=/usr/local
	make
	make install
	cd -

	if [ ! -f /usr/local/lib/libevent.so ]; then
		printf "Error: libevent compile install failed!\n"
		exit 1
	fi
fi

if [ -s memcached-1.4.22.tar.gz ]; then
    echo "memcached-1.4.22.tar.gz [found]"
else
    echo "memcached-1.4.22.tar.gz download now..."
    wget http://memcached.org/files/memcached-1.4.22.tar.gz
fi

if [ -s memcached-1.4.22 ]; then
    rm -rf memcached-1.4.22
fi
tar zxvf memcached-1.4.22.tar.gz

cd memcached-1.4.22
./configure --prefix=/usr/local/memcached --with-libevent=/usr/local
make
make install
cd -

if [ ! -f /usr/local/memcached/bin/memcached ]; then
    printf "Error: memcached compile install failed!\n"
    exit 1
fi

if [ ! -d /var/run/memcached ]; then
	mkdir -p /var/run/memcached
	chmod 0777 -R /var/run/memcached
fi

groupadd memcached
useradd -g memcached memcached -s /bin/false

mkdir -p /usr/local/memcached/etc

cat >/usr/local/memcached/etc/memcached.conf<<EOF
PORT="11211"
USER="memcached"
MAXCONN="1024"
CACHESIZE="256"
OPTIONS="127.0.0.1"
EOF

cp ../memcached.rcd.txt /etc/rc.d/init.d/memcached
chmod 0755 /etc/rc.d/init.d/memcached

#/usr/local/ -d -m 10 -u root -l 127.0.0.0 -p 11211 -c 256 -P /tmp/memcached.pid

service memcached start
chkconfig memcached on
service memcached restart

printf "\n======== Memcached install Completed! ======\n\n"
ps aux | grep memcached | grep -v "grep"
chkconfig --list | grep memcached
printf "============== The End. ==============\n"