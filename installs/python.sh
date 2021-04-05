#!/bin/bash

VERSION=3.9.0
PREFIX=$HOME/.local

apt-get install libsqlite3-dev libmysqlclient-dev libbz2-dev libffi-dev -y
curl https://www.python.org/ftp/python/${VERSION}/Python-${VERSION}.tgz -o Python-${VERSION}.tgz
tar xvzf Python-${VERSION}.tgz
cd Python-${VERSION}
./configure \
    --enable-optimizations \
    --prefix=${PREFIX} \
    --enable-loadable-sqlite-extensions
make
make install
