(local {: map!} (require :lib))

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
      (map! "" :ss #(hop.hint_words) {:remap true} :ss)
      (map! "" :sl
            #(hop.hint_words {:direction direction.AFTER_CURSOR
                              :current_line_only false})
            {:remap true} :sl)
      (map! "" :sh
            #(hop.hint_words {:direction direction.BEFORE_CURSOR
                              :current_line_only false})
            {:remap true} :sh)
      (map! "" :sj #(hop.hint_vertical {:direction direction.AFTER_CURSOR})
            {:remap true} :sj)
      (map! "" :sk #(hop.hint_vertical {:direction direction.BEFORE_CURSOR})
            {:remap true} :sk))))

{: config :branch :fix-some-bugs}
