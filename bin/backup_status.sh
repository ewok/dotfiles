#!/bin/bash

function last_backup()
{
    ls /mnt/backup/timeshift/snapshots | tail -n 1 
}

# shell script to prepend i3status with more stuff
i3status | while :
do
  read line
  echo "Last backup: $(last_backup) | $line" || exit 1
done

# ls /mnt/backup/timeshift/snapshots
