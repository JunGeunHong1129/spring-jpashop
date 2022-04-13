FROM --platform=arm64 postgres:latest

#COPY ./init_dump/init.sql /docker-entrypoint-initdb.d/
COPY ./conf/postgresql.conf /etc/postgresql/postgresql.conf
COPY ./conf/pg_hba.conf /etc/postgresql/pg_hba.conf
