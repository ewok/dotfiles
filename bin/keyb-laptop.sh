#!/bin/env bash

xset r rate 220 25
if [ $1 -eq 1 ]; then
  setxkbmap -rules "evdev" -model "pc105" -layout "us,ru" -option "ctrl:swapcaps"
else
  setxkbmap -rules "evdev" -model "pc105" -layout "us,ru" -option
fi

pkill xcape
xcape
