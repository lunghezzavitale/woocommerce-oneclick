#!/bin/bash

echo "Fixing WordPress filesystem permissions..."

mkdir -p \
    /var/www/html/wp-content/plugins \
    /var/www/html/wp-content/themes \
    /var/www/html/wp-content/uploads \
    /var/www/html/wp-content/upgrade

chown -R www-data:www-data /var/www/html/wp-content
chmod 755 /var/www/html/wp-content
chmod 755 /var/www/html/wp-content/plugins
chmod 755 /var/www/html/wp-content/themes
chmod 755 /var/www/html/wp-content/uploads
chmod 755 /var/www/html/wp-content/upgrade

run_setup() {
    while [ ! -d /var/www/html/wp-content/plugins ]; do
        sleep 2
    done

    /usr/local/bin/setup-wordpress.sh

    echo "Repairing ownership after WP-CLI setup..."
    chown -R www-data:www-data /var/www/html/wp-content
}

echo "OK" > /var/www/html/healthz.html

(sleep 10 && run_setup) &

exec docker-entrypoint.sh "$@"
