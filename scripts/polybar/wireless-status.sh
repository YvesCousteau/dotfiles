#!/bin/bash

# Get the current network interface
INTERFACE=wlp0s20f3

# Get the current network status
CURRENT_STATUS=$(iwgetid $INTERFACE)

# Check if the network is connected
if [ -n "$CURRENT_STATUS" ]; then
  # Network is connected, display the network name
  echo "󰖩"
else
  # Network is not connected, display a message
  echo "󰖪"
fi
