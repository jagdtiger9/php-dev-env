FROM jedisct1/phusion-baseimage-latest:16.04
MAINTAINER gimatov@gmail.com

# https://docs.docker.com/engine/faq/
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get -y update \
    && apt-get install -y libboost-all-devapt mysql-client-core-5.7 \
    && apt-get install -y git cmake wget unzip nano bzip2
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN git clone https://github.com/tarantool/mysql-tarantool-replication.git mysql_tarantool-replication \
    && cd mysql-tarantool-replication \
    && git submodule update --init --recursive \
    && cmake

# после cmake правим файл
#https://github.com/tarantool/mysql-tarantool-replication/issues/24
RUN echo ' -ldl ' >> CMakeFiles/rp.dir/link.txt \
    && make

RUN cp replicatord /usr/local/sbin/replicatord

# Config files
COPY conf/replicatord.service /etc/systemd/system

systemctl start replicatord

# https://github.com/tarantool/mysql-tarantool-replication
# https://github.com/tarantool/mysql-tarantool-replication/issues/24
# https://www.tarantool.io/ru/doc/1.10/tutorials/libslave/
# https://www.tarantool.io/ru/learn/improving-mysql/
