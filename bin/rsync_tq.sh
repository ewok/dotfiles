#!/bin/bash

set -e

usage() {
    echo "Usage: $0 <source> <dest> <file list>"
    exit 1
}

[ "$#" -eq 3 ] || usage

SRC_PATH=$1
DEST_PATH=$2
FILE_LIST=$3

RSYNC_LIST="$(mktemp)"

IFS_O=$IFS
IFS=$'|'
for file in $FILE_LIST;do
    echo "$file" >> $RSYNC_LIST
done
IFS=$IFS_O

CMD="rsync -avr --append --progress --files-from=$RSYNC_LIST \"$SRC_PATH\" \"$DEST_PATH\""

if which tsp;then CMD="tsp -f -n $CMD";fi

if [ -n "$TMUX" ]; then
	tmux split-window -p 10 \
		"$CMD;rm -f $RSYNC_LIST;
		read" \; last-pane
else
    $CMD
    rm -f $RSYNC_LIST
fi
