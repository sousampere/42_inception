#!/bin/bash
set -e

# Initialize datadir if empty
if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Initializing MariaDB data directory..."
    mariadb-install-db --user=mysql --datadir=/var/lib/mysql > /dev/null

    # Start temp server to configure DB and users
    mariadbd --user=mysql --skip-networking &
    pid="$!"

    # Wait for MariaDB to boot
    for i in {30..0}; do
        if mariadb-admin ping &>/dev/null; then
            break
        fi
        sleep 1
    done

    # Set up database and remote user
    MYSQL_DATABASE=${MYSQL_DATABASE:-wordpress}
    MYSQL_USER=${MYSQL_USER:-wp_user}
    MYSQL_PASSWORD=${MYSQL_PASSWORD:-wp_password}
    MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD:-root_password}

    echo "Creating database '$MYSQL_DATABASE' and user '$MYSQL_USER'..."
    mariadb <<EOF
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';
FLUSH PRIVILEGES;
EOF

    # Stop temporary server
    if ! kill -s TERM "$pid" || ! wait "$pid"; then
        echo "Failed to stop temporary MariaDB server"
        exit 1
    fi
    echo "MariaDB initialization complete."
fi

exec "$@"