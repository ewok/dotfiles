function ssh(){
    host=$1;
    unset PASSWORD
    unset PASSVAR
    eval $(awk "/#[Pp]assvar / && inhost { printf \"PASSVAR=%s\",\$2; exit 1 } /#[Pp]assword / && inhost { printf \"PASSWORD=%s\",\$2; } /^[Hh][oO][sS][tT] / && inhost { inhost=0; exit 1 } /^[Hh][oO][sS][tT] $host\$/ { inhost=1 }" ~/.ssh/config)
    if [[ -z "$PASSWORD" ]] && [[ -z "$PASSVAR" ]]; then
        /usr/bin/ssh $*
    else
       if [[ -n "$PASSVAR" ]]; then
          PASSWORD=$(TMP=${!PASSVAR-*};echo ${TMP##*-})
       fi
       $(command -v sshpass) -p"$PASSWORD" /usr/bin/ssh $*
    fi
}
