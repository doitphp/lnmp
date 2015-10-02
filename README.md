# lnmp
自动搭建Linux+Nginx+PHP+Mysql的运行环境，以及PHP程序相关的Memcached，redis, mongodb等软件的自动安装shell脚本。

目前已在centos 6.x (64bit)测试正常。

各软件列表:

Nginx V1.9.5
Tengine V2.1.1

PHP V5.5.21与V5.6.13
PHP扩展：memcache, memcached, redis, mongodb, xhprof, yafphp, xdebug, imagick

Mysql V5.6.27
MariaDB V10.0.21
Percona Server V5.6.26

Memcached V1.4.24
Redis V3.0.4
MongoDB V3.0.6

Coreseek V3.2.14
ImageMagic V6.8.9-10
Rsync V3.1.0

Git V2.6.0
Gitolite v3.6.2
GitLab V7.8.1
Ruby V2.2.3

注：如果安装上述软件需要先运行Init中安装脚本：baseInstall.sh 先把编译软件时所需的基本类库等软件安装好。