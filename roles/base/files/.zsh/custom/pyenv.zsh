if [[ ! -o interactive ]]; then
    return
fi

# Load pyenv only if command not already available
command -v pyenv &> /dev/null && FOUND_PYENV=1 || FOUND_PYENV=0

# Disable devault virtualenv prompt
export PYENV_VIRTUALENV_DISABLE_PROMPT=1
# FOUND_PYENV=$+commands[pyenv]

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

ZSH_THEME_PY_PROMPT_PREFIX="%{$fg[white]%}(%{$fg[blue]%}py%{$fg[white]%}:%{$reset_color%}"
ZSH_THEME_PY_PROMPT_SUFFIX="%{$fg[white]%})%{$reset_color%} "

if [[ $FOUND_PYENV -eq 1 ]]; then
    eval "$(pyenv init - zsh)"

    _pyenv_virtualenv_hook() {
      local ret=$?
      if [ -f .python-version ] ; then
        if [ -n "$VIRTUAL_ENV" ]; then
          eval "$(pyenv sh-deactivate --quiet || true)" || true
        fi
        eval "$(pyenv sh-activate --quiet || pyenv sh-deactivate --quiet || true)" || true
      else
        if [ -n "$VIRTUAL_ENV" ]; then
          eval "$(pyenv sh-deactivate --quiet || pyenv sh-activate --quiet|| true)" || true
        fi
      fi
      return $ret
    };

    typeset -g -a precmd_functions
    if [[ -z $precmd_functions[(r)_pyenv_virtualenv_hook] ]]; then
      precmd_functions=(_pyenv_virtualenv_hook $precmd_functions);
    fi

    function pyenv_prompt_info() {
      py_version=$(pyenv version-name)
      if [ "$py_version" != "system" ]; then
        echo "${ZSH_THEME_PY_PROMPT_PREFIX}${py_version}${ZSH_THEME_PY_PROMPT_SUFFIX}"
      fi
    }
else
    # fallback to system python
    function pyenv_prompt_info() {
        echo "${ZSH_THEME_PY_PROMPT_PREFIX}sys:$(python -V 2>&1 | cut -f 2 -d ' ')${ZSH_THEME_PY_PROMPT_SUFFIX}"
    }
fi

unset FOUND_PYENV pyenvdirs dir

