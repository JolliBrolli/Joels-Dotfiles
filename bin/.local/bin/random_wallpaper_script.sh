#!/bin/zsh

# --- Configuration ---
WALL_DIR="$HOME/Pictures/Wallpapers"
CURRENT_CACHE="$HOME/.cache/swww/current"

# --- Get Current Wallpaper ---
# Get current wallpaper filename (not full path)
CURRENT=$(basename $(cat "$CURRENT_CACHE" 2>/dev/null))

# --- Find Random Wallpaper Recursively ---
# Find ALL image files recursively from WALL_DIR, exclude the current one, and pick a random one.
# Note: The -L option follows symlinks.
IMAGE_FILES=$(find -L "$WALL_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \))

# Exclude the current file
FILE=$(echo "$IMAGE_FILES" | grep -vF "$CURRENT" | shuf -n 1)

# Fallback: if all files were filtered out (meaning only one file exists), just pick any image
if [[ -z "$FILE" ]]; then
    FILE=$(echo "$IMAGE_FILES" | shuf -n 1)
fi

# --- Set Wallpaper ---
if [[ -n "$FILE" ]]; then
    # Set the wallpaper with animation
    swww img "$FILE" \
        --transition-type grow \
        --transition-duration 3 \
        --transition-fps 120 \
        --transition-pos 0.99,0.99 
    
    # Update the cache file
    echo "$FILE" > "$CURRENT_CACHE"
    
    echo "Wallpaper set: $FILE"

else
    echo "No wallpaper found to set in $WALL_DIR!"
fi
