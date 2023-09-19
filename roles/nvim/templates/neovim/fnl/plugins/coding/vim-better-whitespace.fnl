(local {: pack : map!} (require :lib))

(pack :ntpeters/vim-better-whitespace
      {:event [:BufReadPre :BufNewFile]
       :init (fn []
               (set vim.g.better_whitespace_filetypes_blacklist conf.ui-ft)
               (set vim.g.better_whitespace_operator :<localleader>S)
               (map! [:n] :<leader>cw :<cmd>StripWhitespace<cr> {}
                     "Strip Whitespaces"))})
