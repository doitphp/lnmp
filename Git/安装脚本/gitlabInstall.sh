#!/bin/bash

# Check if user is root
if [ $(id -u) != "0" ]; then
    printf "Error: You must be root to run this script!\n"
    exit 1
fi

printf "\n"
printf "============================\n"
printf " GitLab V7.8.1 Install		\n"
printf " copyright: www.doitphp.com \n"
printf "============================\n"
printf "\n\n"

if [ ! -s websrc ]; then    
    printf "Error: directory websrc not found.\n"
    exit 1
fi

cd websrc

groupadd git
useradd -g git git -s /bin/git-shell

mkdir -p /data/git/git-data
chown -R git:git /data/git

yum install openssh-server cronie
lokkit -s http -s ssh

if [ ! -s gitlab-7.8.1_omnibus-1.el6.x86_64.rpm ]; then    
	/usr/bin/wget https://downloads-packages.s3.amazonaws.com/centos-6.6/gitlab-7.8.1_omnibus-1.el6.x86_64.rpm
fi
rpm -i gitlab-7.8.1_omnibus-1.el6.x86_64.rpm

echo "Please input the external url:"
read -p "external url:" external_url

mv /etc/gitlab/gitlab.rb /etc/gitlab/gitlab.rb.bak

cat >/etc/gitlab/gitlab.rb<<EOF
## Url on which GitLab will be reachable.
external_url 'http://$external_url'

## Note: configuration settings below are optional.
gitlab_rails['time_zone'] = 'Asia/Shanghai'
# gitlab_rails['gitlab_email_from'] = 'example@example.com'

## For setting up backups
gitlab_rails['backup_path'] = "/data/git/backups"

## For setting git directory
gitlab_rails['dir'] = "/data/git/gitlab-rails"

## For setting log directory
gitlab_rails['log_directory'] = "/data/git/logs"

## GitLab application settings
gitlab_rails['uploads_directory'] = "/data/git/gitlab-rails/uploads"

## For setting up different data storing directory
git_data_dir "/data/git/git-data"

## GitLab email server settings
gitlab_ci['smtp_enable'] = false
# gitlab_rails['smtp_address'] = "smtp.server"
# gitlab_rails['smtp_port'] = 456
# gitlab_rails['smtp_user_name'] = "smtp user"
# gitlab_rails['smtp_password'] = "smtp password"
# gitlab_rails['smtp_domain'] = "example.com"
# gitlab_rails['smtp_authentication'] = "login"
# gitlab_rails['smtp_enable_starttls_auto'] = true
# gitlab_rails['smtp_tls'] = false
# gitlab_rails['smtp_openssl_verify_mode'] = 'none'

# GitLab Nginx 

# nginx['enable'] = true
# nginx['redirect_http_to_https'] = false
# nginx['redirect_http_to_https_port'] = 80
# nginx['listen_addresses'] = ['*']
# nginx['custom_gitlab_server_config'] = "location ^~ /foo-namespace/bar-project/raw/ {\n deny all;\n}\n"
# nginx['custom_nginx_config'] = "include /etc/nginx/conf.d/example.conf;"

## Advanced settings
# nginx['dir'] = "/var/opt/gitlab/nginx"
# nginx['log_directory'] = "/var/log/gitlab/nginx"

## GitLab user
user['username'] = "git"
user['group'] = "git"
user['home'] = "/data/git"
# user['git_user_name'] = "GitLab"
# user['git_user_email'] = "gitlab@#{node['fqdn']}"
EOF

gitlab-ctl reconfigure

printf "\nUsername: root\nPassword: 5iveL!fe\n "

printf "============== The End. ==============\n"