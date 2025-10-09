#!/bin/zsh
TERMINAL=$(tail -n 1 ~/.config/scripts/settings/terminal.sh)
$TERMINAL --class dotfiles-floating -e nmtui
