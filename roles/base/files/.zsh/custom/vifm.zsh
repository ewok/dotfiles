vifm()
{
#   export FIFO_UEBERZUG="/tmp/vifm-ueberzug-${PPID}"

#   function cleanup {
#       rm "$FIFO_UEBERZUG" 2>/dev/null
#       pkill -P $$ 2>/dev/null
#   }

#   rm "$FIFO_UEBERZUG" 2>/dev/null
#   mkfifo "$FIFO_UEBERZUG"
#   trap cleanup EXIT
#   tail --follow "$FIFO_UEBERZUG" | ueberzug layer --silent --parser bash -l thread 2>/dev/null &

    dst="$(command vifm --choose-dir - "$@")"
    if [ -z "$dst" ]; then
        echo 'Directory picking cancelled/failed'
        return 1
    fi
    cd "$dst"

#   echo "Ueberzug processes count: $(pgrep ueberzug 2>/dev/null| wc -l)"

#   if [ -z "$(pgrep vifm)" ]; then
#       rm -rf "/tmp/vifm_img";
#       echo "Cache was cleaned."
#   else
#       echo "Skip cleaning cache(Other vifm is running)."
#   fi
}


