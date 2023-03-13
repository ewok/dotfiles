if test -z $HOSTNAME; and command -vq hostnamectl
  set -gx HOSTNAME (hostnamectl --transient 2>/dev/null)
end
if test -z $HOSTNAME; and command -vq hostname
  set -gx HOSTNAME (hostname 2>/dev/null)
end
if test -z $HOSTNAME
  set -gx HOSTNAME (uname -n)
end

# Cleanup before init
set -gx LANG en_US.UTF-8
# set -gx LC_ALL en_US.UTF-8
set -gx LANGUAGE en_US.UTF-8
set -gx LC_MEASUREMENT ru_RU.UTF-8
set -gx LC_MONETARY ru_RU.UTF-8
set -gx LC_NUMERIC ru_RU.UTF-8
set -gx LC_PAPER ru_RU.UTF-8
set -gx LC_TIME ru_RU.UTF-8

set -gx FZF_LEGACY_KEYBINDINGS 0
set -gx OPEN_CMD open

set -gx GTK_THEME Dracula
# set -gx XDG_CURRENT_DESKTOP sway

fish_add_path -ga  ~/.local/bin ~/bin ~/.bin
# fish_add_path --path -a  /usr/local/sbin /usr/sbin

# Use it only in nixshell for projects
# set -gx SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)

if status is-interactive

  bind \cw backward-kill-word
  bind \e\cB backward-bigword
  bind \e\cF forward-bigword
  bind \e\[109\;5u execute

  if command -vq -- viddy
    alias watch viddy
  end

  {% if ansible_lsb['id'] | lower == "pop" %}
    if command -vq -- exa
      alias ll "exa -la"
      alias ls "exa -a"
    end
  {% elif ansible_lsb['id'] | lower == "ubuntu" %}
    if command -vq -- exa
      alias ll "exa -la"
      alias ls "exa -a"
    end
  {%else%}
    if command -vq -- exa
      alias ll "exa -la --git"
      alias ls "exa -a --git"
    end
  {% endif %}

  if command -vq -- bat
    alias cat "bat"
  end

  # if test -z "$DISPLAY" -a (tty) = "/dev/tty1"
  #   if command -vq -- sway
  #     exec sway
  #   end
  # end

end

