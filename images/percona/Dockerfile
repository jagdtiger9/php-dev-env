FROM percona:5.7
MAINTAINER gimatov@gmail.com

# Expose ports
EXPOSE 3306 11212 9998 9999

ADD ./conf /etc/my.cnf.d
ADD ./conf /docker-entrypoint-initdb.d

VOLUME ["/var/lib/mysql"]

#COPY startup /usr/local/bin/startup
#RUN chown mysql:mysql /usr/local/bin/startup && chmod 0777 /usr/local/bin/startup

# Use baseimage-docker's init system.
#CMD ["/usr/local/bin/startup"]
#CMD ["mysqld", "--daemon_memcached_option", "-p11212"]
