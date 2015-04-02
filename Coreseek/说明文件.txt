Coreseek V3.2.14 安装说明

软件用途：分词搜索引擎

一、软件安装

1、安装方式
编译安装

2、安装文件
coreseekInstall.sh	Coreseek源码编译安装

3、安装目录
/usr/local/coreseek

执行文件: /usr/local/coreseek/bin/search 等

二、配置文件
1、文件目录
/usr/local/coreseek/etc/

2、主配置文件
/usr/local/coreseek/etc/csft.conf

三、分词数据存放目录
/usr/local/coreseek/var/data/

四、操作命令
#search keyword
/usr/local/coreseek/bin/search -c /usr/local/coreseek/etc/csft.conf xxx

#start searchd
/usr/local/coreseek/bin/searchd -c /usr/local/coreseek/etc/csft.conf

#stop searchd
/usr/local/coreseek/bin/searchd --stop

#main shell
/usr/local/coreseek/bin/indexer -c /usr/local/coreseek/etc/csft.conf main --rotate
/usr/local/coreseek/bin/indexer -c /usr/local/coreseek/etc/csft.conf delta --rotate

/usr/local/coreseek/bin/indexer -c /usr/local/coreseek/etc/csft.conf --merge main delta --merge-dst-range deleted 0 0 --rotate

#crontab
30	3	*	*	*	/usr/local/coreseek/bin/indexer -c /usr/local/coreseek/etc/csft.conf main --rotate
*/5	*	*	*	*	/usr/local/coreseek/bin/indexer -c /usr/local/coreseek/etc/csft.conf delta --rotate