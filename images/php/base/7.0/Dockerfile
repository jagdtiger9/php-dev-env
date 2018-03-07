FROM jedisct1/phusion-baseimage-latest:16.04
MAINTAINER gimatov@gmail.com

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

# DNS update: to run apt-get and to let the docker build process access the internet.
#RUN "sh" "-c" "echo nameserver 8.8.8.8 >> /etc/resolv.conf"

# https://docs.docker.com/engine/faq/
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get -y update \
    && apt-get install -y software-properties-common python-software-properties

RUN apt-get install -y language-pack-en-base
#RUN LC_ALL=C.UTF-8 add-apt-repository -y ppa:ondrej/php \
RUN apt-get -y update

#RUN apt-get install -y php7.1 php-pear php7.1-dev php7.1-cli php7.1-mcrypt php7.1-curl php7.1-gd php7.1-gmp php7.1-zip \
#    && apt-get install -y php7.1-apcu php7.1-mysqlnd php7.1-sqlite3 php7.1-memcached php7.1-memcache php7.1-xdebug php7.1-mbstring \
#    && apt-get install -y imagemagick sqlite3 unzip \
#    && apt-get install -y php7.1-imagick php7.1-imap php7.1-bcmath \
#    && phpenmod -v 7.1 mcrypt \
#    && a2enmod rewrite
# phpdismod

# php-fpm have to be installed at the base image
# child image installation gets "memcached module required" error
RUN apt-get install -y php php-pear php-dev php-cli php-fpm php-mcrypt php-curl php-gd php-gmp php-zip \
    && apt-get install -y php-apcu php-mysqlnd php-sqlite3 php-memcached php-memcache php-xdebug php-mbstring \
    && apt-get install -y imagemagick sqlite3 unzip \
    && apt-get install -y php-imagick php-imap php-bcmath \
    && phpenmod mcrypt

# Redis
RUN curl -L -o phpredis.zip https://github.com/phpredis/phpredis/archive/develop.zip \
    && unzip -q phpredis.zip \
    && rm phpredis.zip \
    && cd phpredis-* \
    && phpize \
    && ./configure \
    && make && make install \
    && cd ../ \
    && rm -r phpredis-* \
    && cat > /etc/php/7.0/mods-available/redis.ini \
    && echo 'extension=redis.so' > /etc/php/7.0/mods-available/redis.ini \
    && phpenmod redis

# Node
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash - \
    && apt-get install -y nodejs
#    && apt-get install -y npm

# Pinba
RUN git clone https://github.com/tony2001/pinba_extension.git \
    && cd pinba_extension \
    && phpize \
    && ./configure --enable-pinba \
    && make && make install \
    && cd ../ \
    && rm -r pinba_extension \
    && cat > /etc/php/7.0/mods-available/pinba.ini \
    && echo "extension=pinba.so\npinba.enabled=1\npinba.server=pinba:30002" > /etc/php/7.0/mods-available/pinba.ini \
    && phpenmod pinba

# Rotator
RUN git clone https://bitbucket.org/magicpro/rotator \
    && cd rotator/rotator_7.0 \
    && phpize \
    && ./configure \
    && make && make install \
    && cd ../../ \
    && rm -r rotator \
    && cat > /etc/php/7.0/mods-available/rotator.ini \
    && echo "extension=rotator.so" > /etc/php/7.0/mods-available/rotator.ini \
    && phpenmod rotator

RUN apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
#RUN apt-get update && apt-get upgrade -y -o Dpkg::Options::="--force-confold"

# Config files
COPY conf/xdebug.ini /etc/php/7.0/mods-available/xdebug.ini
COPY conf/opcache.ini /etc/php/7.0/mods-available/opcache.ini
COPY conf/apcu.ini /etc/php/7.0/mods-available/apcu.ini
COPY conf/memcached.ini /etc/php/7.0/mods-available/memcached.ini
COPY conf/php-cli.ini /etc/php/7.0/cli/php.ini
COPY conf/php.ini /etc/php/7.0/fpm/php.ini
COPY conf/php.ini /etc/php/7.0/php.ini
