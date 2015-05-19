#!/bin/bash

# Check if user is root
if [ $(id -u) != "0" ]; then
    printf "Error: You must be root to run this script!\n"
    exit 1
fi

printf "\n"
printf "============================\n"
printf " inotify-tools v3.13 Install\n"
printf " copyright:www.doitphp.com  \n"
printf "============================\n"
printf "\n\n"

if [ ! -s websrc ]; then    
    mkdir websrc
    printf "Folder:websrc has been created.\n\n"
fi

cd websrc

printf "\n========= source package download start =========\n\n"

if [ -s inotify-tools-3.13.tar.gz ]; then
    echo "inotify-tools-3.13.tar.gz [found]"
else
    echo "inotify-tools-3.13.tar.gz download now..."
    wget http://nchc.dl.sourceforge.net/project/inotify-tools/inotify-tools/3.13/inotify-tools-3.13.tar.gz
fi

if [ -s inotify-tools-3.13 ]; then
    rm -rf inotify-tools-3.13
fi
tar zxvf inotify-tools-3.13.tar.gz

printf "\n========= source package download completed =========\n\n"

printf "========= Inotify tools install start... =========\n\n"

cd inotify-tools-3.13
./configure --prefix=/usr/local
make
make install
cd -

if [ ! -f /usr/local/lib/libinotifytools.so ]; then
    printf "Error: inotify-tools compile install failed!\n"
    exit 1
fi

printf "\n========== Inotify tools install Completed! =======\n\n"
printf "============== The End. ==============\n"