if status is-interactive

  bind \cw backward-kill-word
  bind \e\cB backward-bigword
  bind \e\cF forward-bigword
  bind \e\[109\;5u execute

  if command -vq -- viddy
    alias watch viddy
  end

    if command -vq -- exa
      alias ll "exa -la --git"
      alias ls "exa -a --git"
    end

  if command -vq -- bat
    alias cat "bat"
  end

  {% if ansible_distribution == "MacOSX" %}
  # TODO: Move it to some role
  alias assume="source /opt/homebrew/bin/assume.fish"
  # TODO: Move to some role
  export SSH_AUTH_SOCK="$(brew --prefix)/var/run/yubikey-agent.sock"
  {% endif %}

end
