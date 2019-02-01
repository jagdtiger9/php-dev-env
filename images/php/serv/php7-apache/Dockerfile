FROM jagdtiger/php-dev-env-git:php7.x
MAINTAINER gimatov@gmail.com

ARG PHP_VERSION
ENV PHP_VERSION ${PHP_VERSION:-7.2}
ARG allow_xdebug

ENV APACHE_RUN_USER  www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_PID_FILE  /var/run/apache2.pid
ENV APACHE_RUN_DIR   /var/run/apache2
ENV APACHE_LOCK_DIR  /var/lock/apache2
ENV APACHE_LOG_DIR   /var/log/apache2

RUN apt-get -y update
RUN apt-get install -y apache2 libapache2-mod-php \
    && a2enmod rewrite

RUN apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Define host WWW-files owner user UID&GID
# http://stackoverflow.com/questions/23544282/what-is-the-best-way-to-manage-permissions-for-docker-shared-volumes
# https://github.com/phusion/baseimage-docker#running_startup_scripts
RUN mkdir -p /etc/my_init.d
ADD ./.conf/init_user.sh /etc/my_init.d/init_user.sh

# Config files
RUN cp /etc/php/${PHP_VERSION}/php.ini /etc/php/${PHP_VERSION}/apache2/php.ini

COPY ./.conf/apache/000-default.conf /etc/apache2/sites-enabled/000-default.conf
COPY ./.conf/apache/ports.conf /etc/apache2/ports.conf

RUN mkdir /etc/service/apache2
ADD ./php7-apache/start.sh /etc/service/apache2/run

RUN if [ "$allow_xdebug" = "0" ]; then phpdismod xdebug; fi

# Expose ports
EXPOSE 80 443 8080
