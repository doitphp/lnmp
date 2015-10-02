#!/bin/bash

# Check if user is root
if [ $(id -u) != "0" ]; then
    printf "Error: You must be root to run this script!\n"
    exit 1
fi

printf "\n"
printf "========================================\n"
printf " NMP install based librarys install     \n"
printf " copyright : www.doitphp.com            \n"
printf "========================================\n"
printf "\n\n"

if [ ! -s websrc ]; then
    mkdir websrc
    printf "Folder:websrc has been created.\n\n"
fi

printf "=== commond library yum install start ===\n\n"

yum clean all
yum makecache

isWget=`whereis wget|awk '{print $2}'`
if [ "$isWget" == "" ]; then
    yum -y install wget
fi

yum -y install openssl openssl-devel gcc gcc-c++ autoconf automake bison pcre make sysstat
yum -y install libxml2 libxml2-devel libXpm libXpm-devel libcurl libcurl-devel zlib zlib-devel curl curl-devel gd gd-devel gd2 gd2-devel freetype freetype-devel libjpeg libjpeg-devel libpng libpng-devel libidn libidn-devel ncurses ncurses-devel glibc glibc-devel glib2 glib2-devel bzip2 bzip2-devel e2fsprogs e2fsprogs-devel krb5 krb5-devel openldap openldap-devel nss_ldap openldap-clients openldap-servers

if [ ! -s /usr/lib/libXpm.so ]; then
	ln -s /usr/lib64/libXpm.* /usr/lib
fi
if [ ! -s /usr/lib/libfreetype.so.6 ]; then
	ln -s /usr/lib64/libfreetype.so.* /usr/lib
fi
if [ ! -s /usr/lib/libldap.so ]; then
	ln -s /usr/lib64/libldap.* /usr/lib
fi

printf "\n=== commond library yum install Completed! ===\n\n"

isExists=`grep '* soft nofile 65535' /etc/security/limits.conf | wc -l`
if [ "$isExists" != "1" ]; then
cat >> /etc/security/limits.conf <<EOF
* soft nproc 65535
* hard nproc 65535
* soft nofile 65535
* hard nofile 65535
EOF
fi

if [ ! -f /root/.ssh/id_rsa.pub ] && [ ! -f /root/.ssh/authorized_keys ]; then
	ssh-keygen -t rsa
fi

printf "============== The End. ==============\n"