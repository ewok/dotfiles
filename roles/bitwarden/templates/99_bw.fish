if status --is-interactive
  if command -vq -- bw
    if test -z $GL_BW_SESSION
      set -U GL_BW_SESSION (bw unlock --raw)
    end
    set -x BW_SESSION $GL_BW_SESSION
  fish -c 'bw-reset' &
  end
end
