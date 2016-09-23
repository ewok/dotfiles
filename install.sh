set -x

git clone https://github.com/tmux-plugins/tmux-resurrect $HOME/.tmux/resurrect
git clone git://github.com/robbyrussell/oh-my-zsh.git $HOME/.oh-my-zsh

ln -s ${PWD}/.tmux.conf $HOME/.tmux.conf
ln -s ${PWD}/.zshrc $HOME/.zshrc
ln -s ${PWD}/.vim $HOME/.vim

mkdir $HOME/.vim/bundle
git clone https://github.com/Shougo/neobundle.vim $HOME/.vim/bundle/neobundle
