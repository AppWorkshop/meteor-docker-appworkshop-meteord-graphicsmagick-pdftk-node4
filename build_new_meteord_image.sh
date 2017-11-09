#!/usr/bin/env bash
dockerhubuser=appworkshop
dockerimagename=meteord-graphicsmagick-pdftk-node8

command -v jq >/dev/null 2>&1 || { echo "I require jq but it's not installed.  Aborting." >&2; exit 1; }

echo building docker image
docker build -t ${dockerimagename} .
retval=$?
if [ $retval -ne 0 ]; then
   echo couldn\'t build docker image
   exit $retval
fi

echo logging in to docker hub
docker login
retval=$?
if [ $retval -ne 0 ]; then
   echo couldn\'t login to docker hub
   exit $retval
fi

echo tagging image as latest
docker tag ${dockerimagename} ${dockerhubuser}/${dockerimagename}:latest
retval=$?
if [ $retval -ne 0 ]; then
   echo couldn\'t tag docker image
   exit $retval
fi

echo Existing tags for this image :
curl -L -s "https://registry.hub.docker.com/v2/repositories/${dockerhubuser}/${dockerimagename}/tags?page_size=1024"|jq '."results"[]["name"]'

echo create at least one new version tag for this image :
read versiontag

docker tag ${dockerimagename} "${dockerhubuser}/${dockerimagename}:${versiontag}"
docker push ${dockerhubuser}/${dockerimagename}
