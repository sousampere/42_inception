FROM debian:bookworm-slim

RUN apt update -y
RUN apt install nginx -y

CMD ["nginx", "-g", "daemon off;"]