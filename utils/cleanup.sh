#!/bin/bash

# Remove images + containers
# http://blog.yohanliyanage.com/2015/05/docker-clean-up-after-yourself/
docker rm `docker ps -aq --no-trunc --filter "status=exited"`
docker rmi `docker images --filter 'dangling=true' -q --no-trunc`


# Delete all containers
docker rm $(docker ps -a -q)
# Delete all images
docker rmi $(docker images -q)