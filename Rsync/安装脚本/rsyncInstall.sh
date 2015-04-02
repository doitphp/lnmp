#!/bin/bash

# Check if user is root
if [ $(id -u) != "0" ]; then
    printf "Error: You must be root to run this script!\n"
    exit 1
fi

printf "\n"
printf "==========================\n"
printf " Rsync v3.1.0 Install	  \n"
printf " copyright:www.doitphp.com \n"
printf "==========================\n"
printf "\n\n"

if [ ! -s websrc ]; then    
    mkdir websrc
    printf "Folder:websrc has been created.\n\n"
fi

cd websrc

printf "\n========= source package download start =========\n\n"

if [ -s rsync-3.1.1.tar.gz ]; then
    echo "rsync-3.1.1.tar.gz [found]"
else
    echo "rsync-3.1.1.tar.gz download now..."
    wget http://rsync.samba.org/ftp/rsync/rsync-3.1.1.tar.gz	
fi

if [ ! -f rsync-3.1.1.tar.gz ]; then
    printf "Error: rsync-3.1.1.tar.gz not found!\n"
    exit 1
fi

if [ -s rsync-3.1.1 ]; then
    rm -rf rsync-3.1.1
fi
tar zxvf rsync-3.1.1.tar.gz

printf "\n========= source package download completed =========\n\n"

printf "========= Rsync install start... =========\n\n"

cd rsync-3.1.1
./configure --prefix=/usr/local/rsync
make
make install
cd -

if [ ! -f /usr/local/rsync/bin/rsync ]; then
    printf "Error: rsync compile install failed!\n"
    exit 1
fi

mkdir -p /usr/local/rsync/etc
mkdir -m 0777 -p /usr/local/rsync/logs

echo "#username:password">/usr/local/rsync/etc/rsyncd.pass
chmod 600 /usr/local/rsync/etc/rsyncd.pass

if [ -s /usr/local/rsync/etc/rsyncd.conf ]; then
    mv /usr/local/rsync/etc/rsyncd.conf /usr/local/rsync/etc/rsyncd.conf.bak
fi

cat >/usr/local/rsync/etc/rsyncd.conf<<EOF
uid = nobody
gid = nobody
port = 873
use chroot = yes
max connections = 100
pid file = /usr/local/rsync/logs/rsyncd.pid
log file = /usr/local/rsync/logs/rsyncd.log
list = no
strict modes = no
secrets file = /usr/local/rsync/etc/rsyncd.pass
ignore errors

#hosts allow = 10.50.201.217
hosts deny=*

#[demo]
#uid = root
#gid = root
#path = /rsync module path
#auth users = username

#read only = no 
EOF

rsync --daemon --config=/usr/local/rsync/etc/rsyncd.conf

mv ../rsync.rcd.txt /etc/init.d/rsyncd
chmod 0755 /etc/init.d/rsyncd

isSet=`grep "/usr/local/rsync/bin/rsync --daemon" /etc/rc.local | wc -l`
if [ "$isSet" == "0" ]; then
    echo "/usr/local/rsync/bin/rsync --daemon --config=/usr/local/rsync/etc/rsyncd.conf">>/etc/rc.local
fi
service rsyncd restart

printf "\n========== Rsync install Completed! =======\n\n"
ps aux | grep rsync | grep -v "grep"
cat /etc/rc.local
printf "============== The End. ==============\n"