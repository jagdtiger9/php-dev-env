FROM jedisct1/phusion-baseimage-latest:15.10
MAINTAINER gimatov@gmail.com

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

# https://docs.docker.com/engine/faq/
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get -y update \
    && apt-get install -y php5 php-pear php5-fpm php5-dev php5-cli php5-mcrypt php5-curl php5-gd php5-gmp php-apc \
    && apt-get install -y php5-apcu php5-mysqlnd php5-sqlite php5-memcached php5-memcache php5-xdebug \
    && apt-get install -y imagemagick sqlite3 unzip \
    && apt-get install -y php5-imagick php5-imap \
    && php5enmod mcrypt \
    && apt-get clean \
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

# Redis
RUN curl -L -o phpredis.zip https://github.com/phpredis/phpredis/archive/master.zip \
    && unzip -q phpredis.zip \
    && rm phpredis.zip \
    && cd phpredis-* \
    && phpize \
    && ./configure \
    && make && make install \
    && cd ../ \
    && rm -r phpredis-* \
    && cat > /etc/php5/mods-available/redis.ini \
    && echo 'extension=redis.so' > /etc/php5/mods-available/redis.ini \
    && php5enmod redis

# Grunt
RUN curl -sL https://deb.nodesource.com/setup_4.x | bash -
RUN add-apt-repository ppa:fkrull/deadsnakes
RUN apt-get update -y
RUN apt-get install -y python2.7

RUN apt-get install -y nodejs \
    && cd /var \
    && npm install --global node-gyp \
    && npm install -g grunt-cli \
    && npm install -g coffee-script

RUN npm init -y
# node-gyp needs python v2.7
#RUN npm install --python=python3.4 && npm config set python python3.4
RUN npm install --python=python2.7 && npm config set python python2.7
RUN npm install grunt --save-dev \
    && npm install grunt-contrib-uglify --save-dev \
    && npm install grunt-contrib-concat --save-dev \
    && npm install grunt-contrib-compress --save-dev \
    && cd /

RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# http://serverfault.com/questions/658367/how-to-get-php-fpm-to-log-to-stdout-stderr-when-running-in-a-docker-container
#RUN ln -sf /dev/stderr /var/log/fpm-error.log \
#    && ln -sf /dev/stderr /var/log/fpm-access.log

# Config files.
COPY ./.conf/php5/xdebug.ini /etc/php5/fpm/conf.d/20-xdebug.ini
COPY ./.conf/php5/apcu.ini /etc/php5/mods-available/apcu.ini
COPY ./.conf/php5/memcached.ini /etc/php5/mods-available/memcached.ini
COPY ./.conf/php5/php.ini /etc/php5/fpm/php.ini
COPY ./.conf/php5/php-cli.ini /etc/php5/cli/php.ini

COPY ./.conf/fpm/php-fpm.conf /etc/php5/fpm/php-fpm.conf
COPY ./.conf/fpm/www.conf /etc/php5/fpm/pool.d/www.conf

RUN mkdir /etc/service/php5-fpm
ADD ./php5-fpm/start.sh /etc/service/php5-fpm/run

EXPOSE 9000

VOLUME ["/var/www"]
