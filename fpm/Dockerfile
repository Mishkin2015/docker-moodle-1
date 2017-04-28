FROM php:fpm-alpine

RUN apk add --no-cache libxml2-dev \
                       libpng-dev \
                       jpeg-dev \
                       icu-dev \
                       libmcrypt-dev \
                       openssl 

RUN docker-php-ext-install xmlrpc \
                           soap \
                           zip \
                           gd \
                           intl \
                           mysqli \
                           mcrypt \
                           opcache

RUN apk del libxml2-dev

