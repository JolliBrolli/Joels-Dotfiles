#!/bin/zsh
TERMINAL=$(tail -n 1 ~/.local/bin/terminal.sh)
$TERMINAL --class dotfiles-floating -e nmtui
