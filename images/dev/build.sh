#!/bin/bash
set -e

cd $(dirname "$0")

podman build -t nas:50000/dev:latest -t nas:50000/dev:$(date +%Y%m%d%H) "$@" .

podman push nas:50000/dev:latest || echo Nas is not available
