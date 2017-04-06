FROM php7fpm_php_base
MAINTAINER gimatov@gmail.com

# https://docs.docker.com/engine/faq/
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get -y update \
    && apt-get install -y software-properties-common python-software-properties

RUN apt-get install -y language-pack-en-base \
    && LC_ALL=C.UTF-8 add-apt-repository -y ppa:ondrej/php \
    && apt-get -y update

RUN apt-get install -y php7.1-fpm

RUN apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY ./.conf/fpm/php-fpm.conf /etc/php/7.1/fpm/php-fpm.conf
COPY ./.conf/fpm/www.conf /etc/php/7.1/fpm/pool.d/www.conf

COPY ./.conf/php7/php.ini /etc/php/7.1/fpm/php.ini

RUN mkdir /etc/service/php-fpm7.1
ADD ./php7-fpm/start.sh /etc/service/php-fpm7.1/run

EXPOSE 9000

VOLUME ["/var/www"]
