#!/bin/sh

speed=$(sensors | grep fan1 | awk '{print $2; exit}')

if [ "$speed" != "" ]; then
    speed_round=$(echo "$speed/1000" | bc -l | LANG=C xargs printf "%.1f\n")
    speed_round=$(echo "$speed_round*1000" | bc -l | LANG=C xargs printf "%.0f\n")
    if [ $speed_round -gt 0 ]; then
      echo "󰈐"
    else
      echo "󰠝"
    fi
else
   echo "󱑬"
fi
