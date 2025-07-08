FROM litespeedtech/openlitespeed:latest

# Install PHP extensions
RUN apt-get update && apt-get install -y \
    git \
    cron \
    lsphp82 \
    lsphp82-mysql \
    lsphp82-curl \
#     lsphp82-mbstring \
#     lsphp82-xml \
#     lsphp82-zip \
#     lsphp82-bcmath \
#     # lsphp82-gd \
#     lsphp82-intl \
#     lsphp82-opcache \
    && rm -rf /var/lib/apt/lists/*

# Set default PHP version
# RUN ln -sf /usr/local/lsws/lsphp82/bin/lsphp /usr/local/lsws/fcgi-bin/lsphp

# # Set correct permissions for Laravel storage & bootstrap/cache
# RUN mkdir -p /var/www/html/storage /var/www/html/bootstrap/cache \
#     && chmod -R 777 /var/www/html/storage /var/www/html/bootstrap/cache

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install Node.js and Yarn
RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash - \
    && apt-get install -y nodejs \
    && npm install -g yarn

COPY buildfiles/litespeed/entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh

# Set document root to Laravel's public folder
WORKDIR /var/www

# Expose LiteSpeed & Admin Panel Ports
EXPOSE 8088 8089 7080 443
ENTRYPOINT ["entrypoint.sh"]
