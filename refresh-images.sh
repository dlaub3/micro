#!/bin/bash
# 
# update docker images to the latest versions
# 

# check permissions
if [[ "${UID}" -ne 0 ]]
then 
	echo "Please run with sudo or as root." 1>&2
	exit 1
fi

# add path for docker-compose
PATH=/usr/local/bin:$PATH

# cd to directory of docker-compose file - in this case it's the same directory as the script
cd $(dirname ${0})

# clear file and add date/time
timestamp=$(date +%F' '%H:%M)
echo "refreshing images: ${timestamp}" > refresh-images.log
echo
echo

# update docker
docker-compose down
docker-compose build --pull
docker-compose up -d

