
Memcached V1.4.24 安装说明

软件用途：NoSql Database

一、软件安装

1、安装方式
编译安装

2、安装文件
memcachedInstall.sh	原生memcached安装


3、安装目录
/usr/local/memcached

执行文件: /usr/local/memcached/bin/memcached
Pid: /var/run/memcached/memcached.pid

二、配置文件
1、文件目录
/usr/local/memcached/etc/

2、主配置文件
/usr/local/memcached/etc/memcached.conf

三、控制命令
启动 : service memcached start
关闭 : service memcached stop
重启 : service memcached restart

状态查询 ：service memcached status

控制文件目录：/etc/rc.d/init.d/memcached


附：
一、查看memcached运行状态
#telnet localhost 11211

stats			显示服务器信息、统计数据等
stats reset		清空统计数据