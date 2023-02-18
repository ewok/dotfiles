#!/bin/env bash

set -e

sudo pacman -Syu --needed
sudo pacman -S --needed yay
yay -S --needed dotdrop

dotdrop -c config-user-1.yaml install
dotdrop -c config-user-2.yaml install
sudo dotdrop -c config-root.yaml install
