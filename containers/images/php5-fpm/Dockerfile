FROM ubuntu:15.04
MAINTAINER gimatov@gmail.com

# https://docs.docker.com/engine/faq/
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get -y update \
    && apt-get install -y php5 php-pear php5-fpm php5-dev php5-cli php5-mcrypt php5-curl php5-gd php5-gmp php-apc \
php5-apcu php5-mysqlnd php5-sqlite php5-memcached php5-memcache php5-xdebug \
    && apt-get install -y imagemagick sqlite3 unzip \
    && php5enmod mcrypt \
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
    && php5enmod handlersocketi \
    && ln -sf /dev/stdout /var/log/php5-fpm.log

#    && curl -sS https://getcomposer.org/installer | php \
#    && mv composer.phar /usr/local/bin/composer \
#    && sudo ln -s /etc/php5/mods-available/handlersocketi.ini /etc/php5/apache2/conf.d/20-handlersocketi.ini
#    chown -R www-data:www-data /srv/www && \

# Config files.
COPY conf/xdebug.ini /etc/php5/fpm/conf.d/20-xdebug.ini
COPY conf/php.ini /etc/php5/fpm/php.ini
COPY conf/www.conf /etc/php5/fpm/pool.d/www.conf

EXPOSE 9000

VOLUME ["/var/www"]

CMD ["php5-fpm", "--nodaemonize"]
