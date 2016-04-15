# Поднятие конфигурации с возможностью масштабирования apache-php серверов.
# Аналог production окружения: Proxy(nginx) + worker-backends(apache2-php) + mysql, memcache сервисы

docker-composer up -d
docker-composer scale backend=5
