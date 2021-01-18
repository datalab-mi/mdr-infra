#!/bin/bash
[ -z "$OS_STORAGE_URL" -o -z "$OS_AUTH_URL" -o -z "$OS_USERNAME" -o -z "$OS_PROJECT_DOMAIN_NAME" -o -z "$OS_PASSWORD" ] && { echo "variable OS_* introuvable" ; exit 1 ; }

curl_opt="--retry 10 --retry-delay 5 --retry-max-time 60 --connect-timeout 10"

curl $curl_opt -s \
	--request POST $OS_AUTH_URL/auth/tokens?nocatalog \
	--include \
	--header "Content-Type: application/json" \
	--data '{
	    "auth": {
	        "identity": {
	            "methods": [
	                "password"
	            ],
	            "password": {
	                "user": {
	                    "name":  "'$OS_USERNAME'",
											"domain": {
                        "name": "'$OS_USER_DOMAIN_NAME'"
                    	},
	                    "password": "'$OS_PASSWORD'"
	                }
	            }
	        }
	    }
	}'  | awk -F': ' '($1=="X-Subject-Token") {printf $2}'; echo
