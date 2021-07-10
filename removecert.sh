#!/usr/bin/env bash

set -e 

ACME_FILE=./acme.json # change

jq -r ".Certificates | .[] | select(.Domain.Main == \"$1\").Key" < $ACME_FILE | base64 --decode > /tmp/a.key
jq -r ".Certificates | .[] | select(.Domain.Main == \"$1\").Certificate" < $ACME_FILE | base64 --decode > /tmp/a.pem
letsencrypt revoke -d "$1" --key-path /tmp/a.key --cert-path /tmp/a.pem
