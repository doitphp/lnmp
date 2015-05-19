
Git V2.3.1 安装说明

软件用途：版本控制工具

一、软件安装

1、安装方式
编译安装

2、安装文件
gitInstall.sh		Git源码编译安装
GitlabInstall.sh	GitLab的RPM安装 (gitlab:Git管理工具)
gitoliteInstall.sh  Gitolite编译安装 (Git管理工具)
rubyInstall.sh		Ruby源码编译安装 (开发语言)

3、安装目录
/usr/local/git

执行文件: /usr/local/git/bin/git

二、Git仓库数据存放目录
/data/git

三、初始化Git仓库命令(服务器端)
cd /data/git
git init --bare project.git


三、初始化配置(客户端)
git config --global user.name "username"
git config --global user.email "admin@domain.com"
git config --system color.ui true

查看配置信息
git config --list

注：其实这些配置是存放在个人主目录下的 .gitconfig 文件中,查看方法：
cat ~/.gitconfig


附：GitLab 信息

1、默认用户名及密码
	Username: root
	Password: 5iveL!fe

2、配置文件
	/etc/gitlab/gitlab.rb

3、GitLab的代码数据存放目录
	/data/git/git-data

4、日志目录
	/data/git/logs

5、程序控制
	开启：gitlab-ctl start
	关闭：gitlab-ctl stop
	重启：gitlab-ctl restart

	reload: gitlab-ctl reconfigure

6、Gitolite 信息

安装目录:
	/home/git
仓库目录：
	/home/git/repositories
管理员权限管理Git仓库:
	/home/git/repositories/gitolite-admin.git

注：除gitlab, gitolite管理工具之外，还有gitosis。
详情请见：http://git-scm.com/book/zh/v1/%E6%9C%8D%E5%8A%A1%E5%99%A8%E4%B8%8A%E7%9A%84-Git-Gitosis