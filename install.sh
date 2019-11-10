#!/bin/env bash

set -e

sudo pacman -S --needed python-virtualenv

if [ ! -d .env ];then
    virtualenv -p python2 .env
fi
source .env/bin/activate
pip install fabric

inv install
