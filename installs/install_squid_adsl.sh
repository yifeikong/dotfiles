#!/bin/bash

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

yum install -y squid httpd-tools
systemctl enable squid
echo enter adslbox1 please
htpasswd -c /etc/squid/passwd root

cat > /etc/squid/squid.conf << EOF
auth_param basic program /usr/lib64/squid/basic_ncsa_auth /etc/squid/passwd
auth_param basic children 5
auth_param basic realm Squid Basic Authentication
auth_param basic credentialsttl 2 hours
acl auth_users proxy_auth REQUIRED
http_access allow auth_users
http_port 3128
EOF

systemctl start squid
systemctl status squid

cat > /usr/local/bin/redail << EOF
#!/bin/bash

adsl-stop > /dev/null
adsl-start > /dev/null
ip addr show ppp0 | grep inet | awk '{print $2}'
EOF
chmod +x /usr/local/bin/redail

cat > /usr/local/bin/get_ip << EOF
#!/bin/bash

ip addr show ppp0 | grep inet | awk '{print $2}'
EOF
chmod +x /usr/local/bin/get_ip
