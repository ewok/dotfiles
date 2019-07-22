#!/bin/bash

# Run sock5 over the openvpn container

# $1=username
# $2=password

docker stop socks5
docker rm socks5
docker run -d \
    --name socks5 \
    --restart=unless-stopped \
    --net=container:openvpn \
    -e PROXY_USER=${1:-user} \
    -e PROXY_PASSWORD=${2:-password} \
    serjs/go-socks5-proxy
