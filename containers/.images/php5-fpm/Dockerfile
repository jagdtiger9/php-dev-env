FROM jedisct1/phusion-baseimage-latest:15.10
MAINTAINER gimatov@gmail.com

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

# https://docs.docker.com/engine/faq/
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get -y update \
    && apt-get install -y php5 php-pear php5-fpm php5-dev php5-cli php5-mcrypt php5-curl php5-gd php5-gmp php-apc \
php5-apcu php5-mysqlnd php5-sqlite php5-memcached php5-memcache php5-xdebug \
    && apt-get install -y imagemagick sqlite3 unzip \
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
    && php5enmod handlersocketi \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# http://serverfault.com/questions/658367/how-to-get-php-fpm-to-log-to-stdout-stderr-when-running-in-a-docker-container
RUN ln -sf /dev/stderr /var/log/fpm-error.log \
    && ln -sf /dev/stderr /var/log/fpm-access.log

# Config files.
COPY conf/xdebug.ini /etc/php5/fpm/conf.d/20-xdebug.ini
COPY conf/php.ini /etc/php5/fpm/php.ini
COPY conf/php-fpm.conf /etc/php5/fpm/php-fpm.conf
COPY conf/php-cli.ini /etc/php5/cli/php.ini
COPY conf/www.conf /etc/php5/fpm/pool.d/www.conf

RUN mkdir /etc/service/php5-fpm
ADD start.sh /etc/service/php5-fpm/run

EXPOSE 9000

VOLUME ["/var/www"]
