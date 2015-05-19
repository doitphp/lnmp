
Rsync v3.1.0 安装说明

软件用途：多台Linux Server之间的数据同步

一、软件安装

1、安装方式
编译安装

2、安装文件
rsyncInstall.sh		Rsync源码编译安装
inotifyInstall.sh	inotify-tools源码编译安装安装(用于监控服务器某个目录内的文件变化，以便及时触发rsync进行数据同步)

3、安装目录
/usr/local/rsync

执行文件: /usr/local/rsync/bin/rsync
Pid: /usr/local/rsync/logs/rsyncd.pid

二、配置文件
1、文件目录
/usr/local/rsync/etc

2、主配置文件
/usr/local/rsync/etc/rsyncd.conf

3、用户配置文件(帐号密码)
/usr/local/rsync/etc/rsyncd.pass

三、日志目录
1、日志目录
/usr/local/rsync/logs

2、日志文件
/usr/local/rsync/logs/rsyncd.log

四、控制命令
启动 : service rsyncd start
关闭 : service rsyncd stop
重启 : service rsyncd restart

状态查询 ：service rsyncd status

控制文件目录：/etc/rc.d/init.d/rsyncd


附：
软件附属信息：
group：nobody
user：nobody

1、推送文件至某服务器
	cd /www/xx;
	rsync -arP --delete --password-file=/xx/user.pass --exclude-from=/xx/not_sync_list.txt * username@10.50.201.187::blockname;
	
2、从某服务器上下载文件
	/usr/local/rsync/bin/rsync -azP --password-file=/xx/sitename.pass goldenman@10.50.201.98::video /www/video;
注：/www/video 为下载后文件存放的目录

3、rsync无法实现chkconfig自动启动，需要在/etc/rc.local中加入如下命令
/usr/local/rsync/bin/rsync --daemon --config=/usr/local/rsync/etc/rsyncd.conf