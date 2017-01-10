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

#RUN apt-get -y install git re2c libpcre3-dev \
#    && echo $(pwd) \
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

RUN apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
#RUN apt-get update && apt-get upgrade -y -o Dpkg::Options::="--force-confold"

# http://serverfault.com/questions/658367/how-to-get-php-fpm-to-log-to-stdout-stderr-when-running-in-a-docker-container
RUN ln -sf /dev/stderr /var/log/php7.1-fpm.log \
    && ln -sf /dev/stout /var/log/fpm-access.log

# Config files.
COPY conf/xdebug.ini /etc/php/7.1/mods-available/xdebug.ini
COPY conf/opcache.ini /etc/php/7.1/mods-available/opcache.ini
COPY conf/apcu.ini /etc/php/7.1/mods-available/apcu.ini
COPY conf/memcached.ini /etc/php/7.1/mods-available/memcached.ini
COPY conf/php.ini /etc/php/7.1/fpm/php.ini
COPY conf/php-fpm.conf /etc/php/7.1/fpm/php-fpm.conf
COPY conf/php-cli.ini /etc/php/7.1/cli/php.ini
COPY conf/www.conf /etc/php/7.1/fpm/pool.d/www.conf

RUN mkdir /etc/service/php-fpm7.1
ADD start.sh /etc/service/php-fpm7.1/run

EXPOSE 9000

VOLUME ["/var/www"]
