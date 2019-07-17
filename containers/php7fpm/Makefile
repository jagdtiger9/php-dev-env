#container=fpm
up:
	docker-compose up -d

build-nc:
	docker-compose stop
	docker-compose rm -f
	docker-compose build --no-cache

build:
	docker-compose stop
	docker-compose rm -f
	docker-compose build

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
