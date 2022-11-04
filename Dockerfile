FROM php:7.4-fpm
RUN apt-get update && apt-get install -y \
        libmemcached-dev \
        zlib1g-dev \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
        libmcrypt-dev \
        libzip-dev \
    && pecl install igbinary memcache redis \
    && docker-php-ext-enable memcache redis\
    && docker-php-ext-install -j$(nproc) mysqli mysql pdo pdo_mysql mcrypt opcache zip \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd
    
