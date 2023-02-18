#!/usr/bin/env bash

if [ "$1" == "2022" ]
then
  hledger -f ~/share/Fin/2022.journal -s ${@:2}
else
  hledger -f ~/share/Fin/current.journal -s $@
fi
