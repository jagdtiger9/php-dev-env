#!/bin/bash

# Delete all containers
docker rm $(docker ps -a -q)
# Delete all images
docker rmi $(docker images -q)


# Remove images + containers
# http://blog.yohanliyanage.com/2015/05/docker-clean-up-after-yourself/
docker rm `docker ps -aq --no-trunc --filter "status=exited"`
docker rmi `docker images --filter 'dangling=true' -q --no-trunc`


# Get the latest image for container
docker-compose stop
docker-compose rm -f
docker-compose -f docker-compose.yml up -d
# I.e. remove the containers before running up again.

# What one needs to keep in mind when doing it like this is that data volume containers are removed 
# as well if you just run rm -f. In order to prevent that I specify explicitly each container to remove:
docker-compose rm -f application nginx php
# As I said in my question, I don't know if this is the correct process. 
# But this seems to work for our use case, so until we find a better solution we'll roll with this one.