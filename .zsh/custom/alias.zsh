# Aliases block
alias tailf='tail -f'
alias exit='sync; sync; sync; clear; exit'
alias vi='/usr/local/bin/nvim'
alias vim='/usr/local/bin/nvim'

# MacOs aliases
alias resetsound="ps aux | grep 'coreaudio[d]' | awk '{print \$2}' | xargs sudo kill"
alias resetdns='sudo killall -HUP mDNSResponder && sudo pkill dnsmasq && echo DNS cleared'
# alias gitk='open -a "SmartGit" --args ${PWD}/'
alias gitk='open -a SourceTree --args "${PWD}/"'

# fzf
alias cdf="cd \$(dirname \"\$(fzf)\")"

# hub
alias git=hub
alias idea='open -a "IntelliJ IDEA CE" .'
