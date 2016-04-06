#!/bin/bash

# https://www.debuntu.org/how-to-managing-services-with-update-rc-d/
sudo update-rc.d -f apache2 default
sudo update-rc.d -f mysql default
sudo update-rc.d -f memcached default
sudo update-rc.d -f nginx default
