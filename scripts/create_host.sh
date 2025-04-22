#!/bin/sh

mkdir -p html/${NAME}

printf "Site directory ${NAME} created\n"

DIR_NAME=$(echo "$NAME" | cut -d '.' -f 1)

touch nginx/${NAME}.conf

echo 'server {' >> nginx/${NAME}.conf
echo '    listen 443 ssl;' >> nginx/${NAME}.conf
echo '    server_name '${NAME}';' >> nginx/${NAME}.conf
echo '    ssl_certificate /etc/nginx/certs/'${DIR_NAME}'/'${NAME}'.crt;' >> nginx/${NAME}.conf
echo '    ssl_certificate_key /etc/nginx/certs/'${DIR_NAME}'/'${NAME}'.key;' >> nginx/${NAME}.conf
echo '    root /var/www/html/'${NAME}'/public;' >> nginx/${NAME}.conf
echo '    index index.php;' >> nginx/${NAME}.conf
echo '    location / {' >> nginx/${NAME}.conf
echo '        try_files $uri $uri/ /index.php?$query_string;' >> nginx/${NAME}.conf
echo '    }' >> nginx/${NAME}.conf
echo '    location ~ \.php$ {' >> nginx/${NAME}.conf
echo '        include fastcgi_params;' >> nginx/${NAME}.conf
echo '        fastcgi_pass unix:/var/run/php/'${NAME}'.sock;' >> nginx/${NAME}.conf
echo '        fastcgi_index index.php;' >> nginx/${NAME}.conf
echo '        fastcgi_split_path_info ^(.+\.php)(/.*)$;' >> nginx/${NAME}.conf
echo '        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;' >> nginx/${NAME}.conf
echo '        fastcgi_param HTTP_PROXY "";' >> nginx/${NAME}.conf
echo '    }' >> nginx/${NAME}.conf
echo '}' >> nginx/${NAME}.conf
echo '' >> nginx/${NAME}.conf
echo 'server {' >> nginx/${NAME}.conf
echo '    listen 80;' >> nginx/${NAME}.conf
echo '    server_name '${NAME}';' >> nginx/${NAME}.conf
echo '    root /var/www/html/'${NAME}'/public;' >> nginx/${NAME}.conf
echo '    index index.php;' >> nginx/${NAME}.conf
echo '    location / {' >> nginx/${NAME}.conf
echo '        try_files $uri $uri/ /index.php?$query_string;' >> nginx/${NAME}.conf
echo '    }' >> nginx/${NAME}.conf
echo '    location ~ \.php$ {' >> nginx/${NAME}.conf
echo '        include fastcgi_params;' >> nginx/${NAME}.conf
echo '        fastcgi_pass unix:/var/run/php/'${NAME}'.sock;' >> nginx/${NAME}.conf
echo '        fastcgi_index index.php;' >> nginx/${NAME}.conf
echo '        fastcgi_split_path_info ^(.+\.php)(/.*)$;' >> nginx/${NAME}.conf
echo '        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;' >> nginx/${NAME}.conf
echo '        fastcgi_param HTTP_PROXY "";' >> nginx/${NAME}.conf
echo '    }' >> nginx/${NAME}.conf
echo '}' >> nginx/${NAME}.conf

touch php-fpm/php84/${NAME}.conf

echo '['${NAME}']' >> php-fpm/php84/${NAME}.conf
echo 'user = www-data' >> php-fpm/php84/${NAME}.conf
echo 'group = www-data' >> php-fpm/php84/${NAME}.conf
echo '' >> php-fpm/php84/${NAME}.conf
echo 'listen = /var/run/php/'${NAME}'.sock' >> php-fpm/php84/${NAME}.conf
echo 'listen.owner = www-data' >> php-fpm/php84/${NAME}.conf
echo 'listen.group = www-data' >> php-fpm/php84/${NAME}.conf
echo '' >> php-fpm/php84/${NAME}.conf
echo 'pm = dynamic' >> php-fpm/php84/${NAME}.conf
echo 'pm.max_children = 30' >> php-fpm/php84/${NAME}.conf
echo 'pm.start_servers = 10' >> php-fpm/php84/${NAME}.conf
echo 'pm.min_spare_servers = 5' >> php-fpm/php84/${NAME}.conf
echo 'pm.max_spare_servers = 15' >> php-fpm/php84/${NAME}.conf

printf "Nginx configuration file created\n"

touch services/cron/${NAME}.crontab
touch services/supervisor/${NAME}.ini