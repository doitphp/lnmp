#!/bin/bash

# Check if user is root
if [ $(id -u) != "0" ]; then
    printf "Error: You must be root to run this script!\n"
    exit 1
fi

printf "\n"
printf "==================================\n"
printf " xdebug php extension Install     \n"
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

printf "========= xdebug php extension install start... =========\n\n"

if [ -s xdebug-2.2.7.tgz ]; then
    echo "xdebug-2.2.7.tgz [found]"
else
    echo "xdebug-2.2.7.tgz download now..."
    wget http://pecl.php.net/get/xdebug-2.2.7.tgz
fi

if [ -s xdebug-2.2.7 ]; then
    rm -rf xdebug-2.2.7
fi
tar zxvf xdebug-2.2.7.tgz

cd xdebug-2.2.7
export PHP_AUTOCONF="/usr/local/bin/autoconf"
export PHP_AUTOHEADER="/usr/local/bin/autoheader"
/usr/local/php5/bin/phpize
./configure --with-php-config=/usr/local/php5/bin/php-config
make
make test
make install
cd -

isExists=`grep 'extension = "xdebug.so"' /usr/local/php5/etc/php.ini | grep -v ";" | wc -l`
if [ "$isExists" != "1" ]; then
    sed -i '/; extension_dir = "ext"/ a\extension = "xdebug.so"' /usr/local/php5/etc/php.ini
fi

service php-fpm restart
cd -

printf "\n========== xdebug php extension install Completed! ========\n\n"
/usr/local/php5/bin/php -m | grep xdebug
printf "============== The End. ==============\n"