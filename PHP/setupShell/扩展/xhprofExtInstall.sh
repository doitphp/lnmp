#!/bin/bash

# Check if user is root
if [ $(id -u) != "0" ]; then
    printf "Error: You must be root to run this script!\n"
    exit 1
fi

printf "\n"
printf "==================================\n"
printf " xhprof php extension Install     \n"
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

printf "========= xhprof php extension install start... =========\n\n"

if [ -s xhprof-0.9.4.tgz ]; then
    echo "xhprof-0.9.4.tgz [found]"
else
    echo "xhprof-0.9.4.tgz download now..."
    wget http://pecl.php.net/get/xhprof-0.9.4.tgz	
fi

if [ -s xhprof-0.9.4 ]; then
    rm -rf xhprof-0.9.4
fi
tar zxvf xhprof-0.9.4.tgz

cd xhprof-0.9.4/extension
export PHP_AUTOCONF="/usr/local/bin/autoconf"
export PHP_AUTOHEADER="/usr/local/bin/autoheader"
/usr/local/php5/bin/phpize
./configure --with-php-config=/usr/local/php5/bin/php-config
make
make test
make install
cd -

isExists=`grep 'extension = "xhprof.so"' /usr/local/php5/etc/php.ini | grep -v ";" | wc -l`
if [ "$isExists" != "1" ]; then
    sed -i '/; extension_dir = "ext"/ a\extension = "xhprof.so"' /usr/local/php5/etc/php.ini
	echo "[xhprof]">>/usr/local/php5/etc/php.ini
	echo "xhprof.output_dir=/tmp/xhprof">>/usr/local/php5/etc/php.ini

	if [ ! -s /tmp/xhprof ]; then
		mkdir -m 0777 -p /tmp/xhprof
		printf "Folder:/tmp/xhprof has been created.\n\n"
	fi
fi

service php-fpm restart
cd -

printf "\n========== xhprof php extension install Completed! ========\n\n"
/usr/local/php5/bin/php -m | grep xhprof
printf "============== The End. ==============\n"