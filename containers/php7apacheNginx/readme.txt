# Nginx - front-end proxy 
# Apache-php7 - backend

docker-compose up -d

# Scale up backend servers. Min value is 3, see ../.images/nginx/conf/nginx-proxy.conf
docker-compose scale backend=5
