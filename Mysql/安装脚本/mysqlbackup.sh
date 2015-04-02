#!/bin/bash

host="localhost"
username="userName"
password="mysqlPassword"
database="databaseName"

cd /home/dataBack
newdate=$(date +%Y%m%d)
olddate=$(date +%Y%m%d -d '5 days ago')
newfile=$database$newdate".sql"
oldfile=$database$olddate".sql"

if [ -s $newfile ]; then
	echo "mysql data has been backuped!"
	exit 0
fi

/usr/local/mysql/bin/mysqldump -h$host -u$username -p$password $database>$newfile

if [ -s $oldfile ]; then
	rm -rf $oldfile
fi

printf "success!\n";
