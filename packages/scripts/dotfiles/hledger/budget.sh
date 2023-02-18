#!/usr/bin/env bash

ARG1="$1"
ARGS="${@:2}"

if [ "$1" == "-i" ]
then
  h \
    -s bal \
    --pretty-tables \
    --no-total --no-elide \
    --budget -E \
    ^inc \
    -b $(date +%Y-%m) \
    -e $(date +%Y-%m --date="next month") \
    -M --real ${ARGS[@]} | rg --color=always --passthru '\d\d\d%'
else
    ARGS=($1 $ARGS)
fi

h \
  -s bal \
  --pretty-tables \
  --budget -E \
  ^exp \
  -b $(date +%Y-%m) \
  -e $(date +%Y-%m --date="next month") \
  -M --real ${ARGS[@]} | rg -v 'Budget performance' | rg --color=always --passthru '\d\d\d%'
