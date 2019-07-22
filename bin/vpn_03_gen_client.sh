#!/bin/bash

# $1 = Client name

DATA="ovpn-data"

docker run --volumes-from $DATA --rm -ti kylemanna/openvpn easyrsa build-client-full ${1:-CLIENTNAME} nopass
docker run --volumes-from $DATA --rm -ti kylemanna/openvpn ovpn_getclient ${1:-CLIENTNAME} > ${1:-CLIENTNAME}.ovpn
