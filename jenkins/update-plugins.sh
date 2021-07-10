#!/bin/bash

# Get the currently installed list of plugins

echo "Enter login credentials."

read -p "Enter username: "  USERNAME
read -sp "Enter API token: " API_TOKEN
echo 
echo "Logging in..."

JENKINS_USER="${USERNAME}:${API_TOKEN}"
JENKINS_URL="${JENKINS_URL}"

PLUGIN_XML=$(curl -sS --user "${JENKINS_USER}" "$JENKINS_URL/pluginManager/api/xml?depth=1&xpath=/*/*/shortName|/*/*/version&wrapper=plugins")

PLUGIN_TEXT=$(perl -pe "s/.*?<shortName>([\w-]+).*?<version>([^<]+)()(<\/\w+>)+/\1:latest\n/g" <<< ${PLUGIN_XML}) 

cat <<< ${PLUGIN_TEXT} | sort > plugins.txt

