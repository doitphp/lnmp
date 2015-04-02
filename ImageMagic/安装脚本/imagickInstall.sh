#!/bin/bash

# Check if user is root
if [ $(id -u) != "0" ]; then
    printf "Error: You must be root to run this script!\n"
    exit 1
fi

printf "\n"
printf "===============================\n"
printf " ImageMagic V6.8.9-10 Install  \n"
printf " copyright: www.doitphp.com	   \n"
printf "===============================\n"
printf "\n\n"

if [ ! -s websrc ]; then    
    printf "Error: directory websrc not found.\n"
    exit 1
fi

cd websrc

printf "========= ImageMagic install start... =========\n\n"

if [ -s ImageMagick-6.8.9-10.tar.gz ]; then
    echo "ImageMagick-6.8.9-10.tar.gz [found]"
else
    echo "ImageMagick-6.8.9-10.tar.gz download now..."
	wget http://jaist.dl.sourceforge.net/project/imagemagick/old-sources/6.x/6.8/ImageMagick-6.8.9-10.tar.gz	
fi

if [ ! -f ImageMagick-6.8.9-10.tar.gz ]; then
    printf "Error: ImageMagick-6.8.9-10.tar.gz not found!\n"
    exit 1
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

if [ -s jpeg-9a ]; then
    rm -rf jpeg-9a
fi
tar zxvf jpegsrc.v9a.tar.gz

if [ -s libpng-1.6.2 ]; then
    rm -rf libpng-1.6.2
fi
tar zxvf libpng-1.6.2.tar.gz

if [ -s ImageMagick-6.8.9-10 ]; then
    rm -rf ImageMagick-6.8.9-10
fi
tar zxvf ImageMagick-6.8.9-10.tar.gz

cd jpeg-9a
./configure --prefix=/usr/local
make libdir=/usr/lib64   
make libdir=/usr/lib64 install
cd -

cd libpng-1.6.2
./configure --prefix=/usr/local
make libdir=/usr/lib64   
make libdir=/usr/lib64 install
cd -

cd ImageMagick-6.8.9-10
./configure --enable-shared --enable-modules
make
make install
cd -

printf "\n========== ImageMagic install Completed! ========\n\n"
whereis convert
printf "============== The End. ==============\n"