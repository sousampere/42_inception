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

EXPOSE 3306

USER mysql
CMD ["mariadbd"]
