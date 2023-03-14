# if test -z "$DISPLAY" -a (tty) = "/dev/tty1"
if status --is-login
  abbr -e (abbr -l)

  set -e __my_git_plugin_initialized
  fisher update
end
