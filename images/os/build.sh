#!/bin/bash
set -e

cd $(dirname "$0")

podman build -t nas:50000/os:latest -t nas:50000/os:$(date +%Y%m%d%H) "$@" .

podman push nas:50000/os:latest || echo Nas is not available
