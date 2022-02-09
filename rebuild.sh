#!/bin/env bash

set -e

cd $(dirname "$0")

AP="ansible-playbook"

$AP -D main.yaml -K "$@"
