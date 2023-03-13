  if test -z "$DISPLAY" -a (tty) = "/dev/tty1"
    if command -vq -- startx
      startx
    end
  end
