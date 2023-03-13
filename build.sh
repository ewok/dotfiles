#!/usr/bin/env bash

set -e

cd $(dirname "$0")

AP="ansible-playbook"

# ANSIBLE_CONFIG="ansible.cfg"

$AP -D main.yaml "$@"
