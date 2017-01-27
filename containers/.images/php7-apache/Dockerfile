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
    && apt-get install -y software-properties-common python-software-properties

RUN apt-get install -y language-pack-en-base \
    && LC_ALL=C.UTF-8 add-apt-repository -y ppa:ondrej/php \
    && apt-get -y update
RUN apt-get install -y apache2 php7.1 php-pear libapache2-mod-php php7.1-dev php7.1-cli php7.1-mcrypt php7.1-curl php7.1-gd php7.1-gmp php7.1-zip \
    && apt-get install -y php7.1-apcu php7.1-mysqlnd php7.1-sqlite3 php7.1-memcached php7.1-memcache php7.1-xdebug php7.1-mbstring \
    && apt-get install -y imagemagick sqlite3 unzip \
    && apt-get install -y php7.1-imagick php7.1-imap php7.1-bcmath \
    && phpenmod -v 7.1 mcrypt \
    && a2enmod rewrite
# phpdismod

#RUN apt-get install -y apache2 php php-pear libapache2-mod-php php-dev php-cli php-mcrypt php-curl php-gd php-gmp php-zip \
#    && apt-get install -y php-apcu php-mysqlnd php-sqlite3 php-memcached php-memcache php-xdebug php-mbstring \
#    && apt-get install -y imagemagick sqlite3 unzip \
#    && apt-get install -y php-imagick php-imap php-bcmath \
#    && phpenmod -v 7.1 mcrypt \
#    && a2enmod rewrite

### Приводит к segmentation fault при запуске /usr/bin/php в apache-php7 контейнере
#RUN apt-get -y install git re2c libpcre3-dev \
#    && git clone https://github.com/phalcon/zephir \
#    && cd zephir \
#    && ./install-nosudo \
#    && cd ../ \
#    && git clone https://github.com/crocodile2u/zhandlersocket.git \
#    && cd zhandlersocket \
#    && /zephir/bin/zephir build --backend=ZendEngine3 \
#    && cat > /etc/php/7.1/mods-available/zhandlersocket.ini \
#    && echo 'extension=zhandlersocket.so' > /etc/php/7.1/mods-available/zhandlersocket.ini \
#    && phpenmod -v 7.1 zhandlersocket

# Redis
RUN curl -L -o phpredis.zip https://github.com/phpredis/phpredis/archive/php7.zip \
    && unzip -q phpredis.zip \
    && rm phpredis.zip \
    && cd phpredis-* \
    && phpize \
    && ./configure \
    && make && make install \
    && cd ../ \
    && rm -r phpredis-* \
    && cat > /etc/php/7.1/mods-available/redis.ini \
    && echo 'extension=redis.so' > /etc/php/7.1/mods-available/redis.ini \
    && phpenmod -v 7.1 redis

# Grunt
RUN apt-get install -y nodejs npm \
    && ln -s /usr/bin/nodejs /usr/bin/node \
    && cd /var \
    && npm install -g grunt-cli \
    && npm init -y \
    && npm install grunt --save-dev \
    && npm install grunt-contrib-uglify --save-dev \
    && npm install grunt-contrib-concat --save-dev \
    && npm install grunt-contrib-compress --save-dev \
    && cd /

RUN apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
#RUN apt-get update && apt-get upgrade -y -o Dpkg::Options::="--force-confold"

# Config files.
COPY conf/apache/000-default.conf /etc/apache2/sites-enabled/000-default.conf
COPY conf/apache/ports.conf /etc/apache2/ports.conf

COPY conf/php7/xdebug.ini /etc/php/7.1/mods-available/xdebug.ini
COPY conf/php7/opcache.ini /etc/php/7.1/mods-available/opcache.ini
COPY conf/php7/apcu.ini /etc/php/7.1/mods-available/apcu.ini
COPY conf/php7/memcached.ini /etc/php/7.1/mods-available/memcached.ini
COPY conf/php7/php.ini /etc/php/7.1/apache2/php.ini
COPY conf/php7/php-cli.ini /etc/php/7.1/cli/php.ini

RUN mkdir /etc/service/apache2
ADD start.sh /etc/service/apache2/run

# Expose ports
EXPOSE 80 443 8080

VOLUME ["/var/log/apache2","/etc/php5/apache2/"]
