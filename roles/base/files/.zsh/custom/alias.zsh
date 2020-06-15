# Aliases block
alias tailf='tail -f'
alias exit='sync; sync; sync; clear; exit'

# Neovim
NVIM=$(which nvim)
VIM=$(which vim)
alias vi="$VIM"

# fzf
alias cdf="cd \$(dirname \"\$(fzf)\")"

# GIT
alias git='LANGUAGE=en_US.UTF-8 git'

# Idea
if [[ "$OSTYPE" == "darwin"* ]]; then

    # MacOs aliases
    alias resetsound="ps aux | grep 'coreaudio[d]' | awk '{print \$2}' | xargs sudo kill"
    alias resetdns='sudo killall -HUP mDNSResponder && sudo pkill dnsmasq && echo DNS cleared'
    # alias gitk='open -a "SmartGit" --args ${PWD}/'
    alias gitk='open -a SourceTree --args "${PWD}/"'

    alias idea='open -a "IntelliJ IDEA CE" .'
fi

#k8s
alias k='kubectl'
alias kx='kubectx'

alias tf=terraform
alias tg=terragrunt
alias mem-proc='smem -t -k -c pss -P'
