#!/bin/bash

# Check if user is root
if [ $(id -u) != "0" ]; then
    printf "Error: You must be root to run this script!\n"
    exit 1
fi

printf "\n"
printf "===========================\n"
printf " Coreseek v3.2.14 Install  \n"
printf " copyright:www.doitphp.com \n"
printf "===========================\n"
printf "\n\n"

if [ ! -s websrc ]; then    
    mkdir websrc
    printf "Folder:websrc has been created.\n\n"
fi

cd websrc

printf "\n========= source package download start =========\n\n"

if [ -s coreseek-3.2.14.tar.gz ]; then
    echo "coreseek-3.2.14.tar.gz [found]"
else
    echo "coreseek-3.2.14.tar.gz download now..."
    wget http://www.coreseek.cn/uploads/csft/3.2/coreseek-3.2.14.tar.gz
fi

if [ ! -f coreseek-3.2.14.tar.gz ]; then
    printf "Error: coreseek-3.2.14.tar.gz not found!\n"
    exit 1
fi

if [ -s coreseek-3.2.14 ]; then
    rm -rf coreseek-3.2.14
fi
tar zxvf coreseek-3.2.14.tar.gz

printf "\n========= source package download completed =========\n\n"

printf "========= Coreseek install start... =========\n\n"

yum -y install glibc-common libtool expat-devel

cd coreseek-3.2.14

ldconfig
cd mmseg-3.2.14
./bootstrap
./configure --prefix=/usr/local/mmseg
make
make install
cd -

cd csft-3.2.14
sh buildconf.sh
./configure --prefix=/usr/local/coreseek  --without-unixodbc --with-mmseg --with-mmseg-includes=/usr/local/mmseg/include/mmseg/ --with-mmseg-libs=/usr/local/mmseg/lib/ --with-mysql
sed -i 's/^LIBS = -lm -lz -lexpat  -L\/usr\/local\/lib -lrt  -lpthread/LIBS = -lm -lz -lexpat -liconv -L\/usr\/local\/lib -lrt  -lpthread/g' src/Makefile
make
make install
cd -

if [ ! -f /usr/local/coreseek/bin/searchd ]; then
    printf "Error: Coreseek compile install failed!\n"
    exit 1
fi

if [ ! -f /usr/local/coreseek/etc/csft.conf ]; then
    cp /usr/local/coreseek/etc/sphinx.conf.dist /usr/local/coreseek/etc/csft.conf
	sed -i 's/^\tcharset_type\t\t= sbcs/\tcharset_type\t\t= utf-8/g' /usr/local/coreseek/etc/csft.conf
fi

if [ ! -f /usr/lib64/libmysqlclient.so.18 ]; then
    ln -s /usr/local/mysql/lib/libmysqlclient.so.18 /usr/lib64/libmysqlclient.so.18
fi

printf "\n========== Coreseek install Completed! =======\n\n"

cd testpack
cat var/test/test.xml
/usr/local/mmseg/bin/mmseg -d /usr/local/mmseg/etc var/test/test.xml

sed -i 's/path            = var\/data\/xml/path            = \/usr\/local\/coreseek\/var\/data\/xml/g' etc/csft.conf
sed -i 's/charset_dictpath = \/usr\/local\/mmseg3\/etc\//charset_dictpath = \/usr\/local\/mmseg\/etc\//g' etc/csft.conf
sed -i 's/pid_file = var\/log\/searchd_xml.pid/pid_file = \/usr\/local\/coreseek\/var\/log\/searchd_xml.pid/g' etc/csft.conf
sed -i 's/log = var\/log\/searchd_xml.log/log = \/usr\/local\/coreseek\/var\/log\/searchd_xml.log/g' etc/csft.conf
sed -i 's/query_log = var\/log\/query_xml.log/query_log = \/usr\/local\/coreseek\/var\/log\/query_xml.log/g' etc/csft.conf

rm -rf /usr/local/coreseek/var/data/*

/usr/local/coreseek/bin/indexer -c etc/csft.conf --all
/usr/local/coreseek/bin/search -c etc/csft.conf 苹果
cd -
echo "test success!";
rm -rf /usr/local/coreseek/var/data/*
cd -

printf "============== The End. ==============\n"