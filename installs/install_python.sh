#!/bin/bash

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

VERSION=3.6.0
PREFIX=/opt/spider/python

curl https://www.python.org/ftp/python/${VERSION}/Python-${VERSION}.tgz -o Python-${VERSION}.tgz
tar xvzf Python-${VERSION}.tgz
cd Python-${VERSION}
./configure \
    --prefix=${PREFIX}
make
make install

