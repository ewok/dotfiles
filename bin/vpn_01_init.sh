#!/bin/bash

#
# $1 = hostname

OVPN_DATA="ovpn-data"
docker run --name $OVPN_DATA -v ${HOME}/share/openvpn:/etc/openvpn busybox 2>/dev/null || exists="true"

docker run --volumes-from $OVPN_DATA -ti --rm kylemanna/openvpn ovpn_genconfig -u udp://${1:-localhost}
docker run --volumes-from $OVPN_DATA -ti --rm kylemanna/openvpn ovpn_initpki
