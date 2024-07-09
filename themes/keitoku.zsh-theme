[[ -z $Z_USER_COLOR ]] && Z_USER_COLOR=215
[[ -z $Z_HOST_COLOR ]] && Z_HOST_COLOR=111

zprompt_cuser=%F{$Z_USER_COLOR}
zprompt_chost=%F{$Z_HOST_COLOR}
zprompt_cdir='%F{81}'
zprompt_cmark='%F{246}'
zprompt_cgbk='%F{225}'
zprompt_cgit='%F{219}'

zprompt_user='%n'
zprompt_host='%m'
zprompt_dir='%c'

zprompt_sig=$zprompt_cuser$zprompt_user

if [[ -z $TMUX ]] || [[ ! -z $VIM ]]; then
# show full path when not in tmux or in vim
	zprompt_dir='%~'
fi

if [[ -z $TMUX ]]; then
# show host if in SSH or not in tmux
	zprompt_sig=$zprompt_cuser$zprompt_user$zprompt_cmark@$zprompt_chost$zprompt_host
fi

ZSH_THEME_GIT_PROMPT_PREFIX="${zprompt_cgbk}[$zprompt_cgit"
ZSH_THEME_GIT_PROMPT_SUFFIX="$zprompt_cgbk]%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="*"
ZSH_THEME_GIT_PROMPT_CLEAN=""

PROMPT='$zprompt_cuser❄ $zprompt_sig $zprompt_cdir$zprompt_dir: $(git_prompt_info)%{$reset_color%}♨  '
