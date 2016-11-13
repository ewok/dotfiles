#!/bin/zsh

loadvenv() {
    source ~/share/venv_$1/bin/activate
}

alias venv=loadvenv

_venv() {
  local -a commands

  all="$(ls ~/share | grep venv | sed "s/venv_\(.*\)/\1/" | tr '\n' ':' | sed "s/:$//")"
  commands=("${(@s/:/)all}")

  if (( CURRENT == 2 )); then
    _describe -t commands 'commands' commands
  fi

  return 0
}

_venv

compdef _venv loadvenv
