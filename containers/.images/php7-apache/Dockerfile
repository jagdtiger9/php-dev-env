FROM jedisct1/phusion-baseimage-latest:16.10
MAINTAINER gimatov@gmail.com

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

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
    && apt-get install -y apache2 php php-pear libapache2-mod-php php-dev php-cli php-mcrypt php-curl php-gd php-gmp php-zip \
    && apt-get install -y php-apcu php-mysqlnd php-sqlite3 php-memcached php-memcache php-xdebug php-mbstring \
    && apt-get install -y imagemagick sqlite3 unzip \
    && apt-get install -y php-imagick php-imap \
    && phpenmod -v 7.0 mcrypt \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

#RUN curl -L -o apc.tgz http://pecl.php.net/get/apcu_bc \
#    && mkdir apc && tar -zxf apc.tgz -C apc --strip-components=1 \
#    && rm apc.tgz \
#    && cd apc \
#    && phpize \
#    && ./configure \
#    && make && make install

#RUN curl -L -o temp.zip https://github.com/kjdev/php-ext-handlersocketi/archive/master.zip \
#    && unzip -q temp.zip \
#    && rm temp.zip \
#    && cd php-ext-handlersocketi-master \
#    && phpize \
#    && ./configure \
#    && make && make install \
#    && cd ../ && rm -r php-ext-handlersocketi-master \
#    && cat > /etc/php/mods-available/handlersocketi.ini \
#    && echo 'extension=handlersocketi.so' > /etc/php/7.0/mods-available/handlersocketi.ini \
#    && php5enmod handlersocketi \
#    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN apt-get update && apt-get upgrade -y -o Dpkg::Options::="--force-confold"

RUN a2enmod rewrite
# phpdismod

# Config files.
COPY conf/apache/000-default.conf /etc/apache2/sites-enabled/000-default.conf
COPY conf/apache/ports.conf /etc/apache2/ports.conf

COPY conf/php7/xdebug.ini /etc/php/7.0/mods-available/xdebug.ini
COPY conf/php7/opcache.ini /etc/php/7.0/mods-available/opcache.ini
COPY conf/php7/apcu.ini /etc/php/7.0/mods-available/apcu.ini
COPY conf/php7/php.ini /etc/php/7.0/apache2/php.ini
COPY conf/php7/php-cli.ini /etc/php/7.0/cli/php.ini

RUN mkdir /etc/service/apache2
ADD start.sh /etc/service/apache2/run

# Expose ports
EXPOSE 80 443 8080

VOLUME ["/var/log/apache2","/etc/php5/apache2/"]
