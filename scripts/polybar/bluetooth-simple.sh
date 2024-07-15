#!/bin/sh

# Show some output when it is
if bluetoothctl show | grep -q "Powered: no"; 
then
    echo '󰂲'
else if bluetoothctl info | grep -q "Connected: yes";
then
    echo '󰂱'
else;
    echo '󰂯'
fi

