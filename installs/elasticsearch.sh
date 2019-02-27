#!/bin/bash

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi


VERSION=5.4.0
INSTALL_DIR=/opt/spider/elasticsearch/

apt-get install -y openjdk-8-jre-headless
wget -c https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-${VERSION}.zip
unzip elasticsearch-${VERSION}.zip

mv elasticsearch-${VERSION} $INSTALL_DIR
chmod +x ${INSTALL_DIR}bin/elasticsearch

echo run ${INSTALL_DIR}bin/elasticsearch
