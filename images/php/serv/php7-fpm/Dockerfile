FROM jagdtiger/php-dev-env-git:php7.x
MAINTAINER gimatov@gmail.com

ARG allow_xdebug

ARG php_version
ENV PHP_VERSION ${php_version:-7.2}

ARG XDEBUG_PORT
ENV XDEBUG_PORT ${XDEBUG_PORT:-9002}

ARG FPM_LOG_LEVEL
ENV FPM_LOG_LEVEL ${FPM_LOG_LEVEL:-warning}

RUN echo "allow_xdebug: $allow_xdebug"
RUN echo "php_version: $php_version"
RUN echo "PHP_VERSION: $PHP_VERSION"
RUN echo "XDEBUG_PORT: $XDEBUG_PORT"

# Define host WWW-files owner user UID&GID
# http://stackoverflow.com/questions/23544282/what-is-the-best-way-to-manage-permissions-for-docker-shared-volumes
# https://github.com/phusion/baseimage-docker#running_startup_scripts
RUN mkdir -p /etc/my_init.d
ADD ./.conf/init_user.sh /etc/my_init.d/init_user.sh

COPY ./.conf/fpm/php-fpm.conf /etc/php/${PHP_VERSION}/fpm/php-fpm.conf
COPY ./.conf/fpm/www.conf /etc/php/${PHP_VERSION}/fpm/pool.d/www.conf

RUN mkdir /etc/service/php-fpm
ADD ./php7-fpm/start${PHP_VERSION}.sh /etc/service/php-fpm/run

RUN if [ "$allow_xdebug" = "0" ]; then phpdismod xdebug; fi

EXPOSE 9000
