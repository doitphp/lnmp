
Mysql V5.6.27 安装说明

软件用途：Database

一、软件安装

1、安装方式
编译安装

2、安装文件
mysqlInstall.sh						官方Mysql源文件安装
mysql-jemallocInstall.sh			官方Mysql源文件安装(+jemalloc)
mariadbInstall.sh					Mariadb源文件安装
mariadb-jemallocInstall.sh			Mariadb源文件安装(+jemalloc)
perconaserverInstall.sh				PerconaServer源文件安装
perconaserver-jemallocInstall.sh	PerconaServer源文件安装(+jemalloc)
mysqlbackup.sh						mysqldump备份数据自动化脚本(非安装文件)

3、安装目录
/usr/local/mysql

执行文件: /usr/local/mysql/bin/mysql
Pid: /var/run/mysqld/mysql.pid
套接文件：/var/run/mysqld/mysql.sock

二、配置文件
1、文件目录
/etc

2、主配置文件
/etc/my.cnf

三、数据存放目录
/data/mysql

四、日志文件
错误日志：/var/log/mysql/mysql-error.log

五、控制命令
启动 : service mysqld start
关闭 : service mysqld stop
重启 : service mysqld restart

状态查询 ：service mysqld status

控制文件目录：/etc/rc.d/init.d/mysqld


附：
软件附属信息：
group：mysql
user：mysql

MySql如何开通远程登陆

一、授权法(推荐)
1、通用
GRANT ALL PRIVILEGES ON *.* TO 用户名@'%' IDENTIFIED BY '登陆密码' WITH GRANT OPTION;
2、只允许某IP登陆
GRANT ALL PRIVILEGES ON *.* TO 用户名@'IP地址' IDENTIFIED BY '登陆密码' WITH GRANT OPTION;
3、只允许登陆某个数据库
GRANT ALL PRIVILEGES ON 数据库名.* TO 用户名@'%' IDENTIFIED BY '登陆密码' WITH GRANT OPTION;

执行完上面SQL语句后，再执行：FLUSH PRIVILEGES;
否则不生效

二、更改数据表法
权限控制表：mysql.user

例如更改root用户的远程登陆权限：
执行如下SQL语句：
update user set host = '%' where user = 'root';  

查看结果
select host, user from user; 

为某用户开通权限

一、创建新用户
CREATE USER '用户名'@'localhost' IDENTIFIED BY '登陆密码';

二、授权(增、删、改、查)
GRANT SELECT, INSERT, UPDATE, DELETE ON *.* TO '用户名'@'%';

GRANT ALL PRIVILEGES ON *.* TO '用户名'@'%';

三、更改密码
GRANT ALL PRIVILEGES ON *.* TO '用户名'@'%' IDENTIFIED BY '登陆密码';
再执行：FLUSH PRIVILEGES;

四、撤消授权 
REVOKE ALL PRIVILEGES ON * . * FROM '用户名'@'%';
REVOKE GRANT OPTION ON * . * FROM '用户名'@'%';

五、Root用户密码

设置root密码
mysqladmin -u root password "newpass"
更改root密码
mysqladmin -u root password oldpass "newpass"

或执行SQL语句
SET PASSWORD FOR 'root'@'localhost' = PASSWORD('newpassword')

安全设置
1、线上Mysql Server，root只允许本地登陆，且密码为32位
2、主库与从库数据同步采用新的帐户,不可用root
3、web程序连接mysql，其所用帐户启用新帐户，且只有数据的增删改查的权限。
4、如果线上的数据库开通外联接,绑定其IP地址及定义外链接的IP地址。