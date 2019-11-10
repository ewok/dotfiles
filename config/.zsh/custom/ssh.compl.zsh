h=()
if [[ -r ~/.ssh/config ]]; then
  h=($h ${${${(@M)${(f)"$(cat ~/.ssh/config)"}:#Host *}#Host }:#*[*?]*})
fi

if [[ -r ~/.ssh/known_hosts ]]; then
  h=($h ${${${(f)"$(cat ~/.ssh/known_hosts{,2} || true)"}%%\ *}%%,*}) 2>/dev/null
fi

if [[ -r ~/.ssh/cached_hosts ]]; then
  h=($h ${${${(f)"$(cat ~/.ssh/cached_hosts || true)"}%%\ *}%%,*}) 2>/dev/null
fi

if [[ $#h -gt 0 ]]; then
  zstyle ':completion:*:ssh:*' hosts $h
  zstyle ':completion:*:scp:*' hosts $h
  zstyle ':completion:*:assh:*' hosts $h
  zstyle ':completion:*:telnet:*' hosts $h
  zstyle ':completion:*:mosh:*' hosts $h
  zstyle ':completion:*:slogin:*' hosts $h
  zstyle ':completion:*:ping:*' hosts $h
fi

# SSH completion
compdef assh=ssh
compdef mosh=ssh
compdef telnet=ssh
