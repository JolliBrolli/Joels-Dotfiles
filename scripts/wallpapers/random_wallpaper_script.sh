#!/bin/zsh

WALL_DIR="$HOME/pictures/wallpapers"

# Get current wallpaper filename (not full path)
CURRENT=$(basename $(cat ~/.cache/swww/current 2>/dev/null))

# Pick a random folder
FOLDER=$(find "$WALL_DIR" -mindepth 1 -maxdepth 1 -type d | shuf -n 1)

# Pick a random image file in that folder, excluding the current wallpaper
FILE=$(find "$FOLDER" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) | grep -vF "$CURRENT" | shuf -n 1)

# Fallback: if all files were filtered out, just pick any image
if [[ -z "$FILE" ]]; then
    FILE=$(find "$FOLDER" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) | shuf -n 1)
fi

# Set the wallpaper with animation
if [[ -n "$FILE" ]]; then
    swww img "$FILE" \
      --transition-type grow \
      --transition-duration 3 \
      --transition-fps 120 \
      --transition-pos 0.99,0.99 
    echo "$FILE" > ~/.cache/swww/current
    echo "Wallpaper set: $FILE"

else
    echo "No wallpaper found to set!"
fi

