#!/bin/bash


if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

apt-get update
apt-get install -y squid3 apache2-utils

cat > /etc/squid3/squid.conf << EOF
auth_param basic program /usr/lib/squid3/basic_ncsa_auth /etc/squid3/passwords
auth_param basic realm proxy
acl authenticated proxy_auth REQUIRED
http_access allow authenticated
#Choose the port you want. Below we set it to default 3128.
http_port 3128
EOF

htpasswd -c /etc/squid3/passwords root
# you will enter passwords here

service squid3 restart
