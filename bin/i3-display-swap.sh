#!/usr/bin/env bash
# requires jq

set -e

DIRECTION=${1:-right}

IFS=:
ALL=$(i3-msg -t get_workspaces | jq -r '.[]|.name')
CURRENT_ALL=$(i3-msg -t get_outputs | jq -r '.[]|"\(.current_workspace)"' | grep -v 'null')
CURRENT=$(i3-msg -t get_workspaces | jq '.[] | select(.focused==true).name' | cut -d"\"" -f2)

echo $ALL | \
while read -r num; do
    # echo "moving ${num} ${DIRECTION}..."
    i3-msg -- workspace --no-auto-back-and-forth "${num}"
    i3-msg -- move workspace to output ${DIRECTION}
    # i3-msg workspace "${current_workspace}"
done

echo $CURRENT_ALL | \
while read -r name; do
    # echo "switching to ${name}..."
    i3-msg -- workspace "${name}"
    # i3-msg move workspace to output ${DIRECTION}
    # i3-msg workspace "${current_workspace}"
done

i3-msg -- workspace "${CURRENT}"


