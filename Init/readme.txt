一、防火墙配置
1、查看状态
#service iptables status
关闭防火墙
#service iptables stop

二、网络配置
1、查看网络服务是否开启
#cat /etc/sysconfig/network

NETWORKING=yes
HOSTNAME=all-star

2、设置网卡
#vim /etc/sysconfig/network-scripts/ifcfg-eth0

DEVICE=eth0
HWADDR=00:0C:29:60:51:61
TYPE=Ethernet
UUID=81a50dbb-ac4a-4ad2-82e1-9ac7c182580d
ONBOOT=yes
NM_CONTROLLED=yes
BOOTPROTO=static
IPADDR=192.168.0.99
NETMASK=255.255.255.0
GATEWAY=192.168.0.1

3、设置DNS
#vim /etc/resolv.conf

nameserver 8.8.8.8
nameserver 8.8.4.4

4、重启网络
#service network restart

5、查看IP
#ifconfig eth0


三、关闭selinux服务
1、查看状态
#sestatus

2、更改配置文件
#vim /etc/sysconfig/selinux

SELINUX=enforcing --> SELINUX=disabled

SELINUXTYPE=targeted --> #SELINUXTYPE=targeted

3、重启服务器
#init 6 或 shutdown -r now


四、软件升级

1、内核升级
修改yum的配置文件 vim /etc/yum.conf，在[main]的最后添加exclude=kernel*
#yum -y update
注：国外服务器请慎重使用,搞不好yum升级后，服务器整日宕机。

五、服务器时间

1、查看时区
#date -R

Sun, 27 Apr 2014 01:10:36 +0800

2、更改时区
#cp -f /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

3、时间同步
#yum -y install ntpdate

#ntpdate us.pool.ntp.org

六、配置防火墙
#vim /etc/sysconfig/iptables;
在默认的22端口下，添加
-A INPUT -m state --state NEW -m tcp -p tcp --dport 80 -j ACCEPT
-A INPUT -m state --state NEW -m tcp -p tcp --dport 3306 -j ACCEPT

-A INPUT -p icmp --icmp-type 8 -s 0/0 -j DROP

防ping
echo 1 >/proc/sys/net/ipv4/icmp_echo_ignore_all


七、绑定多个IP
配置文件名：ifcfg-eth0-range1

内容(范文)如下：
DEVICE=eth0 
BOOTPROTO=static 
CLONENUM_START=2
IPADDR_START=192.168.1.99 
IPADDR_END=192.168.1.101
NETMASK=255.255.255.1
ONBOOT=yes

附：
查内核:	uname -r
查系统版本: cat /etc/issue

八、安装RZ SZ
yum -y install lrzsz