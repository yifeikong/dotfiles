#!/bin/bash

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

VERSION=0.10.0
PREFIX=/opt/spider/thrift

echo installing java for install thrift
# Install your choice of java
add-apt-repository ppa:webupd8team/java
apt-get update
apt-get install -y oracle-java8-installer

echo installing dependecies
apt-get install -y libboost-dev libboost-test-dev libboost-program-options-dev libboost-system-dev libboost-filesystem-dev libevent-dev automake libtool flex bison pkg-config g++ libssl-dev
cd /tmp

echo downloading thrift
curl http://archive.apache.org/dist/thrift/${VERSION}/thrift-${VERSION}.tar.gz | tar zx
cd thrift-${VERSION}/
./configure  --prefix=$PREFIX
make
make install
$PREFIX/bin/thrift --help
