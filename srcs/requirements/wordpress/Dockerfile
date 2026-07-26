FROM debian:bookworm-slim

# Install needed packages
RUN apt update
RUN apt install zip curl php-fpm php-cli php-mysqli wget mariadb-client -y

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp

# Clean directory for wordpress
RUN rm -rf /var/www/html/*

# Copy theme
COPY ./config/theme.zip /theme.zip

# Run entrypoint
COPY ./config/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 9000
ENTRYPOINT ["/entrypoint.sh"]