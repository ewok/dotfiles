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
end

