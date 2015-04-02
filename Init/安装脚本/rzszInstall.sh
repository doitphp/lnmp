#!/bin/bash

# Check if user is root
if [ $(id -u) != "0" ]; then
    printf "Error: You must be root to run this script!\n"
    exit 1
fi

printf "\n"
printf "=============================\n"
printf " RZ SZ V3.84 Install		 \n"
printf " copyright : www.doitphp.com \n"
printf "=============================\n"
printf "\n\n"

printf "\n========= RZSZ install start... =========\n\n"

wget http://freeware.sgi.com/source/rzsz/rzsz-3.48.tar.gz
tar zxf  rzsz-3.48.tar.gz
cd src

sed -i 's/^OFLAG= -O/OFLAG= -O -DREGISTERED/g' Makefile
make posix
cp rz sz /usr/bin/

cd -

rm -rf src
rm -rf rzsz-3.48.tar.gz

printf "\n========== RZSZ install Completed! ========\n\n"
printf "============== The End. ==============\n"