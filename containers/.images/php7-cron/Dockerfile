FROM jedisct1/phusion-baseimage-latest:16.04
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
    && apt-get install -y php php-pear php-dev php-cli php-mcrypt php-curl php-gd php-gmp php-zip \
    && apt-get install -y php-apcu php-mysqlnd php-sqlite3 php-memcached php-memcache php-xdebug php-mbstring \
    && apt-get install -y imagemagick sqlite3 unzip \
    && phpenmod mcrypt \
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
#    && cat > /etc/php5/mods-available/handlersocketi.ini \
#    && echo 'extension=handlersocketi.so' > /etc/php5/mods-available/handlersocketi.ini \
#    && phpenmod handlersocketi \
#    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN apt-get update && apt-get upgrade -y -o Dpkg::Options::="--force-confold"

RUN phpenmod -v 7.0 mcrypt
# phpdismod

# Config files.
COPY conf/apcu.ini /etc/php/7.0/mods-available/apcu.ini
COPY conf/php-cli.ini /etc/php/7.0/cli/php.ini

# Define host WWW-files owner user UID&GID
# http://stackoverflow.com/questions/23544282/what-is-the-best-way-to-manage-permissions-for-docker-shared-volumes
# https://github.com/phusion/baseimage-docker#running_startup_scripts
RUN mkdir -p /etc/my_init.d
ADD conf/init_user.sh /etc/my_init.d/init_user.sh

# Add cron tasks
COPY conf/cron.d/magicpro /etc/cron.d/magicpro
RUN chmod 0755 /etc/cron.d/magicpro
