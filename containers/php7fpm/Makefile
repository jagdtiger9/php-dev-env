container=fpm

up:
	docker-compose up -d

build:
	docker-compose stop
	docker rmi $(docker images -q)
	docker-compose rm -f
	docker-compose down -v --remove-orphans
	docker-compose pull
	docker-compose build
	docker-compose up -d

down:
	docker-compose down
