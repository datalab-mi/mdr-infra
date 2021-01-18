#!/bin/bash
echo "RUN"
/bin/bash get_token.sh
set -e
# Set token
export OS_AUTH_TOKEN=$(/bin/bash get_token.sh)
echo "$OS_AUTH_TOKEN"

if [ -z "$OS_AUTH_TOKEN" ]; then exit; fi
# populate parameters.yaml
SED_REPLACE=`env | sed -e 's#\([^=]*\)=\(.*\)\s*$#s\#"$\1"\#\2\#g;#'| tr '\n' ' ' | sed 's/$/\n/'`
sed "${SED_REPLACE}"  < parameters.template.yaml > parameters.yaml
