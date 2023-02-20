(local {: map!} (require :lib))

(fn init []
  ;; TODO: Check on this after Telescope is installed
  (map! [:n] :<leader>fd #((. (require :telescope) :extensions :todo-comments
                              :todo)) {:silent true}
        "Find todo tag in the current workspace"))

(local event [:BufRead :BufNewFile])

(local config
       {:keywords {:NOTE {:icon conf.icons.Note :color "#96CDFB"}
                   :TODO {:icon conf.icons.Todo :color "#B5E8E0"}
                   :PERF {:icon conf.icons.Pref :color "#F8BD96"}
                   :WARN {:icon conf.icons.Warn :color "#FAE3B0"}
                   :HACK {:icon conf.icons.Hack :color "#DDB6F2"}
                   :FIX {:icon conf.icons.Fixme
                         :color "#DDB6F2"
                         :alt [:FIXME :BUG :FIXIT :ISSUE]}}})

{: init : event : config}
