# Portable environment configuration
# Sourced by login shells via .zprofile / .bash_profile, and by every zsh
# invocation via .zshenv. Guard against re-running on nested shells so PATH
# and similar vars don't accumulate duplicates.
[[ -n "$_DOTFILES_PROFILE_LOADED" ]] && return
_DOTFILES_PROFILE_LOADED=1

# User environment
export MANPATH="/usr/local/man:$MANPATH"
export PATH="$HOME/.local/bin:$PATH"

if (( $+commands[nvim] )) 2>/dev/null; then
    export EDITOR='nvim'
else
    export EDITOR='vim'
fi

export TERM=xterm-256color

# Load OS-specific environment
[[ -f ~/.profile.native ]] && . ~/.profile.native

# Load local environment overrides
[[ -f ~/.profile.local ]] && . ~/.profile.local
[[ -f "$HOME/.local/bin/env" ]] && . "$HOME/.local/bin/env"
