FROM php:7.4-fpm
RUN mv /etc/apt/sources.list /etc/apt/sources.list.bak \
    && echo "deb https://mirrors.tuna.tsinghua.edu.cn/debian/ buster main contrib non-free" >/etc/apt/sources.list \
    && echo "# deb-src https://mirrors.tuna.tsinghua.edu.cn/debian/ buster main contrib non-free">>/etc/apt/sources.list \
    && echo "deb https://mirrors.tuna.tsinghua.edu.cn/debian/ buster-updates main contrib non-free">>/etc/apt/sources.list \
    && echo "# deb-src https://mirrors.tuna.tsinghua.edu.cn/debian/ buster-updates main contrib non-free">>/etc/apt/sources.list \
    && echo "deb https://mirrors.tuna.tsinghua.edu.cn/debian/ buster-backports main contrib non-free">>/etc/apt/sources.list \
    && echo "# deb-src https://mirrors.tuna.tsinghua.edu.cn/debian/ buster-backports main contrib non-free">>/etc/apt/sources.list \
    && echo "deb https://mirrors.tuna.tsinghua.edu.cn/debian-security buster/updates main contrib non-free">>/etc/apt/sources.list \
    && echo "# deb-src https://mirrors.tuna.tsinghua.edu.cn/debian-security buster/updates main contrib non-free">>/etc/apt/sources.list \
    && apt-get update && apt-get install -y \
        libsasl2-2= 2.1.27+dfsg-1+deb10u2 \
        libssl1.1= 1.1.1n-0+deb10u3 \
        zlib1g= 1:1.2.11.dfsg-1+deb10u2 \
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
