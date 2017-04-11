FROM jagdtiger/php-dev-env:php7.0
MAINTAINER gimatov@gmail.com

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

# Config files
RUN cp /etc/php/7.0/php.ini /etc/php/7.0/apache2/php.ini

COPY ./.conf/apache/000-default.conf /etc/apache2/sites-enabled/000-default.conf
COPY ./.conf/apache/ports.conf /etc/apache2/ports.conf

RUN mkdir /etc/service/apache2
ADD ./php7-apache/start.sh /etc/service/apache2/run

# Expose ports
EXPOSE 80 443 8080
