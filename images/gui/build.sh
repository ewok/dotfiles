#!/bin/bash
set -e

cd $(dirname "$0")

podman build -t nas:50000/gui:latest -t nas:50000/gui:$(date +%Y%m%d%H) "$@" .

podman push nas:50000/gui:latest || echo Nas is not available
