#!/bin/bash

# Check if user is root
if [ $(id -u) != "0" ]; then
    printf "Error: You must be root to run this script!\n"
    exit 1
fi

printf "\n"
printf "==============================================\n"
printf " The file of Nginx VirtualHost Conf create    \n"
printf " copyright: www.doitphp.com                   \n"
printf "==============================================\n"
printf "\n\n"

if [ ! -f /usr/local/nginx/sbin/nginx ]; then
    printf "Error: nginx has not installed! Please install nginx first.\n"
    exit 1
fi

if [ ! -s /usr/local/nginx/domains ]; then
	mkdir -p /usr/local/nginx/domains
fi

echo "Please input the domain name:"
read -p "Domain name:" domain

vhostconf="/usr/local/nginx/domains/"$domain".conf"

if [ -s $vhostconf ]; then
	echo "Sorry "$vhostconf" is exists!";
	exit 0
fi

cat > $vhostconf<<EOF
server {
	listen 80;
	server_name $domain;
	index  index.html index.php;
	root   /www/htdocs/$domain;

	#try_files $uri $uri/ /index.php?$uri&$args;

	location ~ \.php$ {
		fastcgi_pass  127.0.0.1:9000;
		fastcgi_index  index.php;
		include  fastcgi.conf;
	}

	location ~ .*\.(gif|jpg|jpeg|png|bmp|swf)$ {
		expires 30d; 
	} 
	location ~ .*\.(js|css)?$ {
		expires 1h; 
	}
	location ~ .*\.html$ {
		expires 24h; 
	}

	#error_page  403  /errors/403.html;
	#error_page  404  /errors/404.html;
	#error_page  500  /errors/500.html;
	#error_page  502  /errors/502.html;
	#error_page  503  /errors/502.html;
	#error_page  504  /errors/504.html;

	#access_log  /www/logs/nginx/mydomain_access.log  main buffer=16k;
	#error_log  /www/logs/nginx/mydomain_error.log  warn;
}
EOF

cd /usr/local/nginx/domains
ls -l
cat $vhostconf

vhostdir="/www/htdocs/"$domain
if [ ! -s $vhostdir ]; then
	echo "Create VirtualHost directory..."
	mkdir -p $vhostdir
	chown www.www -R $vhostdir
	chmod 0755 -R $vhostdir
fi

isExists=`grep '#include /usr/local/nginx/domains' /usr/local/nginx/conf/nginx.conf | wc -l`
if [ "$isExists" = "1" ]; then
	sed -i 's/#include \/usr\/local\/nginx\/domains/include \/usr\/local\/nginx\/domains/g' /usr/local/nginx/conf/nginx.conf
fi

printf " === create nginx VirtualHost conf complete. === \n\n"

/usr/local/nginx/sbin/nginx -t -c /usr/local/nginx/conf/nginx.conf

read -p "Do you want to restart Nginx?[y/n]:" isrestart
if [ "$isrestart" == "y" ] || [ "$isrestart" == "Y" ]; then
	service nginx restart
fi