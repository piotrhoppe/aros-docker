# Copyright (C) 2017 Piotr Hoppe <p_hoppe@poczta.onet.pl>
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

FROM alpine:latest

LABEL maintainer="Piotr Hoppe <p_hoppe@poczta.onet.pl>"

RUN apk update \
    && apk upgrade \
    && apk add alpine-sdk git gawk automake subversion \
    && mkdir /usr/src \

RUN svn checkout http://svn.code.sf.net/p/netpbm/code/stable /usr/src/netpbm

COPY config.mk /usr/src/netpbm


RUN cd /usr/src/netpbm \
#    && ./configure \
    && make \
    && make install

RUN git clone https://github.com/ezrec/AROS-mirror.git /usr/src/AROS-mirror bison flex \
    && cd /usr/src/AROS-mirror/AROS \
    && ./configure \
    && make

CMD ["/bin/sh"]
