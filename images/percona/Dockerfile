FROM percona:5.7
MAINTAINER gimatov@gmail.com

# Memcache-InnoDB plugin requires libevent-dev
#RUN apt-get -y update \
#    && apt-get -y install libevent-dev \
#    && apt-get clean \
#    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Expose ports
EXPOSE 3306 11212 9998 9999

ADD ./conf /etc/my.cnf.d
ADD ./conf /docker-entrypoint-initdb.d

#COPY startup /usr/local/bin/startup
#RUN chown mysql:mysql /usr/local/bin/startup && chmod 0777 /usr/local/bin/startup

# Use baseimage-docker's init system.
#CMD ["/usr/local/bin/startup"]
#CMD ["mysqld", "--daemon_memcached_option", "-p11212"]
