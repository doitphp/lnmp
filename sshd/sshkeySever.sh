#!/bin/bash

# Check if user is root
if [ $(id -u) != "0" ]; then
    printf "Error: You must be root to run this script!\n"
    exit 1
fi

printf "\n"
printf "================================\n"
printf " update ssh login(use ssh key) 	\n"
printf " copyright:www.doitphp.com      \n"
printf "================================\n"
printf "\n\n"

if [ ! -s /root/.ssh/id_rsa.pub ]; then
	echo "/root/.ssh/id_rsa.pub is not found!";
	printf "create ssh keys start...\n"
	ssh-keygen -t rsa
	cd /root/.ssh
	pwd
	ls -l
	exit 0
fi

printf "Please check ssh private key saved client? \n"
read -p "ssh private key is saved [y/n]:" isset
if [ $isset != 'y' ]; then
    echo "Please save ssh private key first.";
	exit 1
fi

mv /root/.ssh/id_rsa.pub /root/.ssh/authorized_keys
chmod 600 /root/.ssh/authorized_keys

sed -i 's/^#RSAAuthentication yes/RSAAuthentication yes/g' /etc/ssh/sshd_config
sed -i 's/^#PubkeyAuthentication yes/PubkeyAuthentication yes/g' /etc/ssh/sshd_config
sed -i 's/^PasswordAuthentication yes/PasswordAuthentication no/g' /etc/ssh/sshd_config

service sshd restart

printf " === sshd_config has been update success. Please login use ssh private key === \n"