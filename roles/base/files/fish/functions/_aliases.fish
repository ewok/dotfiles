
function tailf
    tail -f $argv
end

function exit
   sync
   sync
   sync
   clear
   builtin exit
end

function git
    LANGUAGE=en_US.UTF-8 command git $argv
end

# Probably should be tested
#if contains darwin $OSTYPE
#
#    # MacOs aliases
#    alias resetsound="ps aux | grep 'coreaudio[d]' | awk '{print \$2}' | xargs sudo kill"
#    alias resetdns='sudo killall -HUP mDNSResponder && sudo pkill dnsmasq && echo DNS cleared'
#    # alias gitk='open -a "SmartGit" --args ${PWD}/'
#    alias gitk='open -a SourceTree --args "${PWD}/"'
#
#    alias idea='open -a "IntelliJ IDEA CE" .'
#end

function k
    kubectl $argv
end

function kx
    kubectx $argv
end

function tf
    terraform $argv
end

function tg
    terragrunt $argv
end

function mem-proc
    smem -t -k -c pss -P $argv
end

function _aliases
 #   echo ".aliases loaded"
end
