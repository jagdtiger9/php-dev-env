#!/bin/bash

HOSTUID=$(stat -c "%u" /var/www/magicpro/public/index.php)
HOSTGID=$(stat -c "%g" /var/www/magicpro/public/index.php)

echo $HOSTUID $HOSTGID > /var/www/magicpro/public/vardata/log/crontab/host_uid-gid.log

EXISTS=$(cat /etc/group | grep $HOSTGID | wc -l)
# Create new group using target GID and add nobody user
if [ $EXISTS == "0" ]; then
    groupadd -g $HOSTGID magicpro
fi

EXISTS=$(cat /etc/passwd | grep $HOSTUID | wc -l)
if [ $EXISTS == "0" ]; then
    # Create new user using target UID
    useradd -r --uid=$HOSTUID --gid=$HOSTGID magicpro
#else
    # UID exists, find group name and add
#    usermod -a -G magicpro  magicpro
fi
