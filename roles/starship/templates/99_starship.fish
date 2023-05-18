if status --is-interactive
  if command -vq -- starship
    source (starship init fish --print-full-init | psub)
  end
end
