FROM debian:bookworm-slim

RUN apt update && apt install vsftpd -y

EXPOSE 21 20

COPY ./config/vsftpd.conf /etc/vsftpd.conf
COPY ./config/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["./entrypoint.sh"]