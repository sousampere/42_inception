FROM debian:bookworm-slim

# Packages installation
RUN apt update -y
RUN sudo apt install mariadb-server mariadb-client galera-4

# Install mariadb server
RUN sudo mariadb-secure-installation

EXPOSE 3306
CMD ["mariadb"]
