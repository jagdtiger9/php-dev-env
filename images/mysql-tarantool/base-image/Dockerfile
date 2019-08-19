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

# Config files.
COPY conf/replicatord.service /etc/systemd/system

# Config files.
COPY conf/sphinxsearch /etc/default/sphinxsearch
COPY conf/sphinx.conf /etc/sphinxsearch/sphinx.conf
COPY conf/cron/indexer.sh /usr/local/bin/indexer.sh
COPY conf/cron/sphinx_indexer /etc/cron.d/sphinx_indexer
RUN chmod 0644 /etc/cron.d/sphinx_indexer

RUN ln -sf /dev/stderr /var/log/sphinxsearch/searchd.log \
    && ln -sf /dev/stdout /var/log/sphinxsearch/query.log

# Expose ports
EXPOSE 9312 9306

VOLUME ["/var/www"]

RUN mkdir /etc/service/sphinxsearch
ADD start.sh /etc/service/sphinxsearch/run
ADD conf/wait-for-it.sh /usr/local/bin/wait-for-it.sh




# https://github.com/tarantool/mysql-tarantool-replication
# https://github.com/tarantool/mysql-tarantool-replication/issues/24
# https://www.tarantool.io/ru/doc/1.10/tutorials/libslave/
# https://www.tarantool.io/ru/learn/improving-mysql/
