#!/bin/bash

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

add-apt-repository ppa:webupd8team/java
apt-get update
apt-get install oracle-java8-installer

echo JAVA_HOME="/usr/lib/jvm/java-8-oracle" >> /etc/environment
