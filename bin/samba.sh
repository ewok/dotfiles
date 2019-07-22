#!/bin/bash

# $1=user
# $2=password

# it makes two folders, private and publc(browsable)

docker stop samba
docker rm samba
docker run -it --name=samba \
    -p 139:139 -p 445:445 \
	-v $(readlink -f $HOME)/share/samba/private:/private \
	-v $(readlink -f $HOME)/share/samba/public:/public \
	-d dperson/samba \
	-s "private;/private;no;no;no;${1:-user}" \
	-s "public;/public;yes;no;no;${1:-user}" \
	-u "${1:-user};${2:-password}" -g "protocol = SMB2"
