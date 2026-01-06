# Add user-specific executables to PATH (XDG standard)
[[ -d "$HOME/.local/bin" ]] && export PATH="$HOME/.local/bin:$PATH"
# Add Cargo's binary directory to PATH
export PATH="$HOME/.cargo/bin:$PATH"
# enable command completion
autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# History settings
HISTSIZE=50000
SAVEHIST=50000
HISTFILE=/.zsh_history

        export EDITOR="nvim"
        export VISUAL="nvim"
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
alias vpn='nordvpn'
# Keybinding
bindkey -e
# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)
export FZF_DEFAULT_COMMAND='fd --type f --hidden \
  --exclude .git \
  --exclude .cache \
  --exclude node_modules \
  --exclude .local/share/Trash \
  --exclude timeshift \
  --exclude .snapshots \
  --exclude .log \
  --exclude .yarn/cache \
  --exclude target/ \
  --exclude build/'
# Optionally, use a more relaxed search for directories for alt-c (cd)
export FZF_ALT_C_COMMAND='fd --type d --hidden --exclude .git'
# Exclude common, unwanted directoru names
export FZF_DEFAULT_OPTS='--walker-skip=.git,node_modules,target,build,logs,timeshift,.cache,.snapshots'

function file_finder_script() {
    # 1. Define the fd command based on your FZF_DEFAULT_COMMAND variable
    local FD_COMMAND='fd --type f --hidden \
        --exclude .git \
        --exclude .cache \
        --exclude node_modules \
        --exclude .local/share/Trash \
        --exclude timeshift \
        --exclude .snapshots \
        --exclude .log \
        --exclude .yarn/cache \
        --exclude target/ \
        --exclude build/'

    # 2. Run fd, pipe output to fzf, and store the result (the selected file)
    # The 'eval' is used to correctly interpret the command string from the variable.
    local selected_file
    selected_file="$(eval $FD_COMMAND | fzf \
        --preview 'bat --color always {}' \
        --bind 'focus:transform-header:file --brief {}' \
        --ansi)"

    # 3. Check if a file was actually selected (the variable is not empty)
    if [[ -n "$selected_file" ]]; then
        # If a file was selected, open Neovim
        nvim "$selected_file"
    fi
	
    # 4. Clean up and redraw the Zsh prompt after the action
    zle reset-prompt
    zle redisplay
}

zle -N file_finder_script
bindkey '^F' file_finder_script

# Run fastfetch only on the first terminal instance in a session.
# This check prevents it from running in new splits/tabs that inherit
# the environment variable.
if [[ -z "$ZSH_INITIAL_RUN" ]]; then
    export ZSH_INITIAL_RUN="true"
    fastfetch
fi
