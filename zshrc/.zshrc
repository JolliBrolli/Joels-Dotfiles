
# Add user-specific executables to PATH (XDG standard)
[[ -d "$HOME/.local/bin" ]] && export PATH="$HOME/.local/bin:$PATH"

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
autoload -Uz compinit

# Set the custom path for Starship.toml
export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml" 

# Initialize Starship
eval "$(starship init zsh)"

# Aliases
alias ll='ls -lh'
alias la='ls -lha'
alias ..='cd ..'
alias vim='nvim'
alias cl='clear'
alias update='sudo pacman -Syu'

# Keybinding
bindkey -e

fastfetch
