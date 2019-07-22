#!/bin/bash

# Run sshd over openvpn container

# $1=local port
# $1=remote(host) port

# Prerequisites:
# In ~/.ssh/config:
#
#Host localhost
#        HostName localhost
#        IdentityFile ~/.ssh/id_rsa
#        User user
#        Port 22
#        ForwardAgent yes
#        TCPKeepAlive yes
#        ConnectTimeout 5
#        ServerAliveCountMax 10
#        ServerAliveInterval 15

docker stop sshd
docker rm sshd
docker run --name=sshd \
    --net=container:openvpn \
    -d -v $HOME/.ssh:/root/ssh:ro \
    -e TUNNEL_HOST=localhost \
    -e REMOTE_HOST=$(hostname) \
    -e LOCAL_PORT=${1:-22} \
    -e REMOTE_PORT=${2:-22} \
    cagataygurturk/docker-ssh-tunnel:0.0.1
