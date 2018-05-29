FROM jagdtiger/php-dev-env:php7.x
MAINTAINER gimatov@gmail.com

ARG allow_xdebug
ARG PHP_VERSION
ENV PHP_VERSION ${PHP_VERSION:-7.2}

COPY ./.conf/fpm/php-fpm.conf /etc/php/${PHP_VERSION}/fpm/php-fpm.conf
COPY ./.conf/fpm/www.conf /etc/php/${PHP_VERSION}/fpm/pool.d/www.conf

RUN mkdir /etc/service/php-fpm
ADD ./php7-fpm/start${PHP_VERSION}.sh /etc/service/php-fpm/run

RUN if [ "$allow_xdebug" = "0" ]; then phpdismod xdebug; fi

EXPOSE 9000
