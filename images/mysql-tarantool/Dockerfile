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


cp replicatord.yml /usr/local/etc/replicatord.yml

CMD ["systemctl", "start", "replicatord"]


# https://www.google.ru/search?q=%D0%A0%D0%B5%D0%BF%D0%BB%D0%B8%D0%BA%D0%B0%D1%86%D0%B8%D1%8F+%D0%B8%D0%B7+MySQL+%D0%B2+Tarantool&oq=%D0%A0%D0%B5%D0%BF%D0%BB%D0%B8%D0%BA%D0%B0%D1%86%D0%B8%D1%8F+%D0%B8%D0%B7+MySQL+%D0%B2+Tarantool&aqs=chrome..69i57j69i61.1128j0j7&client=ubuntu&sourceid=chrome&ie=UTF-8
# https://www.tarantool.io/ru/doc/1.10/tutorials/libslave/
# https://www.tarantool.io/ru/learn/improving-mysql/
#https://github.com/tarantool/mysql-tarantool-replication/issues/2