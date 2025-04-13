FROM php:8.4-cli-alpine

# Install cron
RUN apk add --no-cache tini \
    postgresql-dev \
    && docker-php-ext-install pdo pdo_pgsql

# Copy the cron job file and scripts into the image
COPY *.crontab /etc/crontabs/root

# Start cron in the foreground
CMD ["crond", "-f", "-l", "2"]