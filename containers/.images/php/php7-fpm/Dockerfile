#Use with php7fpm/docker-compose.yml (php-base block)
#FROM php7fpm_php-base
FROM jagdtiger/php7-base:7.0
MAINTAINER gimatov@gmail.com

COPY ./.conf/php7/php.ini /etc/php/7.0/fpm/php.ini

COPY ./.conf/fpm/php-fpm.conf /etc/php/7.0/fpm/php-fpm.conf
COPY ./.conf/fpm/www.conf /etc/php/7.0/fpm/pool.d/www.conf

RUN mkdir /etc/service/php-fpm
ADD ./php7-fpm/start.sh /etc/service/php-fpm/run

EXPOSE 9000
