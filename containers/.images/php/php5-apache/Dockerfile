FROM jagdtiger/php5-base:5.6
MAINTAINER gimatov@gmail.com

ENV APACHE_RUN_USER  www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_PID_FILE  /var/run/apache2.pid
ENV APACHE_RUN_DIR   /var/run/apache2
ENV APACHE_LOCK_DIR  /var/lock/apache2
ENV APACHE_LOG_DIR   /var/log/apache2

RUN apt-get -y update \
    && apt-get install -y apache2 libapache2-mod-php5 \
    && a2enmod rewrite \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Config files
COPY ./.conf/php5/php.ini /etc/php5/apache2/php.ini

COPY ./.conf/apache/000-default.conf /etc/apache2/sites-enabled/000-default.conf
COPY ./.conf/apache/ports.conf /etc/apache2/ports.conf

RUN mkdir /etc/service/apache2
ADD ./php5-apache/start.sh /etc/service/apache2/run

# Expose ports
EXPOSE 80 443 8080
