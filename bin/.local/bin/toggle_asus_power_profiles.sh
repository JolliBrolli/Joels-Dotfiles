#!/bin/env zsh

# Get the current profile name by filtering for the "Active profile is" line,
# then using awk to print only the last word (the profile name).
CURRENT_MODE=$(asusctl profile get | grep "Active profile: " | awk '{print $NF}')

# Define the cycle order: Quiet -> Balanced -> Performance -> Quiet
NEW_MODE=""
case "$CURRENT_MODE" in
    "Quiet")
        NEW_MODE="Balanced"
        ;;
    "Balanced")
        NEW_MODE="Performance"
        ;;
    "Performance")
        NEW_MODE="Quiet"
        ;;
    *)
        # Default to Quiet if the current mode is unknown or unset
        NEW_MODE="Quiet"
        echo "⚠️ Profiles Unknown or Unset (was: \"$CURRENT_MODE\"). Defaulting to $NEW_MODE."
        ;;
esac

echo "Current Mode: $CURRENT_MODE"
echo "Switching to: $NEW_MODE"

# Set the new profile
asusctl profile set "$NEW_MODE"
pkill -SIGRTMIN 2 waybar
