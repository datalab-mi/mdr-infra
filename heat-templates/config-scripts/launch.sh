#!/bin/bash

git_tag="$git_tag"
git clone -b ${git_tag} https://github.com/datalab-mi/moteur-de-recherche.git
cd moteur-de-recherche
echo """export INDEX_NAME = iga
export DATA_PATH = /data
export ENV_FILE = ${APP_PATH}/backend/tests/${INDEX_NAME}/.env-${INDEX_NAME}
export FRONTEND_STATIC_USER=${APP_PATH}/backend/tests/${INDEX_NAME}/static
export DC_UP_ARGS=
export APP_VERSION=$git_tag
""" > artifacts

make frontend-download-swift nginx-build start -d && cd -

echo "**************"
echo "Start Services"
echo "**************"
