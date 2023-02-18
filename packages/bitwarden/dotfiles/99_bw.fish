if status --is-interactive
  if command -vq -- bw
    if test -z $BW_SESSION
      set -Ux BW_SESSION (bw unlock --raw)
    end
  fish -c 'bw-reset' &
  end
end
