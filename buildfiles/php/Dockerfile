FROM php:8.2-fpm

# Set environment and user
ENV HOME /var/www
USER root

# Update and install required dependencies
RUN apt-get update && apt-get install -y \
    git \
    zip \
    unzip \
    zlib1g-dev \
    libzip-dev \
    libpng-dev \
    wget \
    bash \
    openssh-client \
    subversion \
    libssl-dev \
    autoconf \
    gcc \
    g++ \
    make \
    linux-headers-amd64 \
    --no-install-recommends && rm -rf /var/lib/apt/lists/*

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install Node.js and Yarn
RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash - \
    && apt-get install -y nodejs \
    && npm install -g yarn

# Enable and install PHP extensions
RUN docker-php-source extract \
    && docker-php-ext-install \
    pdo_mysql \
    gd \
    zip \
    bcmath \
    mysqli \
    && docker-php-source delete

# Install and configure Xdebug
RUN pecl install xdebug \
    && docker-php-ext-enable xdebug \
    && mv /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini.disabled

# Set working directory
WORKDIR /var/www

# Expose PHP-FPM port
EXPOSE 9000
