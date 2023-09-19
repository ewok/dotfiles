(local {: pack : map!} (require :lib))

(fn on_attach [bufnr]
  (map! [:n] :<leader>2 "<cmd>AerialToggle! right<cr>"
        {:silent true :buffer bufnr} "Open Outilne Explorer")
  (map! [:n] "{" "<cmd>lua require(\"aerial\").prev()<cr>"
        {:silent true :buffer bufnr} "Move item up")
  (map! [:n] "}" "<cmd>lua require(\"aerial\").next()"
        {:silent true :buffer bufnr} "Move item down")
  (map! [:n] "[[" "<cmd>lua require(\"aerial\").prev_up()"
        {:silent true :buffer bufnr} "Move up one level")
  (map! [:n] "]]" "<cmd>lua require(\"aerial\").next_up()"
        {:silent true :buffer bufnr} "Move down one level"))

(fn config []
  (let [aerial (require :aerial)]
    (aerial.setup {:icons conf.icons
                   :layout {:min_width 40}
                   :show_guides true
                   :backends [:lsp :treesitter :markdown]
                   :update_events "TextChanged,InsertLeave"
                   : on_attach
                   :lsp {:diagnostics_trigger_update false
                         :update_when_errors true
                         :update_delay 300}
                   :guides {:mid_item "├─"
                            :last_item "└─"
                            :nested_top "│ "
                            :whitespace "  "}
                   :filter_kind [:Module
                                 :Struct
                                 :Interface
                                 :Class
                                 :Constructor
                                 :Enum
                                 :Function
                                 :Method]})))

(pack :stevearc/aerial.nvim {: config :event [:BufReadPre :BufNewFile]})
