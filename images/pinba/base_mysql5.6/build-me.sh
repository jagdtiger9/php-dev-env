#!/bin/bash -ex

MYSQL_MAJOR=5.6
MYSQL_VERSION=5.6.35-1debian8

echo "deb-src http://repo.mysql.com/apt/debian/ jessie mysql-${MYSQL_MAJOR}" > /etc/apt/sources.list.d/mysql.list

apt-get update && apt-get install -y mysql-client-5.6 libmysqlclient18 libmysqlclient-dev \
build-essential protobuf-compiler libmysqlclient-dev \
libjudydebian1 libevent-dev libjudy-dev git libevent-2.0-5 libtool \
libevent-core-2.0-5 libevent-extra-2.0-5 libevent-openssl-2.0-5 \
libevent-pthreads-2.0-5 libprotobuf-dev libprotobuf-lite9 libprotobuf9 git-core automake \
cmake libncurses5-dev


cd /var/tmp
git clone 'https://github.com/tony2001/pinba_engine'
apt-get source -y --force-yes mysql-server

pushd `find . -maxdepth 1 -type d | grep "mysql-" | head -n1`
# getting source directory of percona
MYSQL_SOURCES=`pwd`
OPTIONS="$(VISUAL=$(which 'cat') mysqlbug | grep 'Configured with' |  sed -e 's/.*configure -v //')"

apt-get remove -y mysql-server
cd BUILD/ && cmake $OPTIONS ../ && make && make install
cd ../ && cp support-files/mysql.server.sh /etc/init.d/mysql
cp ./BUILD/include/mysql_version.h ./include/
cp ./BUILD/include/my_config.h ./include/

#cp /usr/include/mysql/mysql_version.h ./include/
#cp /usr/include/mysql/my_config.h ./include/

popd

cd pinba_engine

automake --add-missing
autoreconf --force --install

./buildconf.sh

ln -s /usr/bin/aclocal /usr/bin/aclocal-1.13 && ln -s /usr/bin/automake /usr/bin/automake-1.13


./configure $OPTIONS \
--with-mysql=$MYSQL_SOURCES \
--with-judy \
--with-protobuf \
--with-event \
--libdir=/usr/lib/mysql/plugin/

make

make install

# purge development libraries from image
#apt-get purge -y --force-yes $DEPENDENCY_PACKAGES
#apt-get purge -y --force-yes man-db gcc gawk cpp autoconf manpages manpages-dev m4 bison \
#libpercona-client-lgpl-dev libaio-dev libc-dev-bin libc6-dev libjemalloc-dev libpam0g-dev \
#libreadline-gplv2-dev libssl-dev libtinfo-dev libwrap0-dev linux-libc-dev zlib1g-dev bsdmainutils \
#|| true

# autoremove all automaticaly installed packages
apt-get -y --force-yes autoremove

# clean cache
apt-get clean

# remove build directories
#rm -rf pinba-engine mysql-source
