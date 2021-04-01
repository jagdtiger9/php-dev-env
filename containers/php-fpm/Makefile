#container=fpm, db, etc...
up:
	docker-compose up -d

build:
	docker-compose stop
	docker-compose rm -f
	docker-compose build

build.nocache:
	docker-compose stop
	docker-compose rm -f
	docker-compose build --no-cache

pull:
	docker-compose pull

rebuild:
	docker-compose stop
#	docker rmi $(docker images -q)
	docker-compose rm -f
	docker-compose down -v --remove-orphans
	docker-compose pull
	docker-compose build --no-cache

down:
	docker-compose down

ps:
	docker-compose ps

# examples:
#  $ docker-composer build --no-cache db
