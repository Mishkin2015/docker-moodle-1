FROM php:fpm-alpine

RUN apk add --no-cache libxml2-dev \
                       libpng-dev \
                       jpeg-dev \
                       icu-dev \
                       libmcrypt-dev \
                       openssl \
                       ssmtp 

RUN docker-php-ext-install xmlrpc \
                           soap \
                           zip \
                           gd \
                           intl \
                           mysqli \
                           mcrypt \
                           opcache

RUN apk del libxml2-dev

ADD www-pool.conf /usr/local/etc/php-fpm.d/www.conf
ADD docker-entrypoint.sh /usr/local/bin/entrypoint.sh

ENTRYPOINT ["entrypoint.sh"]

CMD ["php-fpm"]

