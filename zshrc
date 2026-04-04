# Configuration file for interactive ZShell
zmodload zsh/zprof

# p10k instant prompt — must be at the very top
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Completion (cached — only regenerates once per day)
# Use local tmp for zcompdump to avoid sshfs stat overhead
autoload -Uz compinit
_zcompdump="${TMPDIR:-/tmp}/.zcompdump-${ZSH_VERSION}"
if [[ -f "$_zcompdump" && $(date +'%j') == $(date -r "$_zcompdump" +'%j' 2>/dev/null) ]]; then
    compinit -C -d "$_zcompdump"
else
    compinit -d "$_zcompdump"
fi
unset _zcompdump

# History
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt share_history hist_ignore_dups hist_ignore_space

# Misc options (carried over from oh-my-zsh defaults we relied on)
setopt auto_cd interactive_comments

# sudo plugin replacement: press ESC ESC to prepend sudo
sudo-command-line() {
    [[ -z $BUFFER ]] && zle up-history
    if [[ $BUFFER == sudo\ * ]]; then
        LBUFFER="${LBUFFER#sudo }"
    else
        LBUFFER="sudo $LBUFFER"
    fi
}
zle -N sudo-command-line
bindkey '\e\e' sudo-command-line

# Emacs keybindings (previously set by oh-my-zsh)
bindkey -e
# Terminal-specific keys
bindkey '^[[H'    beginning-of-line       # Home
bindkey '^[[F'    end-of-line             # End
bindkey '^[[3~'   delete-char             # Delete
bindkey '^[[1;5C' forward-word            # Ctrl+Right
bindkey '^[[1;5D' backward-word           # Ctrl+Left

# Colored ls
if [[ "$OSTYPE" == darwin* ]]; then
    alias ls='ls -G'
    export LSCOLORS='Gxfxcxdxbxegedabagacad'
else
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias diff='diff --color=auto'
    eval "$(dircolors -b 2>/dev/null)"
fi

# Aliases
(( $+commands[nvim] )) && alias vi="nvim"
alias gst='git status'
alias ga='git add'
alias gcm='git commit -m'
alias glg='git log --stat'
alias gd='git diff'
alias gau='git add --update'
alias glgg='git log --oneline --decorate --graph'
alias py="python3"
alias ra="ranger"
alias t="tmux"

# Load OS-specific and local interactive configs
[[ -f ~/.zshrc.native ]] && . ~/.zshrc.native
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

# Refresh tmux status bar only when directory changes
autoload -U add-zsh-hook
typeset -g _tmux_last_pwd="$PWD"
_tmux_precmd() {
    if [[ -n "$TMUX" && "$PWD" != "$_tmux_last_pwd" ]]; then
        _tmux_last_pwd="$PWD"
        tmux refresh-client -S
    fi
}
add-zsh-hook precmd _tmux_precmd

# Powerlevel10k — prefer local path to avoid sshfs overhead
_p10k_dir="${P10K_DIR:-/usr/local/share/powerlevel10k}"
[[ -d "$_p10k_dir" ]] || _p10k_dir="${HOME}/.p10k"
source "${_p10k_dir}/powerlevel10k.zsh-theme" 2>/dev/null
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh
unset _p10k_dir
