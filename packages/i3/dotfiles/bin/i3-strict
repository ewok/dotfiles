#!/usr/bin/env bash

usage() {
    cat << EOF
Usage: $PROG [workspace-move|move-scratchpad|scratchpad-show]
Implements StrictMouseFocus for i3wm.

In your i3wm config file (usually ~/.config/i3/config):

for every line that changes the workspace, add this to the end:
    , exec i3-strict workspace-move

Instead of 'move scratchpad', use:
    exec i3-strict move-scratchpad

Instead of 'scratchpad show', use:
    exec i3-strict scratchpad-show

eg:

bindsym Mod1+Control+F1          workspace 1, exec i3-strict workspace-move
bindsym Mod1+Control+F2          workspace 2, exec i3-strict workspace-move
... etc
bindsym Mod1+Control+minus       exec i3-strict move-scratchpad
bindsym Mod1+Control+Shift+minus exec i3-strict scratchpad-show

EOF
}

get-focus-window() {
    IFS=' ,'
    set -- $( xdpyinfo | grep '^focus:' )
    echo "$(($3))" # convert 0x400058 to 4194392
}

get-mouse-window() {
    xdotool getmouselocation | sed 's/.*window://'
}

strict-focus() {
    local wid
    wid="$1"
    [[ "$wid" ]] || wid=$( get-mouse-window )
    xdotool windowfocus $wid
}

PROG="$( basename "$0" )"

while true; do
    (( $# == 1 )) || break
    
    ARG="$1"

    case "$ARG" in
        -h|--help)
            usage
            exit 0
            ;;
        workspace-move|work*)
            sleep .1
            strict-focus
            ;;
        move-scratchpad|move*)
            wid=$( get-focus-window )
            i3-msg move scratchpad
            [[ $(($wid)) -ne $(xdotool getmouselocation | sed 's/.*window://') ]] &&
                strict-focus
            ;;
        scratchpad-show|scra*)
            wid=$( get-focus-window )
            i3-msg scratchpad show
            mouse_wid=$( get-mouse-window )
            (( wid == mouse_wid )) || strict-focus $mouse_wid
            ;;
        *)
            break 2
    esac
    exit 0
done

echo "$PROG: bad argument '$ARG'" >&2
exit 1
