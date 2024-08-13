FROM php:8.2-fpm-alpine

ENV HOME /www-data
USER root

RUN apk add --no-cache \
    $PHPIZE_DEPS \
    openssl-dev \
    autoconf \
    linux-headers

RUN apk --update add git zip zlib-dev grep libzip-dev libpng-dev wget bash openssh-client subversion

RUN docker-php-source extract \
    && docker-php-ext-install pdo_mysql gd zip bcmath mysqli \
    && docker-php-source delete

RUN pecl install xdebug \
    && docker-php-ext-enable xdebug

# disable xdebug
# && mv /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini.disabled

WORKDIR /var/www

EXPOSE 9000
