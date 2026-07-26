#!/bin/sh

# Wait for database running to prevent datarace
until mariadb-admin ping -h"mariadb" --silent; do
    echo "Waiting for MariaDB to be ready..."
    sleep 2
done

echo '[WP Progress] Mariadb ready. Proceeding...'

if [ ! -f /var/www/html/wp-config.php ]; then

    # Download WordPress core files via CLI if not present
    wp core download --allow-root --path='/var/www/html' --force

    # Generate wp-config.php with database credentials from environment
    echo "[WP Progress] Configuring wordpress database..."
    wp config create \
        --dbname="${MYSQL_DATABASE}" \
        --dbuser="${MYSQL_USER}" \
        --dbpass="${MYSQL_PASSWORD}" \
        --dbhost="mariadb" \
        --path='/var/www/html' \
        --allow-root

    # Run core installation
    echo "[WP Progress] Setting up wordpress..."
    wp core install \
        --url="${DOMAIN_NAME}" \
        --title="${WP_TITLE}" \
        --admin_user="${WP_ADMIN_USER}" \
        --admin_password="${WP_ADMIN_PASSWORD}" \
        --admin_email="${WP_ADMIN_EMAIL}" \
        --skip-email \
        --path='/var/www/html' \
        --allow-root

    # Create the secondary non-admin user (Inception requirement)
    echo "[WP Progress] Creating non-admin user..."
    wp user create \
        "${WP_USER}" \
        "${WP_USER_EMAIL}" \
        --role=author \
        --user_pass="${WP_USER_PASSWORD}" \
        --path='/var/www/html' \
        --allow-root

    # Install the theme
    echo "[WP Progress] Installing theme..."
    wp theme install blocksy --activate --path='/var/www/html' --allow-root

    # Ensure correct permissions on host/volume files
    echo "[WP Progress] Adjusting permissions..."
    chown -R www-data:www-data /var/www/html

fi

echo "[WP Progress] Done !"

# Configure PHP-FPM to listen on TCP port 9000 (nginx connects via fastcgi_pass)
sed -i 's|^listen = /run/php/php8.2-fpm.sock|listen = 0.0.0.0:9000|' /etc/php/8.2/fpm/pool.d/www.conf

# Start PHP-FPM in foreground (PID 1)
exec php-fpm8.2 -F