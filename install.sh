set -x

git clone https://github.com/tmux-plugins/tmux-resurrect $HOME/.tmux/resurrect
git clone git://github.com/robbyrussell/oh-my-zsh.git $HOME/.oh-my-zsh

ln -s ${PWD}/.tmux.conf $HOME/.tmux.conf
ln -s ${PWD}/.zshrc $HOME/.zshrc
ln -s ${PWD}/.vim $HOME/.vim
mkdir -p $HOME/.config
ln -s ${PWD}/.vim $HOME/.config/nvim
ln -s ${PWD}/.zsh $HOME/.zsh
ln -s ${PWD}/.ideavimrc $HOME/.ideavimrc
ln -s ${PWD}/muttrc $HOME/.muttrc
ln -s ${PWD}/mutt $HOME/.mutt
ln -s ${PWD}/.vifm $HOME/.vifm
ls -s ${PWD}/.i3 $HOME/.i3
ln -s ${PWD}/.ctags $HOME/.ctags
ln -s ${PWD}/.i3status.conf $HOME/.i3status.conf
