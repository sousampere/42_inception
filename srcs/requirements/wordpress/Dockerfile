FROM debian:bookworm-slim

# Install needed packages
RUN apt update
RUN apt install zip curl php-fpm php-cli php-mysqli wget mariadb-client -y

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp

# # Download Wordpress
# RUN wget https://wordpress.org/latest.zip
# RUN rm -rf /var/www/html/index.html

# # Install wordpress
# RUN mkdir -p /var/www/html \
#     && wget https://wordpress.org/latest.zip \
#     && unzip latest.zip \
#     && mv wordpress/* /var/www/html/ \
#     && rm -rf wordpress latest.zip \
#     && chown -R www-data:www-data /var/www/html/

# # Configure PHP-FPM to listen on TCP port 9000 (nginx connects via fastcgi_pass)
# RUN sed -i 's|^listen = /run/php/php8.2-fpm.sock|listen = 0.0.0.0:9000|' /etc/php/8.2/fpm/pool.d/www.conf

# Run entrypoint
COPY ./config/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

COPY ./config/gaspardtourdiatfr.xml /gaspardtourdiatfr.xml

EXPOSE 9000
ENTRYPOINT ["/entrypoint.sh"]