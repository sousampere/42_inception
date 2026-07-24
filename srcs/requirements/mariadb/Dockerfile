FROM debian:bookworm-slim

# Set env variable to use non-interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Packages installation
RUN apt update -y
RUN apt install mariadb-server mariadb-client galera-4 -y

# Create database directories
RUN mkdir -p /run/mysqld && chown -R mysql:mysql /run/mysqld /var/lib/mysql

# Install mariadb server
RUN mariadb-install-db --user=mysql --datadir=/var/lib/mysql

# Modify listening : 127.0.0.1 -> 0.0.0.0
RUN sed -i 's/bind-address\s*=\s*127\.0\.0\.1/bind-address = 0.0.0.0/' /etc/mysql/mariadb.conf.d/50-server.cnf

EXPOSE 3306

USER mysql
CMD ["mariadbd"]
