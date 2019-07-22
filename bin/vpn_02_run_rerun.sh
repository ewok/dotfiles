#!/bin/bash

DATA="ovpn-data"

docker stop openvpn
docker rm openvpn
docker run --volumes-from $DATA --name=openvpn -d -p 1194:1194/udp --cap-add=NET_ADMIN kylemanna/openvpn
