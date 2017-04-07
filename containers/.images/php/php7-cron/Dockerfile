FROM php7fpm_php_base
MAINTAINER gimatov@gmail.com

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

# https://docs.docker.com/engine/faq/
ENV DEBIAN_FRONTEND=noninteractive

# Define host WWW-files owner user UID&GID
# http://stackoverflow.com/questions/23544282/what-is-the-best-way-to-manage-permissions-for-docker-shared-volumes
# https://github.com/phusion/baseimage-docker#running_startup_scripts
RUN mkdir -p /etc/my_init.d
ADD ./.conf/cron/init_user.sh /etc/my_init.d/init_user.sh

# Add cron tasks
COPY ./.conf/cron/magicpro /etc/cron.d/magicpro
RUN chmod 0755 /etc/cron.d/magicpro
