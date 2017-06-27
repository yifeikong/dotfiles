#!/bin/bash

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

CURRENT_USER=spider

apt-get install -y software-properties-common python-software-properties
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
apt-get update
apt-get install -y docker-ce
systemctl status docker

# set current user to run docker without sudo
usermod -aG docker $CURRENT_USER

echo please type: su - $CURRENT_USER
