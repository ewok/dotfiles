# brew install zsh-autosuggestions

if [ -f  /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh ];then
    source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
elif [ -f /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ];then
    source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
fi
