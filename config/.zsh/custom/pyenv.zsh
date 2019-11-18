if [[ ! -o interactive ]]; then
    return
fi

FOUND_PYENV=$+commands[pyenv]

if [[ $FOUND_PYENV -ne 1 ]]; then
    pyenvdirs=("$HOME/.pyenv" "/usr/local/pyenv" "/opt/pyenv" "/usr/local/opt/pyenv")
    for dir in $pyenvdirs; do
        if [[ -d $dir/bin ]]; then
            FOUND_PYENV=1
            break
        fi
    done
fi

if [[ $FOUND_PYENV -eq 1 ]]; then
  compctl -K _pyenv pyenv

  _pyenv() {
    local words completions
    read -cA words

    if [ "${#words}" -eq 2 ]; then
      completions="$(pyenv commands)"
    else
      completions="$(pyenv completions ${words[2,-2]})"
    fi

    reply=(${(ps:\n:)completions})
  }
fi
