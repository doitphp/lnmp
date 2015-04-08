#!/bin/bash

# Check if user is root
if [ $(id -u) != "0" ]; then
    printf "Error: You must be root to run this script!\n"
    exit 1
fi

printf "\n"
printf "============================\n"
printf " PostFix V2.6.6 Install	    \n"
printf " copyright: www.doitphp.com \n"
printf "============================\n"
printf "\n\n"

if [ ! -s websrc ]; then    
    printf "Error: directory websrc not found.\n"
    exit 1
fi

printf "========= check postfix install whether or not =========\n\n"

isPostFix=`service postfix status | grep 'is running' | wc -l`
if [ "$isPostFix" == "0" ]; then
    yum -y remove sendmail
	yum -u install postfix
	yum -y install cyrus-sasl
fi

printf "\npostfix version:\n"
postconf mail_version

printf "\npostfix configure file:\n"
cat /etc/postfix/main.cf

if [ -f /etc/sasl2/smtpd.conf ]; then
	printf "\nsmtpd.conf file:\n"
	cat /etc/sasl2/smtpd.conf
fi

chkconfig --list | grep posfix
chkconfig --list | grep saslauthd

#configure postfix file
read -p "smtp server domain name:" domain

mv /etc/postfix/main.cf /etc/postfix/main.cf.bak
cat >/etc/postfix/main.cf<<EOF
myhost= smtp.$domain
mydomain = $domain
myorigin = \$mydomain
inet_interfaces = all
mydestination = \$myhostname, \$mydomain
relay_domains = \$mydestination

#mynetworks = 192.168.1.0/100, 127.0.0.0/8 
#home_mailbox = maildir/

mail_name = Postfix - $domain
smtp_helo_name = smtp.$domain
smtpd_banner = \$myhostname ESMTP unknow
smtpd_sasl_auth_enable = yes
smtpd_recipient_restrictions = permit_mynetworks,permit_sasl_authenticated,reject_unauth_destination
smtpd_sasl_security_options = noanonymous

bounce_queue_lifetime = 1d
maximal_queue_lifetime = 1d
message_size_limit = 15728640 
local_recipient_maps =
unknown_local_recipient_reject_code = 550
EOF

service postfix stop
service postfix start

service saslauthd stop
service saslauthd start

chkconfig postfix on
chkconfig saslauthd on

alternatives --config mta

printf "\n========== Postfix install Completed! =======\n\n"

printf "============== The End. ==============\n"