FROM tony2001/pinba
MAINTAINER gimatov@gmail.com

# https://docs.docker.com/engine/faq/
#ENV DEBIAN_FRONTEND=noninteractive

# Copy build script
#COPY build-me.sh /opt/
# RUN build script (build and install pinba-server)
##RUN cd /opt && ./build-me.sh

#COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

# expose extraport for pinba
EXPOSE 30003

# Use baseimage-docker's init system.
#CMD ["/sbin/my_init"]
#ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
