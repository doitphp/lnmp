#!/bin/bash

# Check if user is root
if [ $(id -u) != "0" ]; then
    printf "Error: You must be root to run this script!\n"
    exit 1
fi

printf "\n"
printf "==================================\n"
printf " Memcached php extension Install  \n"
printf " copyright : www.doitphp.com      \n"
printf "==================================\n"
printf "\n\n"

if [ ! -s websrc ]; then    
    printf "Error: directory websrc not found.\n"
    exit 1
fi

if [ ! -f /usr/local/php5/bin/php ]; then
    printf "Error: php has not installed! Please compile install PHP5 first.\n"
    exit 1
fi

cd websrc

printf "========= Memcached php extension install start... =========\n\n"

if [ -s libmemcached-1.0.18.tar.gz ]; then
    echo "libmemcached-1.0.18.tar.gz [found]"
else
    echo "libmemcached-1.0.18.tar.gz download now..."
    wget https://launchpad.net/libmemcached/1.0/1.0.18/+download/libmemcached-1.0.18.tar.gz
fi

if [ -s libmemcached-1.0.18 ]; then
    rm -rf libmemcached-1.0.18
fi
tar zxvf libmemcached-1.0.18.tar.gz

if [ -s memcached-2.2.0.tgz ]; then
    echo "memcached-2.2.0.tgz [found]"
else
    echo "memcached-2.2.0.tgz download now..."
    wget http://pecl.php.net/get/memcached-2.2.0.tgz
fi

if [ -s memcached-2.2.0 ]; then
    rm -rf memcached-2.2.0
fi
tar zxvf memcached-2.2.0.tgz

cd libmemcached-1.0.18
./configure --prefix=/usr/local
make
make install
cd -

cd memcached-2.2.0
export PHP_AUTOCONF="/usr/local/bin/autoconf"
export PHP_AUTOHEADER="/usr/local/bin/autoheader"
/usr/local/php5/bin/phpize
./configure --with-php-config=/usr/local/php5/bin/php-config --with-libmemcached-dir=/usr/local/
make
make test
make install
cd -

isExists=`grep 'extension = "memcached.so"' /usr/local/php5/etc/php.ini | grep -v ";" | wc -l`
if [ "$isExists" != "1" ]; then
    sed -i '/; extension_dir = "ext"/ a\extension = "memcached.so"' /usr/local/php5/etc/php.ini
fi

service php-fpm restart
cd -

printf "\n========= Memcached php extension install Completed! =======\n\n"
/usr/local/php5/bin/php -m | grep memcached
printf "============== The End. ==============\n"