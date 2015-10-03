#!/bin/bash

# Check if user is root
if [ $(id -u) != "0" ]; then
    printf "Error: You must be root to run this script!\n"
    exit 1
fi

printf "\n"
printf "============================\n"
printf " Git V2.6.0 Install	    \n"
printf " copyright: www.doitphp.com \n"
printf "============================\n"
printf "\n\n"

if [ ! -s websrc ]; then    
    printf "Error: directory websrc not found.\n"
    exit 1
fi

yum -y install perl-ExtUtils-MakeMaker package tcl build-essential tk

cd websrc

printf "\n========= source package download start =========\n\n"

if [ -s git-2.6.0.tar.gz ]; then
    echo "git-2.6.0.tar.gz [found]"
else
    echo "git-2.6.0.tar.gz download now..."
    wget https://www.kernel.org/pub/software/scm/git/git-2.6.0.tar.gz	
fi

if [ -s git-2.6.0 ]; then
    rm -rf git-2.6.0
fi
tar zxvf git-2.6.0.tar.gz

printf "\n========= source package download completed =========\n\n"
printf "========= git install start... =========\n\n"

cd git-2.6.0
./configure --prefix=/usr/local
make -j 8
make install
cd -

if [ ! -f /usr/local/bin/git ]; then
    printf "Error: git make install failed!\n"
    exit 1
fi

printf "\n========== git install Completed! =======\n\n"
whereis git
git --version
printf "============== The End. ==============\n"