git clone https://github.com/tmux-plugins/tmux-resurrect ~/.tmux/resurrect
git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh

ln -s .tmux.con ~/.tmux.conf
ln -s .zshrc ~/.zshrc

ls -s .vim ~/.vim
mkdir ~/.vim/bundle
git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle
