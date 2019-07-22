#!/usr/bin/env bash

LFILE=/tmp/one-`echo "$@" | md5 | cut -d\  -f1`.pid
if [ -e ${LFILE} ] && kill -0 `cat ${LFILE}`; then
   exit
fi

trap "rm -f ${LFILE}; exit" INT TERM EXIT
echo $$ > ${LFILE}

$@

rm -f ${LFILE}
