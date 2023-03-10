#!/bin/env bash

set -e

# detect if linux is arch:
if [ -f /etc/arch-release ]; then
    echo "Arch Linux detected"
    sudo pacman -Syu --needed
    sudo pacman -S --needed yay
    yay -S --needed dotdrop
    sudo pacman -Syu --needed
    sudo pacman -S --needed yay
    yay -S --needed dotdrop
    # VoidLinux
elif [ $(uname -a | grep -c void) -eq 1 ]; then
    echo "Not Arch Linux, installing dotdrop from pip"
    sudo xbps-install -y python3-pip
    sudo python3 -m pip install dotdrop
fi

dotdrop -c config-user-1.yaml install
dotdrop -c config-user-2.yaml install
sudo dotdrop -c config-root.yaml install
