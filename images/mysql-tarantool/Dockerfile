FROM jedisct1/phusion-baseimage-latest:16.04
MAINTAINER gimatov@gmail.com

# https://docs.docker.com/engine/faq/
ENV DEBIAN_FRONTEND=noninteractive

sudo apt-get install libboost-all-devapt
git clone https://github.com/tarantool/libslave.git tarantool-libslave
cd tarantool-libslave
git submodule init
git submodule update
sudo apt install cmake
sudo apt install libncurses5-dev
sudo apt install libmysqlclient-dev
cmake .
make





# https://www.google.ru/search?q=%D0%A0%D0%B5%D0%BF%D0%BB%D0%B8%D0%BA%D0%B0%D1%86%D0%B8%D1%8F+%D0%B8%D0%B7+MySQL+%D0%B2+Tarantool&oq=%D0%A0%D0%B5%D0%BF%D0%BB%D0%B8%D0%BA%D0%B0%D1%86%D0%B8%D1%8F+%D0%B8%D0%B7+MySQL+%D0%B2+Tarantool&aqs=chrome..69i57j69i61.1128j0j7&client=ubuntu&sourceid=chrome&ie=UTF-8
# https://www.tarantool.io/ru/doc/1.10/tutorials/libslave/
# https://www.tarantool.io/ru/learn/improving-mysql/
#https://github.com/tarantool/mysql-tarantool-replication/issues/2