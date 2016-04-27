FROM jedisct1/phusion-baseimage-latest:16.04
MAINTAINER gimatov@gmail.com

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

# https://docs.docker.com/engine/faq/
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get -y update \
    && apt-get install -y php php-pear php-fpm php-dev php-cli php-mcrypt php-curl php-gd php-gmp php-zip \
    && apt-get install -y php-apcu php-mysqlnd php-sqlite3 php-memcached php-memcache php-xdebug php-mbstring \
    && apt-get install -y imagemagick sqlite3 unzip \
    && phpenmod mcrypt \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

#    && curl -L -o temp.zip https://github.com/kjdev/php-ext-handlersocketi/archive/master.zip \
#    && unzip -q temp.zip \
#    && rm temp.zip \
#    && cd php-ext-handlersocketi-master \
#    && phpize \
#    && ./configure \
#    && make && make install \
#    && cd ../ && rm -r php-ext-handlersocketi-master \
#    && cat > /etc/php/7.0/mods-available/handlersocketi.ini \
#    && echo 'extension=handlersocketi.so' > /etc/php/7.0/mods-available/handlersocketi.ini \
#    && phpenmod handlersocketi \
#    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# http://serverfault.com/questions/658367/how-to-get-php-fpm-to-log-to-stdout-stderr-when-running-in-a-docker-container
RUN ln -sf /dev/stderr /var/log/php7.0-fpm.log \
    && ln -sf /dev/stderr /var/log/fpm-access.log

# Config files.
COPY conf/xdebug.ini /etc/php/7.0/fpm/conf.d/20-xdebug.ini
COPY conf/php.ini /etc/php/7.0/fpm/php.ini
COPY conf/php-fpm.conf /etc/php/7.0/fpm/php-fpm.conf
COPY conf/php-cli.ini /etc/php/7.0/cli/php.ini
COPY conf/www.conf /etc/php/7.0/fpm/pool.d/www.conf

RUN mkdir /etc/service/php-fpm7.0
ADD start.sh /etc/service/php-fpm7.0/run

EXPOSE 9000

VOLUME ["/var/www"]
