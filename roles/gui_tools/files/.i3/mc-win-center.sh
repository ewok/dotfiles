#!/bin/sh
# Thanks to http://pushl.net/blog/18/
eval i3-msg $*
HERE=`xdotool getwindowfocus`

ULX=`xwininfo -id $HERE | grep "  Absolute upper-left X:" | awk '{print $4}'`
ULY=`xwininfo -id $HERE | grep "  Absolute upper-left Y:" | awk '{print $4}'`

# If there is no window, ULX == 1 and ULY == 1.
if [ $ULX != "-1" -o $ULY != "-1" ]; then
    eval `xdotool getwindowgeometry --shell $HERE`

    NX=`expr $WIDTH / 2`
    NY=`expr $HEIGHT / 2`

    xdotool mousemove --window $WINDOW $NX $NY
fi

# Refresh i3status to update keyboard layout status
pkill -x --signal=SIGUSR1 i3status
