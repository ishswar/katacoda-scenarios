#!/usr/bin/env sh

docker system prune --force
docker rmi mysql:9
docker rmi mysql:8
docker rmi mysql:latest
docker rmi mariadb:latest
docker rmi $(docker images -q)