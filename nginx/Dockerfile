FROM nginx:alpine-slim

RUN apk update && apk add --no-cache openssl

COPY *.conf /etc/nginx/conf.d/
COPY ssl.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/ssl.sh

CMD ["sh", "-c", "/usr/local/bin/ssl.sh && nginx -g 'daemon off;'"]