# Modified version
function tf_prompt_info_patched() {
    # dont show 'default' workspace in home dir
    [[ "$PWD" == ~ ]] && return
    # check if in terraform dir
    if [ -d .terraform ]; then
      workspace=$(terraform workspace show 2> /dev/null) || return
      echo "%{$reset_color%}(%{$fg[blue]%}tf%{$reset_color%}:%{$fg_bold[magenta]%}${workspace}%{$reset_color%}) "
    fi
}
