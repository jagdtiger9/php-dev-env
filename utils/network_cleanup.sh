#!/bin/bash

# ERROR: for nodejs  Cannot start service nodejs: driver failed programming external connectivity on endpoint nodejs 
# (2d1c917341657f1f26e83814f77d248e715f618b4e2d65237e89ffe37979c3f2): Bind for 0.0.0.0:8086 failed: port is already allocated
# ERROR: Encountered errors while bringing up the project.

# https://github.com/moby/moby/issues/26527

# Проверяем, кто слушает порт. Должен быть docker-pr (dpocker-proxy)
sudo lsof -nP | grep LISTEN

sudo service docker stop

# Порт освобожден
sudo lsof -nP | grep LISTEN

# Стартуем docker
sudo service docker start