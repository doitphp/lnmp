
一、开发环境
php.ini中
display_errors = On


二、生产环境
php.ini中
disable_functions = system,passthru,exec,shell_exec,popen,phpinfo
expose_php = Off
error_log = /www/logs/nginx/php_error.log

三、使用redis存贮session
先决条件：安装redis的PHP扩展

例一：
php.ini设置
	session.save_handler = redis
	session.save_path    = tcp://127.0.0.1:6379

例二：
PHP代码：
	ini_set('session.save_handler', 'redis');
	ini_set('session.save_path', 'tcp://127.0.0.1:6379');