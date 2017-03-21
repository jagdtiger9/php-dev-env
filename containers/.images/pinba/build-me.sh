#!/bin/bash -ex

# update cache
apt-get update

apt-get install -y mysql-server-5.6 mysql-client-5.6 libmysqlclient18 libmysqlclient-dev \
build-essential protobuf-compiler libmysqlclient-dev \
libjudydebian1 libevent-dev libjudy-dev git libevent-2.0-5 libtool \
libevent-core-2.0-5 libevent-extra-2.0-5 libevent-openssl-2.0-5 \
libevent-pthreads-2.0-5 libprotobuf-dev libprotobuf-lite9 libprotobuf9 git-core automake


cd /var/tmp
git clone 'https://github.com/tony2001/pinba_engine'
apt-get source -y --force-yes mysql-server

pushd `find . -maxdepth 1 -type d | grep "mysql-" | head -n1`

# getting source directory of percona
MYSQL_SOURCES="`pwd`"

cp '/usr/include/mysql/mysql_version.h' ./include/
cp '/usr/include/mysql/my_config.h' ./include/

popd


cd pinba_engine

./buildconf.sh

ln -s /usr/bin/aclocal /usr/bin/aclocal-1.13
ln -s /usr/bin/automake /usr/bin/automake-1.13
automake --add-missing
autoreconf --force --install

OPTIONS="$(VISUAL=\"$(which 'cat')\" mysqlbug | grep 'Configured with' |  sed -e 's/.*configure -v //')"
./configure ${OPTIONS} \
--with-mysql=$MYSQL_SOURCES \
--with-judy \
--with-protobuf \
--with-event \
--libdir='/usr/lib/mysql/plugin/'

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
