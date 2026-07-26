#!/bin/sh

# stop the script in case of error
set -e

# Read Docker secrets for sensitive credentials
FTP_USER=${WP_ADMIN_USER}
FTP_PASS=$(cat /run/secrets/WP_ADMIN_PASSWORD)

if ! id "$FTP_USER" >/dev/null 2>&1; then
    useradd -m -d /srv/ftp -s /bin/bash "$FTP_USER"
    echo "$FTP_USER:$FTP_PASS" | chpasswd
    echo "FTP User '$FTP_USER' created successfully."
    
    mkdir -p /var/run/vsftpd/empty
fi

# Make sure permissions are OK for the directory
chown -R "$FTP_USER:$FTP_USER" /srv/ftp

exec vsftpd