#!/bin/bash

# Check if user is root
if [ $(id -u) != "0" ]; then
    printf "Error: You must be root to run this script!\n"
    exit 1
fi

printf "\n"
printf "===========================\n"
printf " WebSRC software download  \n"
printf " copyright:www.doitphp.com \n"
printf "===========================\n"
printf "\n\n"

if [ ! -s websrc ]; then    
    printf "Error: directory websrc not found.\n"
    exit 1
fi

cd websrc

printf "\n========= source package download start =========\n\n"

# install nginx
read -p "Do you want to download nginx?[y/n]:" download_nginx
if [ "$download_nginx" == "y" ] || [ "$download_nginx" == "Y" ]; then	
	if [ -s pcre-8.36.tar.gz ]; then
		echo "pcre-8.36.tar.gz [found]"
	else
		echo "pcre-8.36.tar.gz download now..."
		wget http://softlayer-sng.dl.sourceforge.net/project/pcre/pcre/8.36/pcre-8.36.tar.gz  
	fi

	if [ -s nginx-1.7.9.tar.gz ]; then
		echo "nginx-1.7.9.tar.gz [found]"
	else
		echo "nginx-1.7.9.tar.gz download now..."
		wget http://nginx.org/download/nginx-1.7.9.tar.gz;  
	fi

	if [ -s jemalloc-3.6.0.tar.bz2 ]; then
		echo "jemalloc-3.6.0.tar.bz2 [found]"
	else
		echo "jemalloc-3.6.0.tar.bz2 download now..."
		wget http://www.canonware.com/download/jemalloc/jemalloc-3.6.0.tar.bz2
	fi
fi


# install PHP5.6
read -p "Do you want download PHP v5.6 and based libaries?[y/n]:" download_php
if [ "$download_php" == "y" ] || [ "$download_php" == "Y" ]; then	
	if [ -s php-5.6.5.tar.bz2 ]; then
		echo "php-5.6.5.tar.bz2 [found]"
	else
		echo "php-5.6.5.tar.bz2 download now..."	
		wget http://www.php.net/distributions/php-5.6.5.tar.bz2
	fi

	if [ -s libmcrypt-2.5.8.tar.gz ]; then
		echo "libmcrypt-2.5.8.tar.gz [found]"
	else
		echo "libmcrypt-2.5.8.tar.gz download now..."	
		wget http://nchc.dl.sourceforge.net/project/mcrypt/Libmcrypt/2.5.8/libmcrypt-2.5.8.tar.gz
	fi

	if [ -s libiconv-1.14.tar.gz ]; then
		echo "libiconv-1.14.tar.gz [found]"
	else
		echo "libiconv-1.14.tar.gz download now..."	
		wget http://ftp.gnu.org/pub/gnu/libiconv/libiconv-1.14.tar.gz
	fi

	if [ -s jpegsrc.v9a.tar.gz ]; then
		echo "jpegsrc.v9a.tar.gz [found]"
	else
		echo "jpegsrc.v9a.tar.gz download now..."	
		wget http://www.ijg.org/files/jpegsrc.v9a.tar.gz
	fi

	if [ -s libpng-1.6.2.tar.gz ]; then
		echo "libpng-1.6.2.tar.gz [found]"
	else
		echo "libpng-1.6.2.tar.gz download now..."	
		wget http://prdownloads.sourceforge.net/libpng/libpng-1.6.2.tar.gz
	fi

	if [ -s freetype-2.5.5.tar.gz ]; then
		echo "freetype-2.5.5.tar.gz [found]"
	else
		echo "freetype-2.5.5.tar.gz download now..."	
		wget http://download.savannah.gnu.org/releases/freetype/freetype-2.5.5.tar.gz
	fi

	if [ -s zlib-1.2.8.tar.gz ]; then
		echo "zlib-1.2.8.tar.gz [found]"
	else
		echo "zlib-1.2.8.tar.gz download now..."	
		wget http://cznic.dl.sourceforge.net/project/libpng/zlib/1.2.8/zlib-1.2.8.tar.gz
	fi

	if [ -s gd-2.1.1.tar.gz ]; then
		echo "gd-2.1.1.tar.gz [found]"
	else
		echo "gd-2.1.1.tar.gz download now..."	
		wget https://github.com/libgd/libgd/archive/gd-2.1.1.tar.gz
	fi

	if [ -s mhash-0.9.9.9.tar.gz ]; then
		echo "mhash-0.9.9.9.tar.gz [found]"
	else
		echo "mhash-0.9.9.9.tar.gz download now..."	
		wget http://downloads.sourceforge.net/mhash/mhash-0.9.9.9.tar.gz
	fi

	if [ -s mcrypt-2.6.8.tar.gz ]; then
		echo "mcrypt-2.6.8.tar.gz [found]"
	else
		echo "mcrypt-2.6.8.tar.gz download now..."	
		wget http://downloads.sourceforge.net/mcrypt/mcrypt-2.6.8.tar.gz
	fi

	if [ -s autoconf-2.69.tar.gz ]; then
		echo "autoconf-2.69.tar.gz [found]"
	else
		echo "autoconf-2.69.tar.gz download now..."	
		wget http://ftp.gnu.org/gnu/autoconf/autoconf-2.69.tar.gz
	fi

	if [ -s gettext-0.19.4.tar.gz ]; then
		echo "gettext-0.19.4.tar.gz [found]"
	else
		echo "gettext-0.19.4.tar.gz download now..."	
		wget http://ftp.gnu.org/pub/gnu/gettext/gettext-0.19.4.tar.gz
	fi
fi


# install Mysql5.6
read -p "Do you want download mysql?[y/n]:" download_mysql
if [ "$download_mysql" == "y" ] || [ "$download_mysql" == "Y" ]; then	
	if [ -s cmake-3.1.2.tar.gz ]; then
		echo "cmake-3.1.2.tar.gz [found]"
	else
		echo "cmake-3.1.2.tar.gz download now..."	
		wget http://www.cmake.org/files/v3.1/cmake-3.1.2.tar.gz
	fi

	if [ -s mysql-5.6.23.tar.gz ]; then
		echo "mysql-5.6.23.tar.gz [found]"
	else
		echo "mysql-5.6.23.tar.gz download now..."	
		wget http://cdn.mysql.com/Downloads/MySQL-5.6/mysql-5.6.23.tar.gz
	fi

	if [ -s jemalloc-3.6.0.tar.bz2 ]; then
		echo "jemalloc-3.6.0.tar.bz2 [found]"
	else
		echo "jemalloc-3.6.0.tar.bz2 download now..."
		wget http://www.canonware.com/download/jemalloc/jemalloc-3.6.0.tar.bz2
	fi
fi


# install memcached php extension
read -p "Do you want download memcached php extension?[y/n]:" download_phpext_memcached
if [ "$download_phpext_memcached" == "y" ] || [ "$download_phpext_memcached" == "Y" ]; then	
	if [ -s libmemcached-1.0.18.tar.gz ]; then
		echo "libmemcached-1.0.18.tar.gz [found]"
	else
		echo "libmemcached-1.0.18.tar.gz download now..."	
		wget https://launchpad.net/libmemcached/1.0/1.0.18/+download/libmemcached-1.0.18.tar.gz
	fi

	if [ -s memcached-2.2.0.tgz ]; then
		echo "memcached-2.2.0.tgz [found]"
	else
		echo "memcached-2.2.0.tgz download now..."	
		wget http://pecl.php.net/get/memcached-2.2.0.tgz
	fi
fi


# install memcache php extension
read -p "Do you want download memcache php extension?[y/n]:" download_phpext_memcache
if [ "$download_phpext_memcache" == "y" ] || [ "$download_phpext_memcache" == "Y" ]; then	
	if [ -s memcache-3.0.8.tgz ]; then
		echo "memcache-3.0.8.tgz [found]"
	else
		echo "memcache-3.0.8.tgz download now..."	
		wget http://pecl.php.net/get/memcache-3.0.8.tgz
	fi
fi


# install redis php extension
read -p "Do you want download redis php extension?[y/n]:" download_phpext_redis
if [ "$download_phpext_redis" == "y" ] || [ "$download_phpext_redis" == "Y" ]; then	
	if [ -s redis-2.2.5.tgz ]; then
		echo "redis-2.2.5.tgz [found]"
	else
		echo "redis-2.2.5.tgz download now..."	
		wget http://pecl.php.net/get/redis-2.2.5.tgz
	fi
fi


# install mongo php extension
read -p "Do you want download mongo php extension?[y/n]:" download_phpext_mongodb
if [ "$download_phpext_mongodb" == "y" ] || [ "$download_phpext_mongodb" == "Y" ]; then	
	if [ -s mongo-1.6.1.tgz ]; then
		echo "mongo-1.6.1.tgz [found]"
	else
		echo "mongo-1.6.1.tgz download now..."	
		wget http://pecl.php.net/get/mongo-1.6.1.tgz
	fi
fi


# install memcached
read -p "Do you want download memcached?[y/n]:" download_memcached
if [ "$download_memcached" == "y" ] || [ "$download_memcached" == "Y" ]; then	
	if [ -s libevent-2.0.22-stable.tar.gz ]; then
		echo "libevent-2.0.22-stable.tar.gz [found]"
	else
		echo "libevent-2.0.22-stable.tar.gz download now..."	
		wget http://jaist.dl.sourceforge.net/project/levent/libevent/libevent-2.0/libevent-2.0.22-stable.tar.gz
	fi

	if [ -s memcached-1.4.22.tar.gz ]; then
		echo "memcached-1.4.22.tar.gz [found]"
	else
		echo "memcached-1.4.22.tar.gz download now..."	
		wget http://memcached.org/files/memcached-1.4.22.tar.gz
	fi
fi


# install redis server
read -p "Do you want download redis?[y/n]:" download_redis
if [ "$download_redis" == "y" ] || [ "$download_redis" == "Y" ]; then	
	if [ -s redis-2.8.19.tar.gz ]; then
		echo "redis-2.8.19.tar.gz [found]"
	else
		echo "redis-2.8.19.tar.gz download now..."	
		wget http://download.redis.io/releases/redis-2.8.19.tar.gz
	fi

	if [ -s tcl8.6.3-src.tar.gz ]; then
		echo "tcl8.6.3-src.tar.gz [found]"
	else
		echo "tcl8.6.3-src.tar.gz download now..."	
		wget http://downloads.sourceforge.net/tcl/tcl8.6.3-src.tar.gz
	fi
fi


# install mongo server
read -p "Do you want download mongodb?[y/n]:" download_mongodb
if [ "$download_mongodb" == "y" ] || [ "$download_mongodb" == "Y" ]; then	
	if [ -s mongodb-linux-x86_64-2.6.7.tgz ]; then
		echo "mongodb-linux-x86_64-2.6.7.tgz [found]"
	else
		echo "mongodb-linux-x86_64-2.6.7.tgz download now..."	
		wget http://downloads.mongodb.org/linux/mongodb-linux-x86_64-2.6.7.tgz
	fi
fi


# install ImageMagic and php extension
read -p "Do you want download imagick php extension?[y/n]:" download_phpext_imagemagic
if [ "$download_phpext_imagemagic" == "y" ] || [ "$download_phpext_imagemagic" == "Y" ]; then	
	if [ -s imagick-3.1.2.tgz ]; then
		echo "imagick-3.1.2.tgz [found]"
	else
		echo "imagick-3.1.2.tgz download now..."	
		wget http://pecl.php.net/get/imagick-3.1.2.tgz
	fi
fi

read -p "Do you want download ImageMagick?[y/n]:" download_imagemagic
if [ "$download_imagemagic" == "y" ] || [ "$download_imagemagic" == "Y" ]; then	
	if [ -s ImageMagick-6.8.9-10.tar.gz ]; then
		echo "ImageMagick-6.8.9-10.tar.gz [found]"
	else
		echo "ImageMagick-6.8.9-10.tar.gz download now..."	
		wget http://jaist.dl.sourceforge.net/project/imagemagick/old-sources/6.x/6.8/ImageMagick-6.8.9-10.tar.gz
	fi
fi

printf "\n========= source package download completed =========\n\n"
ls -l | wc -l
ls -l
cd -
printf "============== The End. ==============\n"