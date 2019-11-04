#!/bin/bash

set -xe

if [ $(which pacman) ];then
    echo "Arch based system is detected."
    sudo pacman -S yay --needed

    # Packages part
    source install_packages.sh
    # Linters
    source install_linters.sh
fi

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

mkdir -p $HOME/.config
update ${PWD}/.tmux.conf $HOME/.tmux.conf
update ${PWD}/.zshrc $HOME/.zshrc
update ${PWD}/.vim $HOME/.vim
update ${PWD}/.vim $HOME/.config/nvim
update ${PWD}/.zsh $HOME/.zsh
update ${PWD}/.ideavimrc $HOME/.ideavimrc
update ${PWD}/.vifm $HOME/.vifm
update ${PWD}/.vifm $HOME/.config/vifm
update ${PWD}/.i3 $HOME/.i3
update ${PWD}/.ctags $HOME/.ctags
update ${PWD}/.i3status.conf $HOME/.i3status.conf
update ${PWD}/.xprofile $HOME/.xprofile
update ${PWD}/.Xresources $HOME/.Xresources
update ${PWD}/.zprofile $HOME/.zprofile
update ${PWD}/.profile $HOME/.profile
update ${PWD}/.skhdrc $HOME/.skhdrc
update ${PWD}/.yabairc $HOME/.yabairc
update ${PWD}/.mbsyncrc $HOME/.mbsyncrc
update ${PWD}/.msmtp $HOME/.msmtp
update ${PWD}/bin $HOME/bin
update ${PWD}/albert/modules $HOME/.local/share/albert/org.albert.extension.python/modules
update ${PWD}/albert/albert.conf $HOME/.config/albert/albert.conf

# MUTT
update ${PWD}/muttrc $HOME/.muttrc
update ${PWD}/mutt $HOME/.mutt
touch $HOME/.mutt/aliases

# FZF
if [ -d $HOME/.fzf ]; then rm -rf $HOME/.fzf;fi

git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
$HOME/.fzf/install --no-bash --no-fish --no-update-rc --key-bindings --completion

# TMUX
if [[ -d $HOME/.tmux/resurrect ]]; then rm -rf $HOME/.tmux/resurrect;fi

git clone --depth 1 https://github.com/tmux-plugins/tmux-resurrect $HOME/.tmux/resurrect

# ZSH
if [ -d $HOME/.oh-my-zsh ]; then rm -rf $HOME/.oh-my-zsh;fi

git clone --depth 1 git://github.com/robbyrussell/oh-my-zsh.git $HOME/.oh-my-zsh

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
