#!/bin/bash

# create docker network
docker network create dev
# install locally postgres
git clone https://github.com/datalab-mi/docker-postgres.git
cd docker-postgres && docker-compose up -d && cd -
docker network connect  postgres dev
# install locally DSS
git clone https://github.com/datalab-mi/docker-dss.git
cd docker-dss && docker-compose up -d && cd -
docker network connect  dss dev

echo "**************"
echo "Start Services"
echo "**************"
