FROM php:8.2-fpm-alpine

ENV HOME /www-data
USER root

RUN apk add --no-cache \
    $PHPIZE_DEPS \
    openssl-dev 

RUN  apk --update add git zip zlib-dev grep libzip-dev libpng-dev wget  bash openssh-client subversion

RUN docker-php-source extract \
    && docker-php-ext-install pdo_mysql gd zip bcmath mysqli \
    && docker-php-source delete
    
WORKDIR /var/www

EXPOSE 9000