(local {: pack : map!} (require :lib))

(fn config []
  (map! [:n] :<Up> ":call vm#commands#add_cursor_up(0, v:count1)<cr>"
        {:silent true} "Create cursor down")
  (map! [:n] :<Down> ":call vm#commands#add_cursor_down(0, v:count1)<cr>"
        {:silent true} "Create cursor up")
  (set vim.g.VM_Extend_hl :DiffAdd)
  (set vim.g.VM_Cursor_hl :Visual)
  (set vim.g.VM_Mono_hl :DiffText)
  (set vim.g.VM_Insert_hl :DiffChange)
  (set vim.g.VM_default_mappings 0)
  (set vim.g.VM_maps {"Find Under" :<c-n>
                      "Find Prev" :<c-p>
                      "Skip Region" :<c-s>
                      "Remove Region" :<c-d>}))

(pack :mg979/vim-visual-multi {: config :event [:BufReadPre :BufNewFile]})
