FROM ubuntu:15.04
MAINTAINER gimatov@gmail.com

# DNS update: to run apt-get and to let the docker build process access the internet. 
#RUN "sh" "-c" "echo nameserver 8.8.8.8 >> /etc/resolv.conf"

# https://docs.docker.com/engine/faq/
ENV DEBIAN_FRONTEND=noninteractive

ENV APACHE_RUN_USER  www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_PID_FILE  /var/run/apache2.pid
ENV APACHE_RUN_DIR   /var/run/apache2
ENV APACHE_LOCK_DIR  /var/lock/apache2
ENV APACHE_LOG_DIR   /var/log/apache2

RUN apt-get -y update \
    && apt-get install -y apache2 php5 libapache2-mod-php5 php5-dev php5-cli php5-mcrypt php5-curl php5-gd php5-gmp php-apc \
php5-apcu php5-mysqlnd php5-sqlite php5-memcached php5-memcache php5-xdebug \
    && apt-get install -y imagemagick sqlite3 unzip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && curl -L -o temp.zip https://github.com/kjdev/php-ext-handlersocketi/archive/master.zip \
    && unzip -q temp.zip \
    && rm temp.zip \
    && cd php-ext-handlersocketi-master \
    && phpize \
    && ./configure \
    && make && make install \
    && cd ../ && rm -r php-ext-handlersocketi-master \
    && cat > /etc/php5/mods-available/handlersocketi.ini \
    && echo 'extension=handlersocketi.so' > /etc/php5/mods-available/handlersocketi.ini \
    && php5enmod handlersocketi

#    && curl -sS https://getcomposer.org/installer | php \
#    && mv composer.phar /usr/local/bin/composer \

RUN a2enmod cgi \
    && a2enmod suexec \
    && a2enmod rewrite \
    && php5enmod mcrypt

# Config files.
COPY conf/apache/000-default.conf /etc/apache2/sites-enabled/000-default.conf
COPY conf/php5/xdebug.ini /etc/php5/apache2/mods-available/xdebug.ini
COPY conf/php5/php.ini /etc/php5/apache2/php.ini

# Expose ports
EXPOSE 80 443

VOLUME ["/var/log/apache2","/etc/php5/apache2/"]

# Define default command
CMD ["apachectl", "-D", "FOREGROUND"]
