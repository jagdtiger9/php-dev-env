#!/bin/bash

HOSTUID=$(stat -c "%u" /var/www/index.php)
HOSTGID=$(stat -c "%g" /var/www/index.php)

echo $HOSTUID $HOSTGID > /var/www/vardata/log/crontab/host_uid-gid.log

EXISTS=$(cat /etc/passwd | grep $HOSTUID | wc -l)
if [ $EXISTS == "0" ]; then
    # Create new user using target UID
    useradd -r --uid=$HOSTUID magicpro
else
    # UID exists, find group name and add
    useradd -r magicpro
fi

#groupadd -r magicpro
#useradd -r -g magicpro magicpro
