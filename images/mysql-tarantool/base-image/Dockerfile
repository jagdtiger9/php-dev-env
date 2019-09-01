FROM phusion/baseimage
MAINTAINER gimatov@gmail.com

RUN apt-get -y update \
    && apt-get install -y build-essential \
    && apt-get install -y libncurses5-dev libboost-dev libmysqlclient-dev \
    && apt-get install -y mysql-client-core-5.7 \
    && apt-get install -y git cmake wget unzip nano bzip2 \
    && apt-get install -y lua50 liblua50-dev libcurl3 curl openssl \
    && apt-get install -y libicu-dev libunwind-dev binutils-dev

RUN /bin/bash \
    && git clone https://github.com/tarantool/mysql-tarantool-replication.git \
#    && git clone https://github.com/tarantool/libslave.git mysql-tarantool-replication \
    && cd mysql-tarantool-replication \
    && git submodule update --init --recursive

# после cmake правим файл
#https://github.com/tarantool/mysql-tarantool-replication/issues/24
RUN cd mysql-tarantool-replication \
    && cmake . \
    && cd CMakeFiles/rp.dir/ \
    && cat link.txt | sed '$s/$/-ldl/' > tmp.txt && mv tmp.txt link.txt \
    && cd - \
    && cat CMakeFiles/rp.dir/link.txt \
    && make \
    && cp replicatord /usr/local/sbin/replicatord \
    && ln -sf /dev/stderr /var/log/replicatord.log \
    && ln -sf /dev/stdout /var/log/replicatord.log

RUN apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Config files
COPY conf/replicatord.service /etc/systemd/system

CMD ["replicatord", "-c", "/usr/local/etc/replicatord.yml", "-l", "/var/log/replicatord.log"]
