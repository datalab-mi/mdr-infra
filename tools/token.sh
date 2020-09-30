#!/bin/bash
#
# upload feedback to swift
#   get creds and get token
#   get feedback and upload to swift
set -e
trap clean EXIT QUIT KILL
clean(){
  [ -f header -o -f out ] && rm -rf header out
}

curl_opt="--retry 10 --retry-delay 5 --retry-max-time 60 --connect-timeout 10"

#[ -f $HOME/.openrc.sh ] && source $HOME/.openrc.sh

[ -z "$OS_STORAGE_URL" -o -z "$OS_AUTH_URL" -o -z "$OS_USERNAME" -o -z "$OS_PROJECT_DOMAIN_NAME" -o -z "$OS_PASSWORD" ] && { echo "variable OS_* introuvable" ; exit 1 ; }

 scope_json='{ "auth": { "identity": { "methods": ["password"], "password": { "user": { "name": "'$OS_USERNAME'", "domain": { "name": "'$OS_PROJECT_DOMAIN_NAME'" }, "password": "'$OS_PASSWORD'" } } } } }'

curl $curl_opt -s --fail -D header -o out -k -L \
   -H "Content-Type: application/json" \
   -d "$scope_json" \
   $OS_AUTH_URL/auth/tokens ; echo

set +e
if [ -s header ] ; then
  token=$( awk ' /^X-Subject-Token:/ { print $2 } ' header| sed -e 's/\r//g')
  [ -z "$token" ] || export OS_AUTH_TOKEN=$token
fi
set -e

echo "---SWIFT TOKEN : $OS_AUTH_TOKEN---"
