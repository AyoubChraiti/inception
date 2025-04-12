FROM debian:bookworm

# Install nginx and openssl
RUN apt-get update && apt-get install -y \
    nginx openssl

COPY tools/script.sh /script.sh
COPY conf/nginx.conf /etc/nginx/conf.d

RUN chmod +x /script.sh

EXPOSE 443

CMD ["/script.sh"]
