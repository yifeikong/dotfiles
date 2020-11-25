#!/bin/bash

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

VERSION=3.8.0
PREFIX=/usr/local

apt-get install libsqlite3-dev libmysqlclient-dev libbz2-dev libffi-dev -y
curl https://www.python.org/ftp/python/${VERSION}/Python-${VERSION}.tgz -o Python-${VERSION}.tgz
tar xvzf Python-${VERSION}.tgz
cd Python-${VERSION}
./configure \
    --prefix=${PREFIX} \
    --enable-loadable-sqlite-extensions
make
make install
