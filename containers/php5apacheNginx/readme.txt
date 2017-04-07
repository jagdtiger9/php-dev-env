# Конфигурация с реализацией масштабирования apache-php серверов.
# Аналог production окружения: Proxy(nginx) + worker-backends(apache2-php) + mysql, memcache сервисы

docker-compose up -d

# Указываем какое кол-во backend серверов (apache-php) нужно склонировать. Минимальное значение - 3!
docker-composer scale backend=5
