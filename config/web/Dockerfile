FROM php:8.1-apache

ENV PHP_EXTRA_CONFIGURE_ARGS --enable-ftp \
  --enable-intl \
  --enable-opcache \
  --enable-zip \
  --enable-calendar

# Configure PHP
RUN apt-get update -y && \
    apt-get install -y --no-install-recommends \
    apt-utils \
    default-mysql-client \
    gzip \
    cron \
    libxml2-dev \
    libmcrypt4 \
    libmcrypt-dev \
    libpng-dev \
    libjpeg-dev \
    libxml2-dev \
    freetype* \
    libxslt-dev \
    libfreetype6 \
    libfreetype6-dev \
    zlib1g-dev \
    libzip-dev \
    unzip \
    wget \
    locales \
    locales-all \
    && rm -rf /var/lib/apt/lists/*

# Install and enable PHP Modules
RUN docker-php-ext-install calendar && docker-php-ext-enable calendar && \
    docker-php-ext-configure gd --with-jpeg --with-freetype && docker-php-ext-install gd && docker-php-ext-enable gd && \
    docker-php-ext-configure intl && docker-php-ext-install intl && docker-php-ext-enable intl && \
    docker-php-ext-install mysqli && docker-php-ext-enable mysqli && \
    docker-php-ext-install opcache && docker-php-ext-enable opcache && \
    docker-php-ext-install pdo && docker-php-ext-enable pdo && \
    docker-php-ext-install pdo_mysql && docker-php-ext-enable pdo_mysql && \
    docker-php-ext-install soap && docker-php-ext-enable soap && \
    docker-php-ext-install zip && docker-php-ext-enable zip && \
    docker-php-ext-install xsl && docker-php-ext-enable xsl && \
    docker-php-ext-install bcmath && docker-php-ext-enable bcmath && \
    docker-php-ext-install sockets

# Install xdebug
RUN pecl install xdebug

# Install redis
RUN pecl install --nocompress redis

# Install Magerun
RUN curl -sS -o n98-magerun.phar https://files.magerun.net/n98-magerun.phar\
    && curl -sS -o n98-magerun.phar.sha256 https://files.magerun.net/sha256.php?file=n98-magerun.phar\
    && shasum -a 256 -c n98-magerun.phar.sha256\
    && chmod +x n98-magerun.phar\
    && mv n98-magerun.phar /usr/local/bin/magerun

ADD docker-php-ext-xdebug.ini  /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
ADD docker-php-ext-opcache.ini  /usr/local/etc/php/conf.d/docker-php-ext-opcache.ini
ADD php.ini     /usr/local/etc/php/php.ini

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer --version=2.2.18

# Apache SSL Certificate Modules
RUN a2enmod ssl \
            rewrite \
            headers \
            expires \
            actions

#Adding new default user for magento
RUN useradd -ms /bin/bash mageuser \
    && usermod -aG sudo mageuser \
    && chown -R mageuser:mageuser ../html

USER mageuser

# Create aliases
RUN echo 'alias ll="ls -lach"' >> ~/.bashrc
