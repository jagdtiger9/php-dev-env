FROM jedisct1/phusion-baseimage-latest:15.10
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
    && apt-get install -y apache2 php5 libapache2-mod-php5 php5-dev php5-cli php5-mcrypt php5-curl php5-gd php5-gmp php-apc \
    && apt-get install -y php5-apcu php5-mysqlnd php5-sqlite php5-memcached php5-memcache php5-xdebug \
    && apt-get install -y imagemagick sqlite3 unzip \
    && apt-get install -y php5-imagick php5-imap \
    && apt-get clean \
    && curl -L -o temp.zip https://github.com/kjdev/php-ext-handlersocketi/archive/master.zip \
    && unzip -q temp.zip \
    && rm temp.zip \
    && cd php-ext-handlersocketi-master \
    && phpize \
    && ./configure \
    && make && make install \
    && cd ../ \
    && rm -r php-ext-handlersocketi-master \
    && cat > /etc/php5/mods-available/handlersocketi.ini \
    && echo 'extension=handlersocketi.so' > /etc/php5/mods-available/handlersocketi.ini \
    && php5enmod handlersocketi

RUN apt-get -y install git re2c libpcre3-dev \
    && echo $(pwd) \
    && git clone https://github.com/phalcon/zephir \
    && cd zephir \
    && ./install-nosudo \
    && cd ../ \
    && git clone https://github.com/crocodile2u/zhandlersocket.git \
    && cd zhandlersocket \
    && /zephir/bin/zephir build \
    && cp /zhandlersocket/ext/modules/zhandlersocket.so $(php-config --extension-dir)/ \
    && cat > /etc/php5/mods-available/zhandlersocket.ini \
    && echo 'extension=zhandlersocket.so' > /etc/php5/mods-available/zhandlersocket.ini \
    && php5enmod zhandlersocket

RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN a2enmod rewrite \
    && php5enmod mcrypt

# Config files.
COPY conf/apache/000-default.conf /etc/apache2/sites-enabled/000-default.conf
COPY conf/apache/ports.conf /etc/apache2/ports.conf

COPY conf/php5/xdebug.ini /etc/php5/mods-available/xdebug.ini
COPY conf/php5/apcu.ini /etc/php5/mods-available/apcu.ini
COPY conf/php5/memcached.ini /etc/php5/mods-available/memcached.ini
COPY conf/php5/php.ini /etc/php5/apache2/php.ini
COPY conf/php5/php-cli.ini /etc/php5/cli/php.ini

RUN mkdir /etc/service/apache2
ADD start.sh /etc/service/apache2/run

# Expose ports
EXPOSE 80 443 8080

VOLUME ["/var/log/apache2","/etc/php5/apache2/"]
