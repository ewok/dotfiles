(local {: pack : map!} (require :lib))

(fn config []
  (let [hop (require :hop)
        {:HintDirection direction} (require :hop.hint)]
    (do
      (hop.setup {:keys :12345qwertyuiopasdfghjklzxcvbnm})
      (map! "" :f #(hop.hint_char1 {:direction direction.AFTER_CURSOR
                                    :current_line_only true
                                    :keys :12345})
            {:remap true} :f)
      (map! "" :F #(hop.hint_char1 {:direction direction.BEFORE_CURSOR
                                    :current_line_only true
                                    :keys :12345})
            {:remap true} :F)
      (map! "" :t #(hop.hint_char1 {:direction direction.AFTER_CURSOR
                                    :current_line_only true
                                    :hint_offset -1
                                    :keys :12345})
            {:remap true} :t)
      (map! "" :T #(hop.hint_char1 {:direction direction.BEFORE_CURSOR
                                    :current_line_only true
                                    :hint_offset 1
                                    :keys :12345})
            {:remap true} :T)
      (map! "" :s #(hop.hint_patterns {:multi_windows true}) {:remap true} :s))))

(if (= :hop conf.options.motion_plugin)
    (pack :aznhe21/hop.nvim
          {: config :branch :fix-some-bugs :event [:BufReadPre :BufNewFile]})
    [])
