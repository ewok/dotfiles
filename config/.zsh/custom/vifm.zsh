vifm()
{
    local dst="$(vifmrun "$@" | awk -F: '/PATH:/{print $2}')"
    if [ -z "$dst" ]; then
        echo 'Directory picking cancelled/failed'
        return 1
    fi
    cd "$dst"
    echo "Ueberzug processes count: $(pgrep ueberzug | wc -l)"
    if [ -z "$(pgrep vifm)" ]; then
        rm -rf "/tmp/vifm_img";
        echo "Cache was cleaned."
    else
        echo "Skip cleaning cache(Other vifm is running)."
    fi
}
