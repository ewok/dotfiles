[[ -e ~/.profile ]] && emulate sh -c 'source ~/.profile'

## FZF
# https://github.com/junegunn/fzf
export FZF_COMPLETION_TRIGGER='*'
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Following automatically calls "startx" when you login:
[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx -- -keeptty -nolisten tcp > ~/.xorg.log 2>&1
