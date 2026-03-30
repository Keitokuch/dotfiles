# Portable environment configuration
# Sourced by login shells via .zprofile / .bash_profile

# User environment
export MANPATH="/usr/local/man:$MANPATH"

if [[ -x "$(command -v nvim)" ]]; then
    export EDITOR='nvim'
else
    export EDITOR='vim'
fi

export TERM=xterm-256color

# Load OS-specific environment
[[ -f ~/.profile.native ]] && . ~/.profile.native

# Load local environment overrides
[[ -f ~/.profile.local ]] && . ~/.profile.local

# Tool-managed environment
[[ -f ~/.jget_profile ]] && . ~/.jget_profile
[[ -f "$HOME/.local/bin/env" ]] && . "$HOME/.local/bin/env"
