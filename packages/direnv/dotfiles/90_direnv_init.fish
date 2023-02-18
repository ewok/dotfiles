if status --is-interactive; or status --is-login
  if command -vq -- direnv
    direnv hook fish | source
  end
end
