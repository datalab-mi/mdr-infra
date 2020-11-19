#!/bin/bash

git clone https://github.com/datalab-mi/moteur-de-recherche.git
cd moteur-de-recherche && docker-compose up -d && cd -

echo "**************"
echo "Start Services"
echo "**************"
