
Redis V3.0.4 安装说明

软件用途：NoSql Database

一、软件安装

1、安装方式
编译安装

2、安装文件
redisInstall.sh redis编译安装

3、安装目录
/usr/local/redis

执行文件: /usr/local/redis/bin/redis-server
Pid: /var/run/redis/redis.pid
套接文件：/var/run/redis/redis.sock

二、配置文件
1、文件目录
/usr/local/redis/etc/

2、主配置文件
/usr/local/redis/etc/redis.conf

三、日志文件
日志目录：
/var/log/redis/
日志文件：
/var/log/redis/redislog

四、控制命令
启动 : service redisd start
关闭 : service redisd stop
重启 : service redisd restart

状态查询 ：service redisd status

控制文件目录：/etc/rc.d/init.d/redisd

五、数据存放目录
/data/redis