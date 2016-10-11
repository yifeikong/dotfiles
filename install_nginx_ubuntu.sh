#!/bin/sh

NGINX_VER=1.11.4

wget https://nginx.org/download/nginx-${NGINX_VER}.tar.gz
tar xvzf nginx-${NGINX_VER}.tar.gz
cd nginx-$NGINX_VER
apt-get install libpcre3-dev zlib1g-dev
./configure \
    --prefix=/opt/nginx
make
sudo make install
cd -
rm -rf nginx-$NGINX_VER
