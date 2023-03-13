#!/usr/bin/env bash
FAN_SPEED="$(sensors | grep fan1 | awk '{ print $2}')"
if [ $FAN_SPEED -gt 0 ]
then
    echo '{"state":"Warning", "text": " '$FAN_SPEED'"}'
else
    echo '{"state":"Info", "text": "ﴛ"}'
fi
