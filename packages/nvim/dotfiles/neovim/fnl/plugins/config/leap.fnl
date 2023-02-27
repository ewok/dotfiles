(local {: map!} (require :lib))

(fn config []
  (let [leap (require :leap)]
    ; (map! :n :sj #(leap.leap {}) {:silent true} "Leap Forward")
    ; (map! [:n :x :o] :sk
    ;       #(leap.leap {:backward true :match_last_overlapping true})
    ;       {:silent true} "Leap Backward")
    (map! [:x :o] :s
          #(leap.leap {:target_windows [(vim.fn.win_getid)]
                       :offset 1
                       :inclusive_op true
                       :match_last_overlapping true}) {:silent true}
          "Leap everywhere")
    (map! [:n] :s
          #(let [focusable_windows_on_tabpage (vim.tbl_filter (fn [winid]
                                                                (. (vim.api.nvim_win_get_config winid)
                                                                   :focusable))
                                                              (vim.api.nvim_tabpage_list_wins 0))]
             (leap.leap {:target_windows focusable_windows_on_tabpage}))
          {:silent true} "Leap Forward")))

{: config}
