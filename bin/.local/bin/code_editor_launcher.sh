#!/usr/bin/env zsh
# OLD: exec nvim "$SELECTED_DIR"
# NEW: Use --cmd to change directory, then allow nvim to start normally.
FZF_COMMAND='SELECTED_DIR="$(fd -t d -H . | fzf)"; if [[ -n "$SELECTED_DIR" ]]; then exec nvim --cmd "cd $SELECTED_DIR" ; else exec zsh; fi'

ghostty --class=com.code.editor \
    -e zsh -c "$FZF_COMMAND"
