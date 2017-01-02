#!/bin/bash

if [ "$EUID" -ne 0 ]; then
    echo "Please run as root"
    exit
fi

TMUX_VER=2.2
apt-get install -y gcc make libncurses5-dev libevent-dev wget
wget https://github.com/tmux/tmux/releases/download/${TMUX_VER}/tmux-${TMUX_VER}.tar.gz
tar xzf tmux-${TMUX_VER}.tar.gz
cd tmux-${TMUX_VER}
./configure && make
make install
cd -
rm tmux-${TMUX_VER}.tar.gz
rm -rf tmux-${TMUX_VER}/
