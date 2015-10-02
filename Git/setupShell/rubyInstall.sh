#!/bin/bash

# Check if user is root
if [ $(id -u) != "0" ]; then
    printf "Error: You must be root to run this script!\n"
    exit 1
fi

printf "\n"
printf "============================\n"
printf " Ruby V2.2.1 Install	    \n"
printf " copyright: www.doitphp.com \n"
printf "============================\n"
printf "\n\n"

if [ ! -s websrc ]; then    
    printf "Error: directory websrc not found.\n"
    exit 1
fi

yum -y install libyaml-devel libffi-devel openssh-server libxslt-devel libicu-devel logrotate python-docutils libkrb5-devel

cd websrc

printf "\n========= source package download start =========\n\n"

if [ -s ruby-2.2.3.tar.gz ]; then
    echo "ruby-2.2.3.tar.gz [found]"
else
    echo "ruby-2.2.3.tar.gz download now..."
    wget https://cache.ruby-lang.org/pub/ruby/2.2/ruby-2.2.3.tar.gz
fi

if [ -s ruby-2.2.3 ]; then
    rm -rf ruby-2.2.3
fi
tar zxvf ruby-2.2.3.tar.gz

printf "\n========= source package download completed =========\n\n"
printf "========= Ruby install start... =========\n\n"

cd ruby-2.2.3
./configure --disable-install-rdoc
make -j 8
make install
cd -

if [ ! -f /usr/local/bin/ruby ]; then
    printf "Error: ruby make install failed!\n"
    exit 1
fi

/usr/local/bin/gem install bundler --no-ri --no-rdoc

printf "\n========== Ruby install Completed! =======\n\n"
whereis ruby
/usr/local/bin/ruby --version
printf "============== The End. ==============\n"