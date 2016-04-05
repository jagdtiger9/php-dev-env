#---------- Важные моменты ----------#
// В случае конфликта с локальной сетью 172.17.0.0
DOCKER_OPTS="--bip=192.168.15.1/24 --fixed-cidr=192.168.15.1/24"

!!! Новая версия сервера БД - новый путь к /var/lib/mysql - иначе сервис падает. Не получится запустить mysql.
Если происходит смена версий сервера БД, может возникнуть проблема несовместимости данных служебных таблиц mysql.
Решением является:
 - монтирование данных БД в другую директорию, например /var/lib/mysql-docker,
 - запуска контейнера для инициализации системных файлов БД,
 - копирование данных БД проекта в новую директорию.




#---------- Основные операции ----------#
// Запуск остановка программной системы на базе docker-compose.yml конфига
$ docker-compose up -d
$ docker-compose down
// Запуск контейнера определенного сервиса
$ docker-compose up --no-deps -d apache2-php5


// Доступ в запущенный контейнер
$ docker ps
$ docker exec -id [comtainer_id] /bin/bash (или /bin/sh)


// Логи докер контейнера
docker logs CONTAINER_ID


// Удаление контейнера
docker rm -f CONTAINER_ID


// Перестроение образов
$ docker-compose build
// Перестроение образа заданного сервиса
$ docker-compose build apache2-php5
или (в директории образа)
$ docker build -t apache2-php5 .


// Удаление образов
$ docker images
$ docker rmi -f IMAGE_ID


// Docker networks
//https://docs.docker.com/engine/userguide/networking/dockernetworks/
$ docker network ls
// ERROR: Network "magicproapache_net" needs to be recreated - options have changed
$docker network rm NET_ID


