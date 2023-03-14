  if test -z "$DISPLAY" -a (tty) = "/dev/tty1" -a -z "$TMUX"
    if command -vq -- startx
      startx
    end
  end
