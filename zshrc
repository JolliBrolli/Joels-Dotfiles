
# enable command completion
autoload -Uz compinit
compinit

# History settings
HISTSIZE=50000
SAVEHIST=50000
HISTFILE=/.zsh_history

# Nicer tab completion
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors ''

# Aliases
alias ll='ls -lh'
alias la='ls -lha'
alias ..='cd ..'
alias update='sudo pacman -Syu'

# Prompt
autoload -Uz promptinit
promptinit
prompt adam1

# Keybinding
bindkey -e
