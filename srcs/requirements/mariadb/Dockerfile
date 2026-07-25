FROM debian:bookworm-slim

# Set env variable to use non-interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Packages installation
RUN apt update -y
RUN apt install mariadb-server mariadb-client galera-4 -y
RUN rm -rf /var/lib/apt/lists/*

# Create database directories and remove pre-initialized system DB
# (mariadb-server package auto-runs mariadb-install-db during apt install)
RUN mkdir -p /run/mysqld && chown -R mysql:mysql /run/mysqld /var/lib/mysql \
    && rm -rf /var/lib/mysql/*

# MySQL installation
COPY ./conf/entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh

# Modify listening : 127.0.0.1 -> 0.0.0.0
RUN sed -i 's/bind-address\s*=\s*127\.0\.0\.1/bind-address = 0.0.0.0/' /etc/mysql/mariadb.conf.d/50-server.cnf

EXPOSE 3306

USER mysql
ENTRYPOINT ["entrypoint.sh"]
CMD ["mariadbd", "--user=mysql"]
