FROM phusion/baseimage
MAINTAINER gimatov@gmail.com

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

RUN apt-get -y update \
    && apt-get install -y software-properties-common python-software-properties \
    && apt-get install -y git php php-common php-cli php-dev php-mcrypt php-gd \
    && apt-get install -y php-mysqlnd php-memcached php-curl php-ctype php-json php-apcu

RUN apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Php local web server request router
COPY router.php /

# Run php local server as sevice
# https://github.com/phusion/baseimage-docker#adding_additional_daemons
RUN mkdir /etc/service/phpd
COPY phps /etc/service/phpd/run
RUN chmod +x /etc/service/phpd/run

# Add cron tasks
COPY cron/pinba /etc/cron.d/pinba
RUN chmod 0755 /etc/cron.d/pinba

# Persist pinboard scripts in outer volume
RUN mkdir /www
VOLUME /www

EXPOSE 8080

COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
