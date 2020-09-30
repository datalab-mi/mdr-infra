#!/bin/bash

curl -k -s \
	--request POST  $OS_AUTH_URL/auth/tokens?nocatalog \
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
	        },
	        "scope": {
	            "project": {
	                "id": "'$OS_PROJECT_ID'"
	            }
	        }
	    }
	}'  | awk -F': ' '($1=="X-Subject-Token") {printf $2}'; echo
