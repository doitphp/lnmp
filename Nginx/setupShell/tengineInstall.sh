#!/bin/bash

# Check if user is root
if [ $(id -u) != "0" ]; then
    printf "Error: You must be root to run this script!\n"
    exit 1
fi

printf "\n"
printf "==========================\n"
printf " Tengine V2.1.1 Install	  \n"
printf "copyright:www.doitphp.com \n"
printf "==========================\n"
printf "\n\n"

if [ ! -s websrc ]; then    
    printf "Error: directory websrc not found.\n"
    exit 1
fi

cd websrc

printf "\n========= source package download start =========\n\n"

if [ -s pcre-8.37.tar.bz2 ]; then
    echo "pcre-8.37.tar.bz2 [found]"
else
    echo "pcre-8.37.tar.bz2 download now..."
	wget http://ncu.dl.sourceforge.net/project/pcre/pcre/8.37/pcre-8.37.tar.bz2
fi

if [ -s tengine-2.1.1.tar.gz ]; then
    echo "tengine-2.1.1.tar.gz [found]"
else
    echo "tengine-2.1.1.tar.gz download now..."
    wget http://tengine.taobao.org/download/tengine-2.1.1.tar.gz
fi

nginxMd5=`md5sum tengine-2.1.1.tar.gz | awk '{print $1}'`
if [ "$nginxMd5" != "357ec313735bce0b75fedd4662f6208c" ]; then
    echo "Error: tengine-2.1.1.tar.gz package md5 value is invalid. Please check package download url";
    exit 1
fi

if [ -s pcre-8.37 ]; then
    rm -rf pcre-8.37   
fi
tar jxvf pcre-8.37.tar.bz2

if [ -s tengine-2.1.1 ]; then
    rm -rf tengine-2.1.1
fi
tar zxvf tengine-2.1.1.tar.gz

printf "\n========= source package download completed =========\n\n"

groupadd www
useradd -g www www -s /bin/false

mkdir -p /www
chown -R www:www /www
chmod 0755 -R /www

mkdir -m 0777 -p /var/log/nginx
mkdir -m 0777 -p /www/logs/nginx

printf "========= pcre install start... =========\n\n"

if [ -s /usr/local/bin/pcregrep ]; then
    echo "pcre has been installed.";
else
	cd pcre-8.37
	./configure --prefix=/usr/local
	make
	make install
	cd -
fi

printf "\n========== pcre install end =============\n\n"
printf "========= check jemalloc whether installed start... =========\n\n"

if [ -s /usr/local/lib/libjemalloc.so ]; then
    echo "jemalloc has been installed.";
else
    if [ -s jemalloc-4.0.3.tar.bz2 ]; then
        echo "jemalloc-4.0.3.tar.bz2 [found]"
    else
        echo "jemalloc-4.0.3.tar.bz2 download now..."
        wget http://www.canonware.com/download/jemalloc/jemalloc-4.0.3.tar.bz2		
    fi

    if [ -s jemalloc-4.0.3 ]; then
        rm -rf jemalloc-4.0.3
    fi
    tar jxvf jemalloc-4.0.3.tar.bz2

    printf "========= jemalloc install start... =========\n\n"

    cd jemalloc-4.0.3
    ./configure --prefix=/usr/local
    make -j 4
    make install
    cd -

    printf "\n========== jemalloc install end =============\n\n"

    isSet=`grep "/usr/local/lib" /etc/ld.so.conf | wc -l`
    if [ "$isSet" != "1" ]; then
       echo "/usr/local/lib">>/etc/ld.so.conf       
    fi
    ldconfig
fi

printf "\n========= check jemalloc whether installed Completed! =========\n\n"
printf "========= Tengine install start... =========\n\n"

cd tengine-2.1.1
./configure --prefix=/usr/local/nginx --user=www --group=www --without-http_memcached_module --without-dso --with-http_stub_status_module --with-http_ssl_module --with-file-aio --with-http_sub_module --with-http_realip_module --with-http_gunzip_module --with-http_gzip_static_module --with-http_image_filter_module --with-jemalloc --with-pcre=../pcre-8.37
make
make test
make install
cd -

cp ../nginx.rcd.txt /etc/rc.d/init.d/nginx
chmod 0755 /etc/rc.d/init.d/nginx

service nginx start
chkconfig nginx on

if [ ! -s /usr/local/nginx/domains ]; then
    mkdir -p /usr/local/nginx/domains
    printf "Folder: /usr/local/nginx/domains has been created.\n"
fi

printf "\n========== Tengine install Completed! =======\n"
ps aux | grep nginx | grep -v "grep"
lsof -n | grep jemalloc | grep -v "sh"
chkconfig --list | grep nginx

mv /usr/local/nginx/conf/nginx.conf /usr/local/nginx/conf/nginx.conf.bak

cat >/usr/local/nginx/conf/nginx.conf<<EOF
user  www www;
worker_processes  auto;
worker_rlimit_nofile  65535;

error_log  /var/log/nginx/error.log;
pid        /var/run/nginx.pid;

events {
	use  epoll;
	worker_connections  65535;
	multi_accept  on;
}

http {
	include       mime.types;
	default_type  application/octet-stream;
	charset       utf-8;

	log_format  main  '\$remote_addr - \$remote_user [\$time_local] "\$request" '
					  '\$status \$body_bytes_sent "\$http_referer" '
					  '"\$http_user_agent" "\$http_x_forwarded_for"';
	
	#access_log  /www/logs/nginx/access.log  main;
	#error_log  /www/logs/nginx/error.log  crit;

	access_log off;	
	error_log  /www/logs/nginx/error.log  warn;

	sendfile       on;
	tcp_nopush     on;	
	tcp_nodelay    on;
	server_tokens  off;
	
	keepalive_timeout  30;
	client_header_timeout  10;
	client_body_timeout  30;
	reset_timedout_connection  on;
	send_timeout  30;
	
	server_names_hash_bucket_size 128; 
	client_header_buffer_size 8k;	
	large_client_header_buffers 8 4k;
	client_max_body_size 8m;

	gzip  on;
	gzip_disable  "msie6";
	gzip_min_length  1k;	
	gzip_comp_level 2;
	gzip_proxied  any;
	gzip_buffers  4  16k; 
	gzip_http_version  1.1;	
	gzip_types  text/plain text/css text/javascript application/x-javascript;
	gzip_vary  on;

	open_file_cache  max=65535  inactive=20s;
	open_file_cache_valid  30s;
	open_file_cache_min_uses  2;
	open_file_cache_errors  on;

	fastcgi_connect_timeout 300;
	fastcgi_send_timeout 300;
	fastcgi_read_timeout 300;
	fastcgi_buffer_size 256k;
	fastcgi_buffers 8 256k;
	fastcgi_busy_buffers_size 256k;
	fastcgi_temp_file_write_size 2048k;

	server {
		listen 80;
		server_name localhost;
		index  index.html index.php;
		root   /www/htdocs/default;

		location ~ \.php\$ {
			fastcgi_pass  127.0.0.1:9000;
			fastcgi_index  index.php;
			include  fastcgi.conf;
		}

		location ~ .*\.(gif|jpg|jpeg|png|bmp|swf)\$ {
			expires 30d; 
		} 
		location ~ .*\.(js|css)?\$ {
			expires 1h; 
		}
		location ~ .*\.html\$ {
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
	
	#VirtualHost
	#include /usr/local/nginx/domains/*.conf;
}
EOF

/usr/local/nginx/sbin/nginx -t -c /usr/local/nginx/conf/nginx.conf

read -p "Do you want to restart Nginx?[y/n]:" isrestart
if [ "$isrestart" == "y" ] || [ "$isrestart" == "Y" ]; then
	service nginx restart
fi

printf "============== The End. ==============\n"