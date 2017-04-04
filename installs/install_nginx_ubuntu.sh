#!/bin/bash

source ../lib/colors.sh

DEFAULT_INSTALL_DIR=/opt/spider/nginx
DEFAULT_INSTALL_VER=1.11.4

echo -n -e "which version to install(default ${GREEN}$DEFAULT_INSTALL_VER${NO_COLOR})> "
read NGINX_VER
echo -n -e "where to install(default ${GREEN}$DEFAULT_INSTALL_DIR${NO_COLOR})> "
read INSTALL_DIR

if [ -z $NGINX_VER ]; then
    NGINX_VER=$DEFAULT_INSTALL_VER
fi

if [ -z $INSTALL_DIR ]; then
    INSTALL_DIR=$DEFAULT_INSTALL_DIR
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
rm -rf nginx-${NGINX_VER}.tar.gz
echo -e "${GREEN}see $INSTALL_DIR/sbin/nginx -h for help${NO_COLOR}"
