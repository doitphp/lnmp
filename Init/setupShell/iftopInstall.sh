#!/bin/bash

# Check if user is root
if [ $(id -u) != "0" ]; then
    printf "Error: You must be root to run this script!\n"
    exit 1
fi

printf "\n"
printf "============================\n"
printf " Iftop V 0.17 Install	    \n"
printf " copyright: www.doitphp.com \n"
printf "============================\n"
printf "\n\n"

if [ ! -s websrc ]; then    
    printf "Error: directory websrc not found.\n"
    exit 1
fi

yum -y install flex byacc libpcap libpcap-devel;

cd websrc

if [ -s iftop-0.17.tar.gz ]; then
    echo "iftop-0.17.tar.gz [found]"
else
    echo "iftop-0.17.tar.gz download now..."
	wget http://www.ex-parrot.com/~pdw/iftop/download/iftop-0.17.tar.gz
fi

if [ -s iftop-0.17 ]; then
    rm -rf iftop-0.17   
fi
tar zxvf iftop-0.17.tar.gz

printf "========= iftop install start... =========\n\n"

cd iftop-0.17
./configure
make
make install
cd -

printf "\n========== iftop install end =============\n\n"

printf "============== The End. ==============\n"