FROM php7fpm_php_base
MAINTAINER gimatov@gmail.com

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

# https://docs.docker.com/engine/faq/
ENV DEBIAN_FRONTEND=noninteractive

COPY ./.conf/fpm/php-fpm.conf /etc/php/7.0/fpm/php-fpm.conf
COPY ./.conf/fpm/www.conf /etc/php/7.0/fpm/pool.d/www.conf

RUN mkdir /etc/service/php-fpm
ADD ./php7-fpm/start.sh /etc/service/php-fpm/run

EXPOSE 9000

VOLUME ["/var/www"]
