#!/bin/bash

printf "\n"
printf "============================\n"
printf " Gitolite v3.6.2 Install	\n"
printf " copyright: www.doitphp.com \n"
printf "============================\n"
printf "\n\n"

# Check if user is root
if [ $(id -u) != "0" ]; then
    printf "Error: You must be root to run this script!\n"
    exit 1
fi

if [ -f /home/git/.ssh/authorized_keys ]; then
    printf "Error: make sure authorized_keys not exists?\n"
    exit 1
fi
if [ ! -f /root/tommy.pub ]; then
    printf "Error: Are you ready? your admin ssh public key is not exists!\n"
    exit 1
fi

#install openssh
yum -y install openssh-server cronie
lokkit -s http -s ssh

#add user
useradd --system --shell /bin/bash --create-home git
#set git password
passwd git

printf "new user has been added!\n"

mv /root/tommy.pub /home/git/tommy.pub
chown git.git /home/git/tommy.pub

#make directory and file
if [ ! -s /home/git/bin ]; then
	mkdir -p /home/git/bin
	chown -R git.git /home/git/bin
fi
if [ ! -s /home/git/.ssh ]; then
	mkdir -p /home/git/.ssh
	chown -R git.git /home/git/.ssh
fi
touch /home/git/.ssh/authorized_keys
chown git.git /home/git/.ssh/authorized_keys

#download gitolite
cd /home/git
git clone git://github.com/sitaramc/gitolite
chown -R git.git gitolite

printf "\n gitolite downloaded already!\n"

su - git <<!
/home/git/gitolite/install -to /home/git/bin;
/home/git/bin/gitolite setup -pk /home/git/tommy.pub
exit
!

#check wether gitolite installed
if [ ! -f /home/git/bin/gitolite ]; then
    printf "Error: gitolite install failed!\n"
    exit 1
fi
if [ ! -s /home/git/repositories ]; then
    printf "Error: gitolite setup failed!\n"
    exit 1
fi

rm -rf /home/git/tommy.pub

#set PATH
isSet=`grep "/home/git/bin" /etc/profile | wc -l`
if [ "$isSet" == "0" ]; then
	hsExport=`grep "export PATH=" /etc/profile | wc -l`
	if [ "$hsExport" == "0" ]; then
		echo "export PATH=$PATH:/home/git/bin">>/etc/profile
	else
		sed -i 's/^export PATH=/&\/home\/git\/bin:/g' /etc/profile
	fi
fi
ldconfig

printf "\n gitolite setup already!\n"

printf "============== The End. ==============\n"