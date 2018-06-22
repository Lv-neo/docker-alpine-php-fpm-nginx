#! /bin/sh
nginx="/usr/sbin/nginx"
NGINX_CONF_FILE="/etc/nginx/nginx.conf"

echo "start nginx..."
$nginx -c $NGINX_CONF_FILE

echo "start php-fpm..."
php-fpm --daemonize

tail -f /dev/null