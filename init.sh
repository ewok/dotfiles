#!/bin/env bash

set -e

sudo pacman -Syu --needed
sudo pacman -S --needed yay
yay -S --needed ansible fish
ansible-galaxy collection install community.general
ansible-galaxy collection install kewlfft.aur
sudo usermod -s /bin/fish $USER
