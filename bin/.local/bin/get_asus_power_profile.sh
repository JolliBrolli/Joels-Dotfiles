#!/bin/env zsh

# Get the current profile name reliably
CURRENT_MODE=$(asusctl profile -p --profile-get | grep "Active profile is" | awk '{print $NF}')

# Define icons and tooltip based on the profile
ICON=""
TOOLTIP_TEXT=""
CLASS_NAME=""

case "$CURRENT_MODE" in
    "Quiet")
        ICON="󰤄" # Silent/Sleep icon
        TOOLTIP_TEXT="Power Profile: Quiet (Click to switch)"
        CLASS_NAME="quiet"
        ;;
    "Balanced")
        ICON="󱘆" # Balanced icon
        TOOLTIP_TEXT="Power Profile: Balanced (Click to switch)"
        CLASS_NAME="balanced"
        ;;
    "Performance")
        ICON="󱐋" # Rocket/Speed icon
        TOOLTIP_TEXT="Power Profile: Performance (Click to switch)"
        CLASS_NAME="performance"
        ;;
    *)
        ICON=""
        TOOLTIP_TEXT="Power Profile: Unknown"
        CLASS_NAME="unknown"
        ;;
esac

# Output the result as JSON for Waybar
# The 'text' goes into the 'format' placeholder {}
# The 'tooltip' is the text that appears when hovering
# The 'class' allows you to style the module based on the profile
printf '{"text": "%s", "tooltip": "%s", "class": "%s"}\n' "$ICON" "$CURRENT_MODE" "$TOOLTIP_TEXT" "$CLASS_NAME"
