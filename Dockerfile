FROM mariadb:latest
RUN ["sed", "-i", "s/exec \"$@\"/echo \"not running $@\"/", "/usr/local/bin/docker-entrypoint.sh"]

ENV MYSQL_ROOT_PASSWORD=root
ENV MYSQL_ROOT_PASSWORD = pwd
ENV MYSQL_DATABASE = test_data
ENV MYSQL_USER = user
ENV MYSQL_PASSWORD = password

COPY sql/data.sql /docker-entrypoint-initdb.d/

RUN ["/usr/local/bin/docker-entrypoint.sh", "mysqld", "--datadir", "/initialized-db", "--aria-log-dir-path", "/initialized-db"]

FROM mariadb:latest

ENV MARIADB_ROOT_PASSWORD=root
ENV MARIADB_ROOT_PASSWORD = pwd
ENV MARIADB_DATABASE = audio_service
ENV MARIADB_USER = user
ENV MARIADB_PASSWORD = password


## Do not work 
##COPY --from=builder /initialized-db /var/lib/mysql

EXPOSE 3306