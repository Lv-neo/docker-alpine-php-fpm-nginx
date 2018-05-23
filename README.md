# 基于alpine的php-fpm nginx环境

* php 7.2
* php module
 * mongodb 1.4.3
 * redis 4.0.2
 * yaconf 1.0.7
 * pdo_mysql
 * opcache
 * mysqli
* nginx 1.14

## base镜像配置
* nginx
https://github.com/nginxinc/docker-nginx/blob/d377983a14b214fcae4b8e34357761282aca788f/stable/alpine/Dockerfile
* php
https://github.com/docker-library/php/blob/b045ba7c51ceed8a495beb8ea7274df48a3c70e1/7.2/alpine3.7/fpm/Dockerfile

## php extension
### core extension
```
docker-php-ext-install -j $(nproc) pdo_mysql opcache mysqli
```
### pecl extension
```
# example
&& ( \
    cd /usr/local/src \
       && tar -zxvf mongodb-$MONGODB_VERSION.tgz  \
       && rm -rf mongodb-$MONGODB_VERSION.tgz \
       && cd mongodb-$MONGODB_VERSION \
       && phpize \
       && ./configure \
       && make -j$(nproc) \
       && make install \
    ) \
    && docker-php-ext-enable mongodb \

```

## php
### php.ini
```
COPY php/php.ini /usr/local/etc/php/
```
### php-fpm
```
COPY php/php-fpm.conf /usr/local/etc/php-fpm.d/www.conf
```
### fpm.log
```
/var/log/php/error.log
/var/log/php/slow.log
```

## nginx 
### conf
```
COPY nginx/nginx.conf      /etc/nginx/nginx.conf
COPY nginx/fastcgi_params  /usr/local/nginx/conf/fastcgi_params
```
### vhost
```
/etc/nginx/vhosts/
```
### log 
```
/var/log/nginx/access.log
/var/log/nginx/error.log
```

## user
* php-fpm www-data
* nginx nginx
* 偷懒chmod 0777

## unix core 
未完待续
