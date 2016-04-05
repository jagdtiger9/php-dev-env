$ docker-compose up -d
$ docker-compose down

$ docker-compose build apache2-php5
$ docker-compose up --no-deps -d apache2-php5
или
$ docker build -t apache2-php5 .

# Remove images + containers
# http://blog.yohanliyanage.com/2015/05/docker-clean-up-after-yourself/
docker rm `docker ps -aq --no-trunc --filter "status=exited"`
docker rmi `docker images --filter 'dangling=true' -q --no-trunc`


# Enter container
$ docker exec -id [comtainer_id] /bin/bash


# Docker networks
https://docs.docker.com/engine/userguide/networking/dockernetworks/
$ docker network ls

/**
Docker-compose config V.2 добавляет дефолтную сетку,
    https://docs.docker.com/compose/networking/
адресацию которой настроить не получается (в отличие от docker0)
    https://docs.docker.com/engine/userguide/networking/default_network/custom-docker0/
*/

!Не пускаем докер базу в стандартную /var/lib/mysql, могут возникнуть проблемы несовместимости версий
!Не получится запустить mysql
!!! Новая версия БД, новый путь к /var/lib/mysql - иначе сервис падает



# В случае конфликта с локальной сетью 172.17.0.0
# DOCKER_OPTS="--bip=192.168.15.1/24 --fixed-cidr=192.168.15.1/24"


# Удаление всех закешированных контейнеров. Если не парименяются изменения в параметрах сервисов compose конфига
docker-compose rm --all

# Логи докер контейнера
docker logs CONTAINER_ID
# Удаление контейнера
docker rm -f CONTAINER_ID


# ERROR: Network "magicproapache_net" needs to be recreated - options have changed
docker network ls
docker network rm NET_ID