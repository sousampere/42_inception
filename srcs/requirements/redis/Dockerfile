FROM debian:bookworm-slim

# get redis
RUN apt-get update && apt-get install -y redis-server

# configure it for host 0.0.0.0
RUN sed -i 's/127\.0\.0\.1/0.0.0.0/' /etc/redis/redis.conf


ENTRYPOINT ["redis-server", "--protected-mode", "no"]