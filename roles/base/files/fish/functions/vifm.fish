function vifm

    set -l dst (command vifm --choose-dir - $argv)
    if test -z "$dst"
        echo 'Directory picking cancelled/failed'
        return 1
    end

    cd "$dst"

end
