#!/bin/bash

# Check if user is root
if [ $(id -u) != "0" ]; then
    printf "Error: You must be root to run this script!\n"
    exit 1
fi

printf "\n"
printf "==================================\n"
printf " Imagick extension Install     \n"
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

isconvert=`whereis convert | awk '{print $2}'`
if [ "$isconvert" == "" ]; then
	yum -y install ImageMagick ImageMagick-devel
fi

cd websrc

printf "========= imagick php extension install start... =========\n\n"

if [ -s imagick-3.1.2.tgz ]; then
    echo "imagick-3.1.2.tgz [found]"
else
    echo "imagick-3.1.2.tgz download now..."
    wget http://pecl.php.net/get/imagick-3.1.2.tgz	
fi

if [ -s imagick-3.1.2 ]; then
    rm -rf imagick-3.1.2
fi
tar zxvf imagick-3.1.2.tgz

cd imagick-3.1.2
export PHP_AUTOCONF="/usr/local/bin/autoconf"
export PHP_AUTOHEADER="/usr/local/bin/autoheader"
/usr/local/php5/bin/phpize
./configure --with-php-config=/usr/local/php5/bin/php-config
make
make test
make install
cd -

isExists=`grep 'extension = "imagick.so"' /usr/local/php5/etc/php.ini | grep -v ";" | wc -l`
if [ "$isExists" != "1" ]; then
    sed -i '/; extension_dir = "ext"/ a\extension = "imagick.so"' /usr/local/php5/etc/php.ini
fi

service php-fpm restart
cd -

printf "\n========== imagick php extension install Completed! ========\n\n"
/usr/local/php5/bin/php -m | grep imagick
printf "============== The End. ==============\n"