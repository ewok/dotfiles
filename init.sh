#!/bin/env bash

set -xe

ID=$(cat /etc/os-release | grep '^ID=' | cut -f2 -d=|sed 's/"//gi')
echo $ID

case "$ID" in
    "pop"|"ubuntu"|"debian")
        yes | sudo apt install ansible
        ansible-galaxy collection install community.general
    ;;
    "manjaro"|"manjaro-arm")
        sudo pacman -Syu --needed
        sudo pacman -S --needed yay
        yay -S --needed ansible python-packaging
        ansible-galaxy collection install community.general
        ansible-galaxy collection install kewlfft.aur
    ;;
    "arcolinux")
        sudo pacman -Syu --needed
        yay -S --needed ansible python-packaging
        ansible-galaxy collection install community.general
        ansible-galaxy collection install kewlfft.aur
    ;;
    "void")
        sudo xbps-install -Syu
        sudo xbps-install -Sy ansible
        sudo xbps-reconfigure -f glibc-locales
        ansible-galaxy collection install community.general
        ansible-galaxy collection install kewlfft.aur
    ;;
    *) echo No init.
    ;;
esac
