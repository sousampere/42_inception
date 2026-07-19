FROM debian:bookworm-slim

RUN apt update -y
RUN apt install nginx -y
RUN apt install certbot python3-certbot-nginx
RUN certbot --nginx -d gtourdia.42.fr -d www.gtourdia.42.fr

COPY ./conf/nginx.conf /etc/nginx/nginx.conf
EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
# CMD ["cat","/etc/nginx/nginx.conf"]