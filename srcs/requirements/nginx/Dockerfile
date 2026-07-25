FROM debian:bookworm-slim

# Packages installation
RUN apt update -y
RUN apt install nginx -y
RUN apt install openssl -y
RUN rm -f /etc/nginx/conf.d/default.conf /etc/nginx/sites-enabled/default

# SSL certificate singing
RUN openssl req -new -x509 -days 365 -noenc -out /etc/nginx/certificate.pem -keyout /etc/nginx/certificate.key -subj "/C=US/ST=State/L=City/O=42/CN=localhost"
COPY ./conf/ssl.conf /etc/nginx/conf.d/ssl.conf

# Copy configuration
COPY ./conf/nginx.conf /etc/nginx/nginx.conf

EXPOSE 443
CMD ["nginx", "-g", "daemon off;"]
