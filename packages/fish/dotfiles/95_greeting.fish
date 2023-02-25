function fish_greeting

  if ! test -z "$TMUX"
    if test -t 2
        systemctl --state=failed --no-legend --no-pager >&2
        systemctl --user --state=failed --no-legend --no-pager >&2
        # if command -vq -- t
        #   t ls
        # end
    end
  end

  if command -vq -- tmux

    if test -n "$INSIDE_EMACS"
      set TMUX_CMD tmux -L emacs
    else
      set TMUX_CMD "tmux"
    end

    if test -z "$TMUX"

      set -l SESS ($TMUX_CMD list-sessions | grep -v attached | cut -d: -f1 | head -n 1)
      echo $SESS
      if test -n "$SESS"
        if $TMUX_CMD attach -t $SESS
          exit
        end
      else
        if $TMUX_CMD new
          exit
        end
      end
    end
  end
end
