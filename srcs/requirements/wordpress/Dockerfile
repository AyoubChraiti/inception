FROM debian:bookworm

RUN apt-get update -y \
    && apt-get install \
    php8.2-fpm \
    php8.2-mysql \
    php8.2-cli \
    php8.2-curl \
    php8.2-gd \
    php8.2-mbstring \
    php8.2-xml \
    php8.2-zip \
    curl -y \
    && rm -rf /var/lib/apt/lists/*

COPY tools/script.sh /root/script/ws.sh

RUN chmod +x /root/script/ws.sh

EXPOSE 9000

CMD ["sh", "/root/script/ws.sh"]