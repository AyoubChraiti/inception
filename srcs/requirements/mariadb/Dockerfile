FROM debian:bookworm

RUN apt update && apt upgrade && apt install -y \
    mariadb-server \
    php-mysqli \
    && rm -rf /var/lib/apt/lists/*

COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/.
COPY tools/init.sql /etc/mysql/init.sql
COPY tools/script.sh /script.sh

RUN chmod +x /script.sh

RUN mkdir -p /run/mysqld
RUN chown -R mysql:mysql /run/mysqld

EXPOSE 3306

CMD ["/script.sh"]
