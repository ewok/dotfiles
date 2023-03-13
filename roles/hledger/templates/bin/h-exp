#!/usr/bin/env bash

h 2022 bal \
  ^exp not:tag:clopen \
  --pretty-tables \
  -X USD --sort -ATM

echo

h bal -ATM \
  ^exp not:tag:clopen \
  --pretty-tables \
  -X USD --sort \
  -b 2023-01 \
  -e "$(date +%Y-%m --date="next month")"
