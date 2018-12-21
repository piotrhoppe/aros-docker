# Copyright (C) 2018 Piotr Hoppe <p_hoppe@poczta.onet.pl>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

FROM ubuntu:16.04

LABEL maintainer="Piotr Hoppe <p_hoppe@poczta.onet.pl>"

RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get -y install build-essential \
    netpbm gawk git automake bison flex python \
    libpng++-dev wget libasound2-dev libx11-dev mesa-common-dev libsdl1.2-dev \
    libc6-dev-i386 \
    libxcursor-dev

RUN git clone https://github.com/ezrec/AROS-mirror.git /usr/src/AROS-mirror

ARG ENABLE_DEBUG=none
ARG TARGET=linux-x86_64
ARG CPU_QUANTITY=1
ARG ENABLE_X11_SHM=no

RUN cd /usr/src/AROS-mirror/AROS \
    && ./configure --enable-debug=$ENABLE_DEBUG --target=$TARGET --enable-x11-shm=$ENABLE_X11_SHM \
    && make "-j"$CPU_QUANTITY \
    && make default-x11keymaptable

workdir /usr/src/AROS-mirror/AROS/bin/linux-x86_64/AROS
CMD ["boot/linux/AROSBootstrap"]
