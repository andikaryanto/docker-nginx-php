FROM php:8.2-fpm-alpine

RUN docker-php-source extract \
    && docker-php-ext-install pdo_mysql gd zip bcmath sockets curl mbstring mysqli \
    && docker-php-source delete
    
WORKDIR /var/www

EXPOSE 9000