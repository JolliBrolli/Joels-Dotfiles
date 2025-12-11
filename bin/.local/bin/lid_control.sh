#!/usr/bin/env bash
# Check for external monitor (e.g., DP-1 or HDMI-A-1)
if hyprctl monitors | grep -q "DP-1"; then # Adjust "DP-1" to your external monitor name
    if [ "$1" == "close" ]; then
        hyprctl keyword monitor eDP-1, disable
    elif [ "$1" == "open" ]; then
        hyprctl keyword monitor eDP-1, enable
    fi
else
    # If no external monitor, let Hyprland handle the lid switch normally (or do nothing)
    # echo "No external monitor detected."
    : # Do nothing
fi
