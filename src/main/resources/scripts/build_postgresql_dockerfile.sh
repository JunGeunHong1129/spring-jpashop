#!/bin/bash

echo "Start to build postgresql image"

cd ./postgresql-dockfile && docker build -t "gjhong1129/examples:jpashop_db_v0.0.$1" . && echo "build done"

