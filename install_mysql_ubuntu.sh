#!/bin/bash

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi


wget http://dev.mysql.com/get/mysql-apt-config_0.6.0-1_all.deb
dpkg -i mysql-apt-config_0.6.0-1_all.deb
rm mysql-apt-config_0.6.0-1_all.deb
apt-get update
apt-get install mysql-server
mysql_secure_installation
mysqld --initialize
service mysql status
