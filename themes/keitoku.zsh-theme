[[ -z $Z_USER_COLOR ]] && Z_USER_COLOR=215
[[ -z $Z_HOST_COLOR ]] && Z_HOST_COLOR=111

cuser=%F{$Z_USER_COLOR}
chost=%F{$Z_HOST_COLOR}
cdir='%F{81}'
cmark='%F{246}'
cgbk='%F{225}'
cgit='%F{219}'

user='%n'
host='%m'
dir='%c'

sig=$cuser$user

if [[ -z $TMUX ]] || [[ ! -z $VIM ]]; then
# show full path when not in tmux or in vim
	dir='%~'
fi

if [[ -z $TMUX ]]; then
# show host if in SSH or not in tmux
	sig=$cuser$user$cmark@$chost$host
fi

ZSH_THEME_GIT_PROMPT_PREFIX="${cgbk}[$cgit"
ZSH_THEME_GIT_PROMPT_SUFFIX="$cgbk]%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="*"
ZSH_THEME_GIT_PROMPT_CLEAN=""

PROMPT='$cuser❄ $sig $cdir$dir: $(git_prompt_info)%{$reset_color%}♨  '
