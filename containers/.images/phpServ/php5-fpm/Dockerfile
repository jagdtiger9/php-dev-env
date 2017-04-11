FROM jagdtiger/php5-base:5.6
MAINTAINER gimatov@gmail.com

COPY ./.conf/fpm/php-fpm.conf /etc/php5/fpm/php-fpm.conf
COPY ./.conf/fpm/www.conf /etc/php5/fpm/pool.d/www.conf

RUN mkdir /etc/service/php5-fpm
ADD ./php5-fpm/start.sh /etc/service/php5-fpm/run

EXPOSE 9000
