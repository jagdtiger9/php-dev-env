#!/bin/bash

# Remove images + containers

docker rm `docker ps -aq --no-trunc --filter "status=exited"`
docker rmi `docker images --filter 'dangling=true' -q --no-trunc`
