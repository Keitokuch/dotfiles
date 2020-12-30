if [[ -z $TMUX ]] || [[ ! -z $VIM ]]; then
	PROMPT='%{$FG[215]%}❄ %m %{$FG[081]%}%~: $(git_prompt_info)%{$FG[047]%}%{$reset_color%}♨  '
else 
	PROMPT='%{$FG[215]%}❄ %m %{$FG[081]%}%c: $(git_prompt_info)%{$FG[047]%}%{$reset_color%}♨  '
fi

ZSH_THEME_GIT_PROMPT_PREFIX="%{$FG[225]%}[%{$FG[219]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="*%{$FG[254]%}]"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$FG[225]%}]"
