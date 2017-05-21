#!/bin/bash

# https://www.debuntu.org/how-to-managing-services-with-update-rc-d/
sudo update-rc.d -f apache2 remove
sudo systemctl disable apache2
sudo update-rc.d -f mysql remove
sudo update-rc.d -f memcached remove
sudo update-rc.d -f nginx remove
