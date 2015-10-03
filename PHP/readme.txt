
PHP V5.5.21/V5.6.13 安装说明

软件用途：执行PHP文件

一、软件安装

1、安装方式
编译安装

2、安装文件
php5.5Install.sh	PHP V5.5编译安装                
php5.6Install.sh	PHP V5.6编译安装(默认)

3、安装目录
/usr/local/php5

执行文件: /usr/local/php5/bin/php
Pid: /usr/local/php5/var/run/php-fpm.pid

二、配置文件
1、文件目录
/usr/local/php5/etc

2、主配置文件
/usr/local/php5/etc/php.ini
/usr/local/php5/etc/php-fpm.conf

三、PHP扩展目录
/usr/local/php5/lib/php/extensions/no-debug-zts-20xxx

四、控制命令
启动 : service php-fpm start
关闭 : service php-fpm stop
重启 : service php-fpm restart

状态查询 ：service php-fpm status

控制文件目录：/etc/rc.d/init.d/php-fpm


附：
软件附属信息：
group：www
user：www

在CLI环境下执行某PHP文件：
/usr/local/php5/bin/php -f /xx/phpfilepath.php

查询所使用的PHP扩展：
/usr/local/php5/bin/php -m

查询PHP版本信息：
/usr/local/php5/bin/php -v

查询PHP的配置文件路径
/usr/local/php5/bin/php --ini