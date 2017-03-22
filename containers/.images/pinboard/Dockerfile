FROM jedisct1/phusion-baseimage-latest:16.10
MAINTAINER gimatov@gmail.com

# https://docs.docker.com/engine/faq/
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get -y update \
    && apt-get install -y software-properties-common python-software-properties \
    && apt-get install -y git php php-common php-cli php-dev php-mcrypt php-gd \
    && apt-get install -y php-mysqlnd php-memcached php-curl php-ctype php-json php-apcu

RUN apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN mkdir /www

COPY phps /bin/
COPY router.php /
COPY docker-entrypoint.sh /

# Persist pinboard scripts in outer volume
VOLUME /www

EXPOSE 8080

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["phps"]
