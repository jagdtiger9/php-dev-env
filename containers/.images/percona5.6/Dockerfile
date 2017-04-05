FROM percona:5.6
MAINTAINER gimatov@gmail.com

# https://docs.docker.com/engine/faq/
ENV DEBIAN_FRONTEND=noninteractive

#RUN apt-get -y update && apt-get -y install libevent-dev
#RUN apt-get clean &&  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Expose ports
EXPOSE 3306 11212 9998 9999

#COPY conf/startup /usr/local/bin/startup
#RUN chown mysql:mysql /usr/local/bin/startup && chmod 0777 /usr/local/bin/startup

ADD ./conf /etc/mysql/conf.d
ADD ./conf /docker-entrypoint-initdb.d

# Use baseimage-docker's init system.
#CMD ["/usr/local/bin/startup"]
#CMD ["mysqld", "--daemon_memcached_option", "-p11212"]
