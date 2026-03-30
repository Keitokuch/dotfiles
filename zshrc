# Configuration file for interactive ZShell

# Oh-My-Zsh Options
export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="keitoku"

plugins=( git pip sudo mosh )

HYPHEN_INSENSITIVE="true"
COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"

source $ZSH/oh-my-zsh.sh

# Enable completion
autoload -U compinit && compinit -u

# Aliases
[[ -x "$(command -v nvim)" ]] && alias vi="nvim"
alias py="python3"
alias ra="ranger"
alias t="tmux"

# Load additional interactive configs
[[ -f ~/.zshrc.local ]] && . ~/.zshrc.local

# User Functions
function setproxy() {
    export http_proxy=$1
    export https_proxy=$http_proxy
}

function noproxy() {
    unset http_proxy https_proxy
}

function revsync() {
    rsync -av $3 $2
}

function spectrum_ls() {
  for code in {000..255}; do
    print -P -- "$code: %{$FG[$code]%}$ZSH_SPECTRUM_TEXT%{$reset_color%}"
  done
}

precmd() {
	if [ -n "$TMUX" ]; then
    	tmux refresh-client -S
	fi
}

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
