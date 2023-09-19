(local {: pack : map!} (require :lib))

(fn on_attach [bufnr]
  (map! [:n] :<leader>gtl "<cmd>Gitsigns toggle_current_line_blame<cr>"
        {:silent true :buffer bufnr} "Toggle current line blame")
  (map! [:n] :<leader>ghp "<cmd>lua require'gitsigns'.preview_hunk()<cr>"
        {:silent true :buffer bufnr} "Preview current hunk")
  (map! [:n] :<leader>ghP
        "<cmd>lua require'gitsigns'.blame_line{full=true}<cr>"
        {:silent true :buffer bufnr} "Show current block blame")
  (map! [:n] :<leader>ghd "<cmd>Gitsigns diffthis<cr>"
        {:silent true :buffer bufnr} "Open deff view")
  (map! [:n] :<leader>gtD "<cmd>Gitsigns toggle_deleted<cr>"
        {:silent true :buffer bufnr} "Show deleted lines")
  (map! [:n] :<leader>ghr "<cmd>Gitsigns reset_hunk<cr>"
        {:silent true :buffer bufnr} "Reset current hunk")
  (map! [:v] :<leader>ghr "<cmd>Gitsigns reset_hunk<cr>"
        {:silent true :buffer bufnr} "Reset current hunk")
  (map! [:n] :<leader>ghR "<cmd>Gitsigns reset_buffer<cr>"
        {:silent true :buffer bufnr} "Reset current buffer")
  (map! [:n] "[g"
        (if vim.wo.diff "[c"
            "<cmd>lua vim.schedule(require'gitsigns'.prev_hunk)<cr>")
        {:silent true :buffer bufnr} "Jump to the prev hunk")
  (map! [:n] "]g"
        (if vim.wo.diff "]c"
            "<cmd>lua vim.schedule(require'gitsigns'.next_hunk)<cr>")
        {:silent true :buffer bufnr} "Jump to the next hunk"))

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

(pack :lewis6991/gitsigns.nvim {: config :event [:BufReadPre :BufNewFile]})
