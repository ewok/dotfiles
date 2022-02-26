#!/usr/bin/env bash

LAYOUT="$(swaymsg -t get_inputs --raw | jq '[.[] | select(.type == "keyboard")][0] | .xkb_active_layout_name' | sed 's/"//g' | cut -f1 -d ' ')"

case $LAYOUT in

  English)
    SHOW="🇺🇸"
    ;;

  Russian)
    SHOW="🇷🇺"
    ;;

  *)
    SHOW=$LAYOUT
    ;;
esac

echo "$SHOW"
