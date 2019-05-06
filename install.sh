#!/bin/bash

set -xe

if [[ -d $HOME/.tmux/resurrect ]]; then rm -rf $HOME/.tmux/resurrect;fi

git clone https://github.com/tmux-plugins/tmux-resurrect $HOME/.tmux/resurrect

if [ -d $HOME/.oh-my-zsh ]; then rm -rf $HOME/.oh-my-zsh;fi

git clone git://github.com/robbyrussell/oh-my-zsh.git $HOME/.oh-my-zsh

if [ -d $HOME/bin ]; then rm -rf $HOME/bin;fi

git clone https://github.com/ewok/bin.git $HOME/bin

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
    else
        echo "Couldn't delete $2"
        exit 1
    fi

    ln -s $1 $2
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
