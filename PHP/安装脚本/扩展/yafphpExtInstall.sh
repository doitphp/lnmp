#!/bin/bash

# Check if user is root
if [ $(id -u) != "0" ]; then
    printf "Error: You must be root to run this script!\n"
    exit 1
fi

printf "\n"
printf "==================================\n"
printf " YafPHP php extension Install     \n"
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

printf "========= YafPHP php extension install start... =========\n\n"

if [ -s yaf-2.3.3.tgz ]; then
    echo "yaf-2.3.3.tgz [found]"
else
    echo "yaf-2.3.3.tgz download now..."
    wget http://pecl.php.net/get/yaf-2.3.3.tgz	
fi

if [ -s yaf-2.3.3 ]; then
    rm -rf yaf-2.3.3
fi
tar zxvf yaf-2.3.3.tgz

cd yaf-2.3.3
export PHP_AUTOCONF="/usr/local/bin/autoconf"
export PHP_AUTOHEADER="/usr/local/bin/autoheader"
/usr/local/php5/bin/phpize
./configure --with-php-config=/usr/local/php5/bin/php-config
make
make test
make install
cd -

isExists=`grep 'extension = "yaf.so"' /usr/local/php5/etc/php.ini | grep -v ";" | wc -l`
if [ "$isExists" != "1" ]; then
    sed -i '/; extension_dir = "ext"/ a\extension = "yaf.so"' /usr/local/php5/etc/php.ini
fi

service php-fpm restart
cd -

printf "\n========== YafPHP php extension install Completed! ========\n\n"
/usr/local/php5/bin/php -m | grep yaf
printf "============== The End. ==============\n"