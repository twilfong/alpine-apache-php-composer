#!/bin/sh

SERVER_ADMIN="${SERVER_ADMIN:-you@example.com}"
LOG_LEVEL="${LOG_LEVEL:-info}"
PHP_MEMORY_LIMIT="${PHP_MEMORY_LIMIT:-256M}"

# Change httpd.conf vars based on environmnet
if [ -n "$SERVER_NAME" ]
  then sed -i "s/#ServerName\ www.example.com:80/ServerName\ ${SERVER_NAME}/" /etc/apache2/httpd.conf
fi
sed -i "s/ServerAdmin\ you@example.com/ServerAdmin\ ${SERVER_ADMIN}/" /etc/apache2/httpd.conf
sed -i "s#^LogLevel .*#LogLevel ${LOG_LEVEL}#g" /etc/apache2/httpd.conf

# Modify php memory limit
sed -i "s/memory_limit = .*/memory_limit = ${PHP_MEMORY_LIMIT}/" /etc/php81/php.ini

httpd -D FOREGROUND
