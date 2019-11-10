#!/bin/zsh

VENV_PATH="${VENV_PATH:-$HOME/share/venv}"

if [ ! -d $VENV_PATH ]; then
    mkdir -p $VENV_PATH
fi


loadvenv() {
    source "$VENV_PATH/$1/bin/activate"
}

alias venv=loadvenv
alias v=loadvenv

_venv() {
  local -a commands

  all="$(ls $VENV_PATH | tr '\n' ':' | sed 's/:$//')"
  commands=("${(@s/:/)all}")

  if (( CURRENT == 2 )); then
    _describe -t commands 'commands' commands
  fi

  return 0
}

_venv

compdef _venv loadvenv
