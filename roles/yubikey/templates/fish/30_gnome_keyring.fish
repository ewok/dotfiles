if status --is-interactive
  if command -vq -- gnome-keyring-daemon
  #   set -gx SSH_AUTH_SOCK (gnome-keyring-daemon| awk -F "=" '$1 == "SSH_AUTH_SOCK" { print $2 }')
    set -gx SSH_AUTH_SOCK {{ lookup('env', 'XDG_RUNTIME_DIR') }}/keyring/ssh
  end
end
