#!/bin/zsh

# Source the Zsh config to load environment variables like FZF_ALT_C_COMMAND
source "$HOME/.zshrc"

# Define the command to find directories, falling back to FZF_ALT_C_COMMAND or a default
# This ensures it uses the 'fd' command you configured for FZF_ALT_C_COMMAND.
DIR_FINDER_COMMAND="${FZF_ALT_C_COMMAND:-'cd "$(fd -t d -H | fzf)"'}"

# Run the directory finder and capture the selected directory
SELECTED_DIR="$(eval $DIR_FINDER_COMMAND | fzf --ansi)"

# Check if a directory was selected (the variable is not empty)
if [[ -n "$SELECTED_DIR" ]]; then
    # Open a new Alacritty window, change directory (cd) to the selected path,
    # and then run zsh interactively in that directory.
    alacritty --class "directory-explorer" \
              --working-directory "$SELECTED_DIR" \
              -e /usr/bin/zsh
fi
