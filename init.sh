#!/bin/env bash

set -xe

ID=$(cat /etc/os-release | grep '^ID=' | cut -f2 -d=|sed 's/"//gi')
echo $ID

case "$ID" in
    "pop"|"ubuntu"|"debian")
        yes | sudo apt install ansible fish
        ansible-galaxy collection install community.general
        sudo usermod -s /usr/bin/fish $USER
    ;;
    "manjaro"|"manjaro-arm")
        sudo pacman -Syu --needed
        sudo pacman -S --needed yay
        yay -S --needed ansible fish python-packaging
        ansible-galaxy collection install community.general
        ansible-galaxy collection install kewlfft.aur
        sudo usermod -s /bin/fish $USER
    ;;
    "arcolinux")
        sudo pacman -Syu --needed
        yay -S --needed ansible fish python-packaging
        ansible-galaxy collection install community.general
        ansible-galaxy collection install kewlfft.aur
        sudo usermod -s /bin/fish $USER
    ;;
    "void")
        sudo xbps-install -Syu
        sudo xbps-install -Sy ansible fish-shell
        sudo xbps-reconfigure -f glibc-locales
        ansible-galaxy collection install community.general
        ansible-galaxy collection install kewlfft.aur
        sudo usermod -s /bin/fish $USER
    ;;
    *) echo No init.
    ;;
esac
