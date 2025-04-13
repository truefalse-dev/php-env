FROM php:8.4-fpm-alpine

# Install cron
RUN apk add --no-cache \
    postgresql-dev \
    && docker-php-ext-install pdo pdo_pgsql

RUN apk update && apk add --no-cache supervisor

COPY supervisord.conf /etc/supervisord.conf
COPY *.ini /etc/supervisor.d/

CMD ["/usr/bin/supervisord", "-n", "-c",  "/etc/supervisord.conf"]
