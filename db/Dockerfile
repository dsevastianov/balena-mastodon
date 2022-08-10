FROM postgres:14-alpine

USER postgres

COPY 1-init-user-db.sql ./docker-entrypoint-initdb.d
