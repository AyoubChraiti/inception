#!/bin/bash

# Update PHP-FPM config to listen on TCP instead of socket
sed -i 's#listen = /run/php/php8.2-fpm.sock#listen = 0.0.0.0:9000#' /etc/php/8.2/fpm/pool.d/www.conf

mkdir -p /var/www/html

# Install WP-CLI
cd /tmp
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

# download wp
cd /var/www/html
wp core download --allow-root

cp wp-config-sample.php wp-config.php

sed -i "s#database_name_here#$DB_NAME#g" /var/www/html/wp-config.php
sed -i "s#username_here#$DB_USER#g" /var/www/html/wp-config.php
sed -i "s#password_here#$DB_PASSWORD#g" /var/www/html/wp-config.php
sed -i "s#localhost#$DB_HOST#g" /var/www/html/wp-config.php

if ! wp core is-installed --allow-root --path=/var/www/html; then
    wp core install --url="$WP_URL" \
        --title="$WP_TITLE" \
        --admin_user="$WP_ADMIN" \
        --admin_password="$WP_ADMIN_PASSWORD" \
        --admin_email="$WP_ADMIN_EMAIL" \
        --allow-root --path=/var/www/html

    wp user create "$WP_USER" "$WP_USER_EMAIL" \
        --user_pass="$WP_USER_PASSWORD" \
        --role=author --allow-root --path=/var/www/html
fi

exec /usr/sbin/php-fpm8.2 -F
