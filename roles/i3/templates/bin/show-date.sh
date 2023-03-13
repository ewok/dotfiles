#!/usr/bin/env bash
DATE=$(date +"📆 %Y-%m-%d")
UTC=$(date -u +"🌐 %R")
MSK=$(TZ='Europe/Moscow' date +"🇷🇺 %R")
# PHT=$(TZ='Asia/Manila' date +"🇵🇭 %R")
KG=$(TZ='Asia/Bishkek' date +"🇰🇬 %R")
echo "$DATE $UTC $MSK $KG"
