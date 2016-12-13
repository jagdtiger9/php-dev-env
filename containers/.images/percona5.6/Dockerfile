FROM percona:5.6
MAINTAINER gimatov@gmail.com

# https://docs.docker.com/engine/faq/
#ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get -y update \
    && apt-get -y install libevent-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Config files.
#COPY conf/apache/000-default.conf /etc/apache2/sites-enabled/000-default.conf
#COPY conf/apache/ports.conf /etc/apache2/ports.conf

# Expose ports
EXPOSE 3306 11211 11212

# Use baseimage-docker's init system.
CMD ["mysqld"]