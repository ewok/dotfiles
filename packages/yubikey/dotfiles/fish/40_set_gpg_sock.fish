function set-gpg-sock
  set -gx SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
end
