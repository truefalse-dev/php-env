#!/bin/sh

DOMAINS=""
for file in /etc/nginx/conf.d/*; do
    filename=$(basename $file .conf)
    if [ "$filename" != "default" ]; then
        DOMAINS="$DOMAINS $filename"
    fi    
done

for DOMAIN in $DOMAINS; do

    DIR_NAME=$(echo "$DOMAIN" | cut -d '.' -f 1)
    CERT_NAME="$DOMAIN"
    CERT_DIR="/etc/nginx/certs/$DIR_NAME"
    CERT_KEY="$CERT_DIR/$CERT_NAME.key"
    CERT_PEM="$CERT_DIR/$CERT_NAME.crt"

    if [ ! -f $CERT_KEY ]; then
        echo "Generating self-signed certificate for $CERT_NAME ..."

        mkdir -p $CERT_DIR

        openssl req -new -nodes -x509 -newkey rsa:2048 -keyout $CERT_KEY \
            -out $CERT_PEM -days 365 \
            -subj "/OU=Dev/O=Truefalse/CN=$CERT_NAME" \
            -extensions v3_req \
            -config <(cat /etc/ssl/openssl.cnf \
            <(printf "[v3_req]\nsubjectAltName=DNS:$CERT_NAME"))

        echo "Self-signed SSL certificate created successfully at $CERT_PEM"
    else
        echo "Certificate already exists."
    fi
done    

