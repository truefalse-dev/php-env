#!/bin/sh

rm -r -f html/${NAME}

DIR_NAME=$(echo "$NAME" | cut -d '.' -f 1)

rm -r -f nginx/ssl/${DIR_NAME}/${NAME}.*
rmdir "nginx/ssl/$DIR_NAME"

rm -f nginx/${NAME}.conf
rm -f php-fpm/php84/${NAME}.conf
rm -f services/cron/${NAME}.crontab
rm -f services/supervisor/${NAME}.ini

printf "Site ${NAME} removed\n"