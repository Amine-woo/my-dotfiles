#!/bin/bash
day=$(date +%-d)
case $day in
  1|21|31) suffix="st" ;;
  2|22)    suffix="nd" ;;
  3|23)    suffix="rd" ;;
  11|12|13) suffix="th" ;;
  *)       suffix="th" ;;
esac
formatted="$(date "+%A, ${day}${suffix} %B %Y")"
echo "{\"text\": \" $(date +%H:%M:%S) \", \"tooltip\": \"$formatted\"}"
