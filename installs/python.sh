#!/bin/bash

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

VERSION=3.6.1
PREFIX=/opt/spider/python

apt-get install libsqlite3-dev -y
curl https://www.python.org/ftp/python/${VERSION}/Python-${VERSION}.tgz -o Python-${VERSION}.tgz
tar xvzf Python-${VERSION}.tgz
cd Python-${VERSION}
./configure \
    --prefix=${PREFIX} \
    --enable-loadable-sqlite-extensions
make
make install
