#!/bin/zsh

loadvenv() {
    source ~/share/venv/$1/bin/activate
}

alias venv=loadvenv
alias v=loadvenv

_venv() {
  local -a commands

  all="$(ls ~/share/venv | tr '\n' ':' | sed "s/:$//")"
  commands=("${(@s/:/)all}")

  if (( CURRENT == 2 )); then
    _describe -t commands 'commands' commands
  fi

  return 0
}

_venv

compdef _venv loadvenv
