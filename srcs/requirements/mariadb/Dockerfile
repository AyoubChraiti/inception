FROM debian:bookworm

RUN apt update -y && apt upgrade -y && apt install -y \
    mariadb-server \
    && rm -rf /var/lib/apt/lists/*

COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/.

COPY tools/script.sh /script.sh

RUN chmod +x /script.sh

EXPOSE 3306

CMD ["/script.sh"]
