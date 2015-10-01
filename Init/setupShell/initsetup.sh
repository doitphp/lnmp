#!/bin/bash

# Check if user is root
if [ $(id -u) != "0" ]; then
    printf "Error: You must be root to run this script!\n"
    exit 1
fi

printf "\n"
printf "============================\n"
printf " CentOS V6.5 init setup	    \n"
printf " copyright: www.doitphp.com \n"
printf "============================\n"
printf "\n\n"

#show system params
#cpu
printf "\nCPU:\n"
cat /proc/cpuinfo

printf "\nCPU Core Num:\n"
cat /proc/cpuinfo | grep "cpu cores"

printf "\nMemery (unit:M):\n"
free -m

printf "\nMemery (unit:G):\n"
free -g

printf "\nDisk:\n"
df -h

printf "\nLinux Core:\n"
uname -r

printf "\nSystem OS:\n"
cat /etc/system-release

read -p "Do you want continue?[y/n]:" iscontinue
if [ "$iscontinue" == "n" ] || [ "$iscontinue" == "N" ]; then	
    printf "Just finished.\n"
    exit 1
fi

#configure selinx
printf "\nconfigure selinx... \n"

seStatus=`sestatus| awk '{print $3}'`
if [ "seStatus" != "disabled" ]; then
    sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/sysconfig/selinux
    sed -i 's/SELINUXTYPE=targeted/#SELINUXTYPE=targeted/g' /etc/sysconfig/selinux
fi

printf "\nThe result of selinx configure file is :\n\n"
cat /etc/sysconfig/selinux

#configure iptables
printf "\ncheck iptables status :\n"
service iptables status

read -p "Do you want to configure iptables?[y/n]:" isiptables
if [ "$isiptables" == "y" ] || [ "$isiptables" == "Y" ]; then
	read -p "Do you want to open port 3036 for mysql?[y/n]:" isopen3036
	if [ "$isopen3036" == "y" ] || [ "$isopen3036" == "Y" ]; then
		hasSet=`grep "tcp \-\-dport 3036 \-j ACCEPT" /etc/sysconfig/iptables | wc -l`
		if [ "$hasSet" != "1" ]; then
			sed -i '/\-A INPUT \-m state \-\-state NEW \-m tcp \-p tcp \-\-dport 22 \-j ACCEPT/ a\\-A INPUT \-m state \-\-state NEW \-m tcp \-p tcp \-\-dport 3306 \-j ACCEPT' /etc/sysconfig/iptables		
		fi
	fi

	read -p "Do you want to open port 80 for http?[y/n]:" isopen80
	if [ "$isopen80" == "y" ] || [ "$isopen80" == "Y" ]; then
		hasSet=`grep "tcp \-\-dport 80 \-j ACCEPT" /etc/sysconfig/iptables | wc -l`
		if [ "$hasSet" != "1" ]; then
			sed -i '/\-A INPUT \-m state \-\-state NEW \-m tcp \-p tcp \-\-dport 22 \-j ACCEPT/ a\\-A INPUT \-m state \-\-state NEW \-m tcp \-p tcp \-\-dport 80 \-j ACCEPT' /etc/sysconfig/iptables
		fi
	fi

	read -p "Do you want to open port 443 for https?[y/n]:" isopen443
	if [ "$isopen443" == "y" ] || [ "$isopen443" == "Y" ]; then
		hasSet=`grep "tcp \-\-dport 443 \-j ACCEPT" /etc/sysconfig/iptables | wc -l`
		if [ "$hasSet" != "1" ]; then
			sed -i '/\-A INPUT \-m state \-\-state NEW \-m tcp \-p tcp \-\-dport 22 \-j ACCEPT/ a\\-A INPUT \-m state \-\-state NEW \-m tcp \-p tcp \-\-dport 443 \-j ACCEPT' /etc/sysconfig/iptables
		fi
	fi

	read -p "Do you want to open port 873 for rsync?[y/n]:" isopen873
	if [ "$isopen873" == "y" ] || [ "$isopen873" == "Y" ]; then
		hasSet=`grep "tcp \-\-dport 873 \-j ACCEPT" /etc/sysconfig/iptables | wc -l`
		if [ "$hasSet" != "1" ]; then
			sed -i '/\-A INPUT \-m state \-\-state NEW \-m tcp \-p tcp \-\-dport 22 \-j ACCEPT/ a\\-A INPUT \-m state \-\-state NEW \-m tcp \-p tcp \-\-dport 873 \-j ACCEPT' /etc/sysconfig/iptables
		fi
	fi

	cat /etc/sysconfig/iptables

	read -p "Do you want to restart iptables?[y/n]:" isrestart
	if [ "$isrestart" == "y" ] || [ "$isrestart" == "Y" ]; then
		service iptables restart
	fi
fi

#configure network
printf "\ncheck network params :\n"
cat /etc/sysconfig/network

printf "\ncheck servername params :\n"
cat /etc/resolv.conf

printf "\ncheck ipconfig params :\n"
ifconfig

#configure time zone
printf "\nconfigure time zone :\n"
hasTimeZoneSet=`date -R | grep "+0800" | wc -l`
if [ "$hasTimeZoneSet" != "1" ]; then
	cp -f /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
fi

#sync time
yum -y remove openntpd

isntpd=`whereis ntpdate|awk '{print $2}'`
if [ "$isntpd" == "" ]; then
    yum -y install ntpdate
fi

/usr/sbin/ntpdate us.pool.ntp.org
/usr/sbin/hwclock -w

is_ntpd_exists=`grep "/usr/sbin/ntpdate" /etc/rc.local | wc -l`
if [ "$is_ntpd_exists" == "0" ]; then
    echo "/usr/sbin/ntpdate us.pool.ntp.org >/dev/null">>/etc/rc.local
fi

is_crontab_exists=`grep "/usr/sbin/ntpdate" /etc/crontab | wc -l`
if [ "$is_crontab_exists" == "0" ]; then
    echo "1	0,12	*	*	*	root	/usr/sbin/ntpdate us.pool.ntp.org >/dev/null">>/etc/crontab
fi

printf "\ncat /etc/rc.local :\n"
cat /etc/rc.local

printf "\ncat /etc/crontab :\n"
cat /etc/crontab 

#set vim editor 1tab=4space
printf "\nconfigure vim editor 1tab=4space :\n"
if [ ! -f /root/.vimrc ]; then
cat >/root/.vimrc<<EOF
set tabstop=4
set softtabstop=4
set shiftwidth=4
set noexpandtab
set nu
set autoindent
set cindent
EOF
fi

printf "============== The End. ==============\n"