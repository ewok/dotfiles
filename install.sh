#!/bin/env bash

set -e

sudo pacman -S --needed python-virtualenv

if [ ! -d .venv ];then
    virtualenv -p python2 .venv
fi
source .venv/bin/activate
pip install -r requirements.txt

inv install
