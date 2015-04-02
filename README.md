# lnmp
自动搭建Linux+Nginx+PHP+Mysql的运行环境，以及PHP程序相关的Memcached，redis, mongodb等软件的自动安装shell脚本。

目前已在centos 6.5 (64bit)测试正常。

各软件列表:

Nginx V1.7.10
Tengine V2.1

PHP V5.5与V5.6
PHP扩展：memcache, memcached, redis, mongodb, xhprof, yafphp, xdebug, imagick

Mysql V5.6.23
MariaDB V10.0.14
Percona Server V5.6.22

Memcached V1.4.22
Redis V2.8.19
MongoDB V2.6.7

Coreseek V3.2.14
ImageMagic V6.8.9-10
Rsync V3.1.0

Git V2.3.1
Gitolite v3.6.2
GitLab V7.8.1
Ruby V2.2.1

注：如果安装上述软件需要先运行Init中安装脚本：baseInstall.sh 先把编译软件时所需的基本类库等软件安装好。