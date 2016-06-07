#!/bin/sh

if [ "$EUID" != "0" ]; then
    echo "***must run as root***"
    exit 1
fi

git clone https://github.com/rofl0r/proxychains-ng.git 
cd proxychains-ng 
./configure && make && make install  
make install-config

echo ***cleaning up
rm -rf proxychains-ng

cat << EOF > /usr/local/etc/proxychains.conf
strict_chain
proxy_dns 
remote_dns_subnet 224
tcp_read_time_out 15000
tcp_connect_time_out 8000
localnet 127.0.0.0/255.0.0.0
quiet_mode

[ProxyList]
# shadowsocks
socks5  127.0.0.1 1080
EOF

echo "Congrants, You can now use 'proxychains4 [command]'"
