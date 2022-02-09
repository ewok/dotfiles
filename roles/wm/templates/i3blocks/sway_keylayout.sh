#!/usr/bin/env bash

LAYOUT="$(swaymsg -t get_inputs | jq '.[].xkb_active_layout_name' | grep -v null | head -1 | sed s/\"//g)"

case $LAYOUT in

  "English (US)")
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
