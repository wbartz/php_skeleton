FROM php:7.1-fpm

MAINTAINER William Bartz <williamf.brtz@gmail.com>

ARG FOLDER
WORKDIR /var/www

COPY ./php.ini /usr/local/etc/php/
COPY ./init.sh /var/www

RUN apt-get update && apt-get install -y \
    libpq-dev \
    curl \
    git \
    unzip

# Install extensions using the helper script provided by the base image
RUN docker-php-ext-install \
    pdo_mysql \
    pdo_pgsql

RUN usermod -u 1000 www-data

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
RUN php -r "if (hash_file('sha384', 'composer-setup.php') === '93b54496392c062774670ac18b134c3b3a95e5a5e5c8f1a9f115f203b75bf9a129d5daa8ba6a13e2cc8a1da0806388a8') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
RUN php composer-setup.php --install-dir=/usr/bin --filename=composer
RUN php -r "unlink('composer-setup.php');"
RUN composer global require "laravel/lumen-installer"
RUN composer require vlucas/phpdotenv
RUN composer create-project --prefer-dist laravel/lumen project

COPY ./.env /var/www/project
COPY ./common/app.php /var/www/project/bootstrap/app.php
