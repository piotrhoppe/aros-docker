#!/bin/bash
# 
# File:   arosDockerRun.bash
# Author: Piotr Hoppe <p_hoppe@poczta.onet.pl>
#
# Created on 2017-12-19, 16:49:27
#
xhost +
echo "Starting AROS Docker Container"

docker run --rm -d \
--name aros \
-e DISPLAY \
-v /tmp/.X11-unix:/tmp/.X11-unix \
aros
