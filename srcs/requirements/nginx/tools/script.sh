#!/bin/sh

mkdir -p /etc/nginx/certs
openssl req -x509 -nodes -newkey rsa:2048 \
    -keyout /etc/nginx/certs/achraiti.key \
    -out /etc/nginx/certs/cert.crt \
    -days 365 \
    -subj "/CN=achraiti.42.fr" \

nginx -g "daemon off;"
