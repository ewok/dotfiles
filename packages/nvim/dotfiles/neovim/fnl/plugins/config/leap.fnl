(local {: map!} (require :lib))

(fn config []
  (let [leap (require :leap)]
    ;; (map! :n :s #(leap.leap {}) {:silent true} "Leap Forward")
    ;; (map! [:n :x :o] :S
    ;;       #(leap.leap {:backward true :match_last_overlapping true})
    ;;       {:silent true} "Leap Backward")
    (map! [:x :o] :s
          #(leap.leap {:target_windows [(vim.fn.win_getid)]
                       :offset 1
                       :inclusive_op true
                       :match_last_overlapping true}) {:silent true}
          "Leap Forward")
    (map! [:n] :s #(leap.leap {:target_windows [(vim.fn.win_getid)]})
          {:silent true} "Leap Forward")))

{: opts : config}
