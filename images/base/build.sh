#!/bin/bash
set -e

cd $(dirname "$0")

podman build --build-arg VERSION=$(cat VERSION) -t nas:50000/arch-base:latest -t nas:50000/arch-base:$(cat VERSION) "$@" .

podman push nas:50000/arch-base:$(cat VERSION ) || echo Nas is not available
