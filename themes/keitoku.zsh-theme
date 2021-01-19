
csig='%F{215}'
cdir='%F{81}'
cmark='%F{243}'
chost='%F{75}'
chost='%F{111}'
cgbk='%F{225}'
cgit='%F{219}'

user='%n'
host='%m'
dir='%c'

sig=$csig$user

if [[ -z $TMUX ]] || [[ ! -z $VIM ]]; then
# show full path when not in tmux or in vim
	dir='%~'
fi

if [[ ! -z $SSH_CLIENT ]] && [[ -z $TMUX ]]; then
# show host if in SSH and not in tmux
	sig=$csig$user$cmark@$chost$host
fi

ZSH_THEME_GIT_PROMPT_PREFIX="${cgbk}[$cgit"
ZSH_THEME_GIT_PROMPT_SUFFIX="$cgbk]%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="*"
ZSH_THEME_GIT_PROMPT_CLEAN=""

PROMPT='$csig❄ $sig $cdir$dir: $(git_prompt_info)%{$reset_color%}♨  '
