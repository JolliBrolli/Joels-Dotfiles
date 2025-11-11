#!/bin/zsh
TERMINAL=$(tail -n 1 ~/.local/bin/terminal.sh)
$TERMINAL --class=com.dotfiles-floating -e nmtui
