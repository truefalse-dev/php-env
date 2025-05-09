FROM php:8.4-fpm-alpine

RUN apk add --no-cache jpeg-dev zlib-dev libpng-dev zip npm \
    postgresql-dev \
    && docker-php-ext-install opcache pdo gd pdo_pgsql exif

RUN mkdir -p /var/run/php && chown www-data:www-data /var/run/php    

COPY opcache.ini /usr/local/etc/php/conf.d/opcache.ini 
COPY *.conf /usr/local/etc/php-fpm.d
COPY php.ini /usr/local/etc/php/conf.d/custom.ini

RUN sed -i '/\[www\]/,$d' /usr/local/etc/php-fpm.d/zz-docker.conf

# Install Composer globally
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Add Composer to the PATH
ENV PATH="$PATH:/usr/local/bin"