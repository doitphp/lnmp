#!/bin/bash

# Check if user is root
if [ $(id -u) != "0" ]; then
    printf "Error: You must be root to run this script!\n"
    exit 1
fi

printf "\n"
printf "===========================\n"
printf " PHP 5.6.5 Install	       \n"
printf "copyright: www.doitphp.com \n"
printf "===========================\n"
printf "\n\n"

if [ ! -s websrc ]; then    
    printf "Error: directory websrc not found.\n"
    exit 1
fi

cd websrc

printf "\n========= source package download start =========\n\n"

if [ -s php-5.6.5.tar.bz2 ]; then
    echo "php-5.6.5.tar.bz2 [found]"
else
    echo "php-5.6.5.tar.bz2 download now..."
    wget http://www.php.net/distributions/php-5.6.5.tar.bz2
fi

phpMd5=`md5sum php-5.6.5.tar.bz2 | awk '{print $1}'`
if [ "$phpMd5" != "64d0debf42bfff537d891e1fe1a4b65c" ]; then
    echo "Error: php-5.6.5.tar.bz2 package md5 value is invalid. Please check package download url";
    exit 1
fi

if [ -s php-5.6.5 ]; then
    rm -rf php-5.6.5
fi
tar jxvf php-5.6.5.tar.bz2

printf "\n========= source package download completed =========\n\n"
printf "========= zlib install start... =========\n\n"

if [ ! -f /usr/local/lib/libz.so ]; then
	if [ -s zlib-1.2.8.tar.gz ]; then
		echo "zlib-1.2.8.tar.gz [found]"
	else
		echo "zlib-1.2.8.tar.gz download now..."
		wget http://cznic.dl.sourceforge.net/project/libpng/zlib/1.2.8/zlib-1.2.8.tar.gz
	fi

	if [ -s zlib-1.2.8 ]; then
		rm -rf zlib-1.2.8
	fi
	tar zxvf zlib-1.2.8.tar.gz

	cd zlib-1.2.8
	./configure --prefix=/usr/local
	make
	make install
	cd -

	if [ ! -f /usr/local/lib/libz.so ]; then
		printf "Error: zlib compile install failed!\n"
		exit 1
	fi
else
	printf "zlib has been installed!\n"
fi

printf "\n========== zlib install end ==========\n\n"
printf "========= gettext install start... =========\n\n"

if [ ! -f /usr/local/lib/gettext ]; then
	if [ -s gettext-0.19.4.tar.gz ]; then
		echo "gettext-0.19.4.tar.gz [found]"
	else
		echo "gettext-0.19.4.tar.gz download now..."
		wget http://ftp.gnu.org/pub/gnu/gettext/gettext-0.19.4.tar.gz
	fi

	if [ -s gettext-0.19.4 ]; then
		rm -rf gettext-0.19.4
	fi
	tar zxvf gettext-0.19.4.tar.gz

	cd gettext-0.19.4
	./configure --prefix=/usr/local
	make
	make install
	cd -

	if [ ! -d /usr/local/lib/gettext ]; then
		printf "Error: gettext compile install failed!\n"
		exit 1
	fi
else
	printf "gettext has been installed!\n"
fi

printf "\n========== gettext install end ==========\n\n"
printf "========= jpeg install start... =========\n\n"

if [ ! -f /usr/local/lib/libjpeg.so ]; then
	if [ -s jpegsrc.v9a.tar.gz ]; then
		echo "jpegsrc.v9a.tar.gz [found]"
	else
		echo "jpegsrc.v9a.tar.gz download now..."
		wget http://www.ijg.org/files/jpegsrc.v9a.tar.gz
	fi

	if [ -s jpeg-9a ]; then
		rm -rf jpeg-9a
	fi
	tar zxvf jpegsrc.v9a.tar.gz

	cd jpeg-9a
	./configure --prefix=/usr/local
	make
	make install
	cd -

	if [ ! -f /usr/local/lib/libjpeg.so ]; then
		printf "Error: jpeg compile install failed!\n"
		exit 1
	fi
else
	printf "jpeg has been installed!\n"
fi

printf "\n========== jpeg install end ==========\n\n"
printf "========= libpng install start... =========\n\n"

if [ ! -f /usr/local/lib/libpng.so ]; then
	if [ -s libpng-1.6.2.tar.gz ]; then
		echo "libpng-1.6.2.tar.gz [found]"
	else
		echo "libpng-1.6.2.tar.gz download now..."
		wget http://prdownloads.sourceforge.net/libpng/libpng-1.6.2.tar.gz
	fi

	if [ -s libpng-1.6.2 ]; then
		rm -rf libpng-1.6.2
	fi
	tar zxvf libpng-1.6.2.tar.gz

	cd libpng-1.6.2
	./configure --prefix=/usr/local
	make
	make install
	cd -

	if [ ! -f /usr/local/lib/libpng.so ]; then
		printf "Error: libpng compile install failed!\n"
		exit 1
	fi
else
	printf "libpng has been installed!\n"
fi

printf "\n========== libpng install end ==========\n\n"
printf "========= freetype install start... =========\n\n"

if [ ! -f /usr/local/lib/libfreetype.so ]; then
	if [ -s freetype-2.5.5.tar.gz ]; then
		echo "freetype-2.5.5.tar.gz [found]"
	else
		echo "freetype-2.5.5.tar.gz download now..."
		wget http://download.savannah.gnu.org/releases/freetype/freetype-2.5.5.tar.gz
	fi

	if [ -s freetype-2.5.5 ]; then
		rm -rf freetype-2.5.5
	fi
	tar zxvf freetype-2.5.5.tar.gz

	cd freetype-2.5.5
	./configure --prefix=/usr/local
	make
	make install
	cd -

	if [ ! -f /usr/local/lib/libfreetype.so ]; then
		printf "Error: freetype compile install failed!\n"
		exit 1
	fi
else
	printf "freetype has been installed!\n"
fi

printf "\n========== freetype install end ==========\n\n"
printf "========= libgd install start... =========\n\n"

if [ ! -f /usr/local/lib/libgd.so ]; then
	if [ -s libgd-2.1.1.tar.gz ]; then
		echo "libgd-2.1.1.tar.gz [found]"
	else
		echo "libgd-2.1.1.tar.gz download now..."
		wget http://fossies.org/linux/www/libgd-2.1.1.tar.gz
	fi

	if [ -s libgd-2.1.1 ]; then
		rm -rf libgd-2.1.1
	fi
	tar zxvf libgd-2.1.1.tar.gz

	cd libgd-2.1.1
	./configure --prefix=/usr/local --with-zlib=/usr/local --with-png=/usr/local --with-freetype=/usr/local --with-jpeg=/usr/local
	make
	make install
	cd -

	if [ ! -f /usr/local/lib/libgd.so ]; then
		printf "Error: libgd compile install failed!\n"
		exit 1
	fi
else
	printf "libgd has been installed!\n"
fi

printf "\n========== libgd install end ==========\n\n"
printf "========= libiconv install start... =========\n\n"

if [ ! -f /usr/local/lib/libiconv.so ]; then
	if [ -s libiconv-1.14.tar.gz ]; then
		echo "libiconv-1.14.tar.gz [found]"
	else
		echo "libiconv-1.14.tar.gz download now..."
		wget http://ftp.gnu.org/pub/gnu/libiconv/libiconv-1.14.tar.gz
	fi

	if [ -s libiconv-1.14 ]; then
		rm -rf libiconv-1.14
	fi
	tar zxvf libiconv-1.14.tar.gz

	cd libiconv-1.14
	./configure --prefix=/usr/local
	make
	make install
	cd -

	if [ ! -f /usr/local/lib/libiconv.so ]; then
		printf "Error: libiconv compile install failed!\n"
		exit 1
	fi
else
	printf "libiconv has been installed!\n"
fi

printf "\n========== libiconv install end ==========\n\n"
printf "========= libmcrypt install start... =========\n\n"

if [ ! -f /usr/local/lib/libmcrypt.so ]; then
	if [ -s libmcrypt-2.5.8.tar.gz ]; then
		echo "libmcrypt-2.5.8.tar.gz [found]"
	else
		echo "libmcrypt-2.5.8.tar.gz download now..."
		wget http://nchc.dl.sourceforge.net/project/mcrypt/Libmcrypt/2.5.8/libmcrypt-2.5.8.tar.gz
	fi

	if [ -s libmcrypt-2.5.8 ]; then
		rm -rf libmcrypt-2.5.8
	fi
	tar zxvf libmcrypt-2.5.8.tar.gz

	cd libmcrypt-2.5.8
	./configure --prefix=/usr/local
	make
	make install
	cd -

	if [ ! -f /usr/local/lib/libmcrypt.so ]; then
		printf "Error: libmcrypt compile install failed!\n"
		exit 1
	fi
else
	printf "libmcrypt has been installed!\n"
fi

isSet=`grep "/usr/local/lib" /etc/ld.so.conf | wc -l`
if [ "$isSet" != "1" ]; then
    echo "/usr/local/lib">>/etc/ld.so.conf    
fi
ldconfig

printf "\n========== libmcrypt install end ==========\n\n"
printf "========= mhash install start... =========\n\n"

if [ ! -f /usr/local/lib/libmhash.so ]; then
	if [ -s mhash-0.9.9.9.tar.gz ]; then
	  echo "mhash-0.9.9.9.tar.gz [found]"
	else
		echo "mhash-0.9.9.9.tar.gz download now..."
		wget http://downloads.sourceforge.net/mhash/mhash-0.9.9.9.tar.gz
	fi

	if [ -s mhash-0.9.9.9 ]; then
		rm -rf mhash-0.9.9.9
	fi
	tar zxvf mhash-0.9.9.9.tar.gz

	cd mhash-0.9.9.9
	./configure --prefix=/usr/local
	make
	make install
	cd -

	if [ ! -f /usr/local/lib/libmhash.so ]; then
		printf "Error: mhash compile install failed!\n"
		exit 1
	fi
else
	printf "mhash has been installed!\n"
fi

printf "\n========== mhash install end ==========\n\n"
printf "========= mcrypt install start... =========\n\n"

if [ ! -f /usr/local/bin/mcrypt ]; then
	if [ -s mcrypt-2.6.8.tar.gz ]; then
	  echo "mcrypt-2.6.8.tar.gz [found]"
	else
	  echo "mcrypt-2.6.8.tar.gz download now..."
	  wget http://downloads.sourceforge.net/mcrypt/mcrypt-2.6.8.tar.gz
	fi

	if [ -s mcrypt-2.6.8 ]; then
		rm -rf mcrypt-2.6.8
	fi
	tar zxvf mcrypt-2.6.8.tar.gz

	ldconfig
	cd mcrypt-2.6.8
	./configure --prefix=/usr/local
	make
	make install
	cd -

	if [ ! -f /usr/local/bin/mcrypt ]; then
		printf "Error: mcrypt compile install failed!\n"
		exit 1
	fi
else
	printf "mcrypt has been installed!\n"
fi

printf "\n========== mcrypt install end ==========\n\n"
printf "========= autoconf install start... =========\n\n"

if [ ! -f /usr/local/bin/autoconf ]; then
	if [ -s autoconf-2.69.tar.gz  ]; then
	  echo "autoconf-2.69.tar.gz  [found]"
	else
	  echo "pautoconf-2.69.tar.gz  download now..."
	  wget http://ftp.gnu.org/gnu/autoconf/autoconf-2.69.tar.gz 
	fi

	if [ -s autoconf-2.69 ]; then
		rm -rf autoconf-2.69
	fi
	tar zxvf autoconf-2.69.tar.gz

	cd autoconf-2.69
	./configure --prefix=/usr/local
	make
	make install
	cd -

	if [ ! -f /usr/local/bin/autoconf ]; then
		printf "Error: autoconf compile install failed!\n"
		exit 1
	fi
else
	printf "autoconf has been installed!\n"
fi

printf "\n========== autoconf install end ==========\n\n"
printf "========= PHP install start... =========\n\n"

cd php-5.6.5
./configure --prefix=/usr/local/php5 --with-config-file-path=/usr/local/php5/etc --with-mysql=mysqlnd --with-mysqli=mysqlnd --with-pdo-mysql=mysqlnd --with-gd=/usr/local --with-iconv-dir=/usr/local --with-freetype-dir=/usr/local --with-jpeg-dir=/usr/local --with-png-dir=/usr/local --with-zlib --with-xmlrpc --with-curl --with-openssl --with-mcrypt=/usr/local --with-mhash --with-gettext --with-ldap --with-ldap-sasl --without-pear --enable-xml --enable-session --enable-sockets --enable-zip --enable-mbstring --enable-bcmath --enable-shmop --enable-soap --enable-sysvsem --enable-inline-optimization --enable-mbregex --enable-fpm --enable-ftp --enable-pcntl --enable-gd-native-ttf --disable-rpath --enable-maintainer-zts --enable-opcache --enable-calendar
make -j 4 ZEND_EXTRA_LIBS='-liconv'
make test
make install

if [ ! -f /usr/local/php5/bin/php ]; then
    printf "Error: php make install failed!\n"
    exit 1
fi

cp php.ini-production /usr/local/php5/etc/php.ini

if [ -f /etc/php.ini ]; then
	rm -rf /etc/php.ini
fi
ln -s /usr/local/php5/etc/php.ini /etc/php.ini
mv /usr/local/php5/etc/php-fpm.conf.default /usr/local/php5/etc/php-fpm.conf

if [ -f /etc/rc.d/init.d/php-fpm ]; then
	rm -rf /etc/rc.d/init.d/php-fpm
fi
cp sapi/fpm/init.d.php-fpm /etc/rc.d/init.d/php-fpm
chmod 0755 /etc/rc.d/init.d/php-fpm
cd -

service php-fpm start

chkconfig php-fpm on

sed -i 's/^error_reporting = E_ALL \& \~E_DEPRECATED \& ~E_STRICT/error_reporting = E_ALL \& \~E_NOTICE/g' /usr/local/php5/etc/php.ini
sed -i 's/^;date.timezone =/date.timezone = Asia\/Shanghai/g' /usr/local/php5/etc/php.ini
sed -i 's/^memory_limit = 128M/memory_limit = 1024M/g' /usr/local/php5/etc/php.ini
sed -i 's/^upload_max_filesize = 2M/upload_max_filesize = 8M/g' /usr/local/php5/etc/php.ini
sed -i 's/^max_file_uploads = 20/max_file_uploads = 32/g' /usr/local/php5/etc/php.ini

if [ ! -s /www/logs/php/session ]; then
	mkdir -m 0777 -p /www/logs/php/session
	chown www.www -R /www/logs/php
fi
sed -i 's/^;session.save_path = "\/tmp"/session.save_path = "\/www\/logs\/php\/session"/g' /usr/local/php5/etc/php.ini

extension_dirname=`/bin/ls /usr/local/php5/lib/php/extensions | grep 'no-debug-zts' | awk '{print $1}'`
opcache_file="/usr/local/php5/lib/php/extensions/"$extension_dirname"/opcache.so"

isExists=`grep "zend_extension=$opcache_file" /usr/local/php5/etc/php.ini | wc -l`
if [ "$isExists" == "0" ]; then
	if [ -f "$opcache_file" ]; then
		sed -i 's/^;opcache.enable=0/opcache.enable=0/g' /usr/local/php5/etc/php.ini
		sed -i 's/^;opcache.memory_consumption=64/opcache.memory_consumption=256/g' /usr/local/php5/etc/php.ini
		sed -i 's/^;opcache.max_accelerated_files=2000/opcache.max_accelerated_files=5000/g' /usr/local/php5/etc/php.ini
		sed -i 's/^;opcache.revalidate_freq=2/opcache.revalidate_freq=240/g' /usr/local/php5/etc/php.ini
		echo "zend_extension=$opcache_file">>/usr/local/php5/etc/php.ini
	fi
fi

read -p "Please make sure this server is production server, High security level?[y/n]:" isproduction
if [ "$isproduction" == "y" ] || [ "$isproduction" == "Y" ]; then
	if [ ! -s /www/logs/nginx ]; then
		mkdir -m 0777 -p /www/logs/nginx
	fi
	sed -i 's/^;error_log = syslog/error_log = \/www\/logs\/nginx\/php_error.log/g' /usr/local/php5/etc/php.ini
	sed -i 's/^expose_php = On/expose_php = Off/g' /usr/local/php5/etc/php.ini
	sed -i 's/^disable_functions =/disable_functions = system,passthru,exec,shell_exec,popen,phpinfo/g' /usr/local/php5/etc/php.ini
else
	sed -i 's/^display_errors = Off/display_errors = On/g' /usr/local/php5/etc/php.ini
fi

/usr/local/php5/bin/php --ini

read -p "Do you want to restart php-fpm?[y/n]:" isrestart
if [ "$isrestart" == "y" ] || [ "$isrestart" == "Y" ]; then
	service php-fpm restart
fi

sed -i 's/^user = nobody/user = www/g' /usr/local/php5/etc/php-fpm.conf
sed -i 's/^group = nobody/group = www/g' /usr/local/php5/etc/php-fpm.conf
sed -i 's/^;rlimit_files = 1024/rlimit_files = 65535/g' /usr/local/php5/etc/php-fpm.conf

printf "\n========== PHP install Completed! ========\n\n"
ps aux | grep php | grep -v "grep"
chkconfig --list | grep php-fpm
printf "============== The End. ==============\n"