#!/bin/sh
# tq CMD... - tmux/screen wrapper for nq to display output in new window

set -e

SRC_PATH=$1
DEST_PATH=$2
FILE_LIST=$3

TMP_PATH="$TMPDIR/rsync"
mkdir -p $TMP_PATH
export NQDIR=$TMP_PATH

SUFFIX=$(echo "SRC_PATH$FILE_LIST"|md5sum|cut -f1 -d' ')
RSYNC_LIST="$TMP_PATH/list-$SUFFIX"
rm -f $RSYNC_LIST

IFS_O=$IFS
IFS=$'\n'
for file in $FILE_LIST;do
    echo "$file" >> $RSYNC_LIST
done
IFS=$IFS_O

s=$(nq -c rsync -avr --append --progress --files-from=$RSYNC_LIST "$SRC_PATH" "$DEST_PATH")
p=${s##*.}

printf '%s\n' "$s"

if [ -n "$p" ]; then
       	if [ -n "$TMUX" ]; then
		tmux split-window -p 1 \
			"trap true INT QUIT TERM EXIT;
            export NQDIR=$TMP_PATH
            fq $s
            read" \; last-pane
	elif [ -n "$STY" ]; then
		screen -t '<' sh -c "trap true INT QUIT TERM EXIT;
			fq $s || kill $p
			# printf '[%d exited, ^D to exit.]\n' $p;
			# cat >/dev/null"
		screen -X other
	fi
fi
