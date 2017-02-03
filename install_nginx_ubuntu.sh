#!/bin/bash

echo -n "which version to install> "
read NGINX_VER
echo -n "where to install> "
read INSTALL_DIR

if [ -z $NGINX_VER ]; then
    NGINX_VER=1.11.4
fi

if [ -z $INSTALL_DIR ]; then
    INSTALL_DIR=/opt/spider/nginx
fi

wget https://nginx.org/download/nginx-${NGINX_VER}.tar.gz
tar xvzf nginx-${NGINX_VER}.tar.gz
cd nginx-${NGINX_VER}
apt-get install libpcre3-dev zlib1g-dev
./configure \
    --prefix=${INSTALL_DIR}
make
sudo make install
cd -
rm -rf nginx-${NGINX_VER}
echo "see $INSTALL_DIR/sbin/nginx -h for help"
