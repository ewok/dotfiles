#!/bin/env bash

set -e

if [ ! -d .venv ];then
    virtualenv -p python3 .venv
fi
source .venv/bin/activate
pip install -r requirements.txt

inv install
