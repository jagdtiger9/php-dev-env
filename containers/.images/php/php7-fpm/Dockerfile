FROM jedisct1/phusion-baseimage-latest:16.10
MAINTAINER gimatov@gmail.com

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

# https://docs.docker.com/engine/faq/
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get -y update \
    && apt-get install -y software-properties-common python-software-properties

RUN apt-get install -y language-pack-en-base \
    && LC_ALL=C.UTF-8 add-apt-repository -y ppa:ondrej/php \
    && apt-get -y update

RUN apt-get install -y php7.1 php-pear php7.1-fpm php7.1-dev php7.1-cli php7.1-mcrypt php7.1-curl php7.1-gd php7.1-gmp php7.1-zip \
    && apt-get install -y php7.1-apcu php7.1-mysqlnd php7.1-sqlite3 php7.1-memcached php7.1-memcache php7.1-xdebug php7.1-mbstring \
    && apt-get install -y imagemagick sqlite3 unzip \
    && apt-get install -y php7.1-imagick php7.1-imap php7.1-bcmath \
    && phpenmod -v 7.1 mcrypt

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
    && npm install -g coffee-script \
    && npm init -y \
    && npm install grunt --save-dev \
    && npm install grunt-contrib-uglify --save-dev \
    && npm install grunt-contrib-concat --save-dev \
    && npm install grunt-contrib-compress --save-dev \
    && cd /

# Pinba
RUN git clone https://github.com/tony2001/pinba_extension.git \
    && cd pinba_extension \
    && phpize \
    && ./configure --enable-pinba \
    && make && make install \
    && cd ../ \
    && rm -r pinba_extension \
    && cat > /etc/php/7.1/mods-available/pinba.ini \
    && echo "extension=pinba.so\npinba.enabled=1\npinba.server=pinba:30002" > /etc/php/7.1/mods-available/pinba.ini \
    && phpenmod -v 7.1 pinba

RUN apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# http://serverfault.com/questions/658367/how-to-get-php-fpm-to-log-to-stdout-stderr-when-running-in-a-docker-container
RUN ln -sf /dev/stderr /var/log/php7.1-fpm.log \
    && ln -sf /dev/stout /var/log/fpm-access.log

# Config files.
COPY ./.conf/php7/xdebug.ini /etc/php/7.1/mods-available/xdebug.ini
COPY ./.conf/php7/opcache.ini /etc/php/7.1/mods-available/opcache.ini
COPY ./.conf/php7/apcu.ini /etc/php/7.1/mods-available/apcu.ini
COPY ./.conf/php7/memcached.ini /etc/php/7.1/mods-available/memcached.ini
COPY ./.conf/php7/php.ini /etc/php/7.1/fpm/php.ini
COPY ./.conf/php7/php-cli.ini /etc/php/7.1/cli/php.ini
COPY ./.conf/fpm/php-fpm.conf /etc/php/7.1/fpm/php-fpm.conf
COPY ./.conf/fpm/www.conf /etc/php/7.1/fpm/pool.d/www.conf

RUN mkdir /etc/service/php-fpm7.1
ADD ./php7-fpm/start.sh /etc/service/php-fpm7.1/run

EXPOSE 9000

VOLUME ["/var/www"]
