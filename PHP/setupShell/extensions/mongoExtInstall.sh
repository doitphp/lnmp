#!/bin/bash

# Check if user is root
if [ $(id -u) != "0" ]; then
    printf "Error: You must be root to run this script!\n"
    exit 1
fi

printf "\n"
printf "==================================\n"
printf " MongoDb php extension Install    \n"
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

printf "========= MongoDb php extension install start... =========\n\n"

if [ -s mongo-1.6.11.tgz ]; then
    echo "mongo-1.6.11.tgz [found]"
else
    echo "mongo-1.6.11.tgz download now..."
    wget http://pecl.php.net/get/mongo-1.6.11.tgz
fi

if [ -s mongo-1.6.11 ]; then
    rm -rf mongo-1.6.11
fi
tar zxvf mongo-1.6.11.tgz

cd mongo-1.6.11
export PHP_AUTOCONF="/usr/local/bin/autoconf"
export PHP_AUTOHEADER="/usr/local/bin/autoheader"
/usr/local/php5/bin/phpize
./configure --with-php-config=/usr/local/php5/bin/php-config
make
make test
make install
cd -

isExists=`grep 'extension = "mongo.so"' /usr/local/php5/etc/php.ini | grep -v ";" | wc -l`
if [ "$isExists" != "1" ]; then
    sed -i '/; extension_dir = "ext"/ a\extension = "mongo.so"' /usr/local/php5/etc/php.ini
fi

service php-fpm restart
cd -

printf "\n========== MongoDb php extension install Completed! ========\n\n"
/usr/local/php5/bin/php -m | grep mongo
printf "============== The End. ==============\n"