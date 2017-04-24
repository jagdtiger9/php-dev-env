FROM jagdtiger/php-dev-env:php7.0
MAINTAINER gimatov@gmail.com

ARG allow_xdebug

COPY ./.conf/fpm/php-fpm.conf /etc/php/7.0/fpm/php-fpm.conf
COPY ./.conf/fpm/www.conf /etc/php/7.0/fpm/pool.d/www.conf

RUN mkdir /etc/service/php-fpm
ADD ./php7-fpm/start.sh /etc/service/php-fpm/run


RUN if [ "$allow_xdebug" = "0" ]; then phpdismod xdebug; fi

EXPOSE 9000
