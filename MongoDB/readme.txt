
MongoDB V2.6.7 安装说明

软件用途：Database

一、软件安装

1、安装方式
编译安装

2、安装文件
mongodbInstall.sh		Mongodb2.0源码编译安装
mongodb-yumInstall.sh	Mongodb2.0的yum安装

3、安装目录
/usr/local/mongodb

执行文件: /usr/local/mongodb/bin/mongod
Pid: /var/run/mongod.pid

二、配置文件
1、文件目录
/usr/local/mongodb/etc

2、主配置文件
/usr/local/mongodb/etc/mongodb.conf

三、日志目录
1、日志目录
/var/log/mongodb

2、日志文件
/var/log/mongodb/mongodb.log

四、控制命令
启动 : service mongod start
关闭 : service mongod stop
重启 : service mongod restart

状态查询 ：service mongod status

控制文件目录：/etc/rc.d/init.d/mongod

五、数据存放目录
/data/mongodb

附：
软件附属信息：
group：mongod
user：mongod