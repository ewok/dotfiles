(local {: map!} (require :lib))

(fn on_attach [bufnr] ; map( ;     "n", ;     "<leader>gtl", ;     "<cmd>Gitsigns toggle_current_line_blame<cr>", ;     { silent = true }, ;     "Toggle current line blame" ; )
  (map! [:n] :<leader>gtl "<cmd>Gitsigns toggle_current_line_blame<cr>"
        {:silent true} "Toggle current line blame") ; map( ;     "n", ;     "<leader>ghp", ;     "<cmd>lua require'gitsigns'.preview_hunk()<cr>", ;     { silent = true }, ;     "Preview current hunk" ; )
  (map! [:n] :<leader>ghp "<cmd>lua require'gitsigns'.preview_hunk()<cr>"
        {:silent true} "Preview current hunk") ; map( ;     "n", ;     "<leader>ghP", ;     "<cmd>lua require'gitsigns'.blame_line{full=true}<cr>", ;     { silent = true }, ;     "Show current block blame" ; )
  (map! [:n] :<leader>ghP
        "<cmd>lua require'gitsigns'.blame_line{full=true}<cr>" {:silent true}
        "Show current block blame") ; map("n", "<leader>ghd", "<cmd>Gitsigns diffthis<cr>", { silent = true }, "Open deff view")
  (map! [:n] :<leader>ghd "<cmd>Gitsigns diffthis<cr>" {:silent true}
        "Open deff view") ; map("n", "<leader>gtD", "<cmd>Gitsigns toggle_deleted<cr>", { silent = true }, "Show deleted lines")
  (map! [:n] :<leader>gtD "<cmd>Gitsigns toggle_deleted<cr>" {:silent true}
        "Show deleted lines") ; map("n", "<leader>ghr", "<cmd>Gitsigns reset_hunk<cr>", { silent = true }, "Reset current hunk")
  (map! [:n] :<leader>ghr "<cmd>Gitsigns reset_hunk<cr>" {:silent true}
        "Reset current hunk") ; map("v", "<leader>ghr", "<cmd>Gitsigns reset_hunk<cr>", { silent = true }, "Reset current hunk")
  (map! [:v] :<leader>ghr "<cmd>Gitsigns reset_hunk<cr>" {:silent true}
        "Reset current hunk") ; map("n", "<leader>ghR", "<cmd>Gitsigns reset_buffer<cr>", { silent = true }, "Reset current buffer")
  (map! [:n] :<leader>ghR "<cmd>Gitsigns reset_buffer<cr>" {:silent true}
        "Reset current buffer") ; map("n", "[g", function() ;     if vim.wo.diff then ;         return "[c" ;     end ;     vim.schedule(function() ;         gitsigns.prev_hunk() ;     end) ;     return "<Ignore>" ; end, { silent = true, expr = true }, "Jump to the prev hunk")
  (map! [:n] "[g" (fn []
                    (if (vim.wo.diff)
                        "[c"
                        (do
                          (vim.schedule #(gitsigns.prev_hunk))
                          :<Ignore>)))
        {:silent true :expr true} "Jump to the prev hunk") ; map("n", "]g", function() ;     if vim.wo.diff then ;         return "]c" ;     end ;     vim.schedule(function() ;         gitsigns.next_hunk() ;     end) ;     return "<Ignore>" ; end, { silent = true, expr = true }, "Jump to the next hunk")
  (map! [:n] "]g" (fn []
                    (if (vim.wo.diff)
                        "]c"
                        (do
                          (vim.schedule #(gitsigns.next_hunk))
                          :<Ignore>)))
        {:silent true :expr true} "Jump to the next hunk"))

(fn config []
  (let [gitsigns (require :gitsigns)]
    (gitsigns.setup {:signcolumn true
                     :numhl false
                     :linehl false
                     :word_diff false
                     : on_attach
                     :signs {:add {:hl :GitSignsAdd
                                   :text "+"
                                   :numhl :GitSignsAddNr
                                   :linehl :GitSignsAddLn}
                             :change {:hl :GitSignsChange
                                      :text "~"
                                      :numhl :GitSignsChangeNr
                                      :linehl :GitSignsChangeLn}
                             :delete {:hl :GitSignsDelete
                                      :text "-"
                                      :numhl :GitSignsDeleteNr
                                      :linehl :GitSignsDeleteLn}
                             :topdelete {:hl :GitSignsDelete
                                         :text "‾"
                                         :numhl :GitSignsDeleteNr
                                         :linehl :GitSignsDeleteLn}
                             :changedelete {:hl :GitSignsChange
                                            :text "_"
                                            :numhl :GitSignsChangeNr
                                            :linehl :GitSignsChangeLn}}
                     :current_line_blame_opts {:virt_text true
                                               :virt_text_pos :eol
                                               :delay 100
                                               :ignore_whitespace false}
                     :preview_config {:border (if conf.options.float_border
                                                  :rounded
                                                  :none)
                                      :style :minimal
                                      :relative :cursor
                                      :row 0
                                      :col 1}})))

{: config :event [:BufRead :BufNewFile]}
