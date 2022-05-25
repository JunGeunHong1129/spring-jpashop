#!/bin/bash

echo "Chat-Server Start to Initialize"

mkdir -p -m 777  ./volume/postgresql_prod/run/ && mkdir -p -m 777  ./volume/postgresql_prod/data/ && mkdir -p -m 777  ./volume/postgresql_dev/run/ && mkdir -p -m 777  ./volume/postgresql_dev/data/

echo "Chat-Server Volume Set Complete"

docker-compose config

docker-compose down --remove-orphans

docker-compose up

echo "Chat-Server Initialize Complete!"

exit 0