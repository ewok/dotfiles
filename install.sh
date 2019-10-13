#!/bin/bash

set -xe

if [[ -d $HOME/.tmux/resurrect ]]; then rm -rf $HOME/.tmux/resurrect;fi

git clone --depth 1 https://github.com/tmux-plugins/tmux-resurrect $HOME/.tmux/resurrect

if [ -d $HOME/.oh-my-zsh ]; then rm -rf $HOME/.oh-my-zsh;fi

git clone --depth 1 git://github.com/robbyrussell/oh-my-zsh.git $HOME/.oh-my-zsh

function update()
{
    if [ -f $2 ]
    then
        rm -f $2
    elif [ -d $2 ]
    then
        rm -rf $2
    elif [ -h $2 ]
    then
        rm -f $2
    fi

    ln -s $1 $2 || echo "Error"
}

update ${PWD}/.tmux.conf $HOME/.tmux.conf
update ${PWD}/.zshrc $HOME/.zshrc
update ${PWD}/.vim $HOME/.vim
mkdir -p $HOME/.config
update ${PWD}/.vim $HOME/.config/nvim
update ${PWD}/.zsh $HOME/.zsh
update ${PWD}/.ideavimrc $HOME/.ideavimrc
update ${PWD}/muttrc $HOME/.muttrc
update ${PWD}/mutt $HOME/.mutt
update ${PWD}/.vifm $HOME/.vifm
update ${PWD}/.i3 $HOME/.i3
update ${PWD}/.ctags $HOME/.ctags
update ${PWD}/.i3status.conf $HOME/.i3status.conf
#update ${PWD}/sxhkd $HOME/.config/sxhkd
#update ${PWD}/bspwm $HOME/.config/bspwm
# update ${PWD}/.xinitrc $HOME/.xinitrc
update ${PWD}/.xprofile $HOME/.xprofile
update ${PWD}/.Xresources $HOME/.Xresources
update ${PWD}/.zprofile $HOME/.zprofile
update ${PWD}/.profile $HOME/.profile
update ${PWD}/.skhdrc $HOME/.skhdrc
update ${PWD}/.yabairc $HOME/.yabairc
# update ${PWD}/polybar $HOME/.config/polybar
update ${PWD}/bin $HOME/bin
update ${PWD}/albert/modules $HOME/.local/share/albert/org.albert.extension.python/modules
update ${PWD}/albert/albert.conf $HOME/.config/albert/albert.conf


# FZF
if [ -d $HOME/.fzf ]; then rm -rf $HOME/.fzf;fi

git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
$HOME/.fzf/install --no-bash --no-fish --no-update-rc --key-bindings --completion


# VIM
if [ -d $HOME/share/venv/neovim2 ]; then rm -rf $HOME/share/venv/neovim2;fi
mkdir -p ~/share/venv/neovim2
virtualenv -p python2 ~/share/venv/neovim2
source ~/share/venv/neovim2/bin/activate
pip install neovim
deactivate

if [ -d $HOME/share/venv/neovim3 ]; then rm -rf $HOME/share/venv/neovim3;fi
mkdir -p ~/share/venv/neovim3
virtualenv -p python3 ~/share/venv/neovim3
source ~/share/venv/neovim3/bin/activate
pip install neovim
deactivate

nvim +PlugInstall +qall
