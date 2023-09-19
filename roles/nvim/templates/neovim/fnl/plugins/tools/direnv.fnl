(local {: pack} (require :lib))

(if (= true conf.options.direnv)
    (pack :direnv/direnv.vim {:config false :event [:BufReadPre :BufNewFile]})
    [])
