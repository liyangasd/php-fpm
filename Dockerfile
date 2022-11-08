FROM php:7.4-fpm
RUN apt-get update && apt-get install -y  \
        libmemcached-dev \
        zlib1g-dev \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
        libmcrypt-dev \
        libzip-dev \
        libssl-dev git \
    && git clone https://github.com/cdoco/php-jwt.git /tmp/php-jwt \
    && cd /tmp/php-jwt && phpize && ./configure && make && make install \
    && pecl install igbinary memcache redis \
    && docker-php-ext-enable memcache redis jwt \
    && docker-php-ext-install -j$(nproc) mysqli pdo pdo_mysql opcache zip \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd

