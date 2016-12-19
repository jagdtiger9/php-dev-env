FROM jedisct1/phusion-baseimage-latest:16.10
MAINTAINER gimatov@gmail.com

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

# DNS update: to run apt-get and to let the docker build process access the internet.
#RUN "sh" "-c" "echo nameserver 8.8.8.8 >> /etc/resolv.conf"

# https://docs.docker.com/engine/faq/
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get -y update \
    && apt-get install -y apt-get install sphinxsearch \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

#RUN apt-get update && apt-get upgrade -y -o Dpkg::Options::="--force-confold"

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
