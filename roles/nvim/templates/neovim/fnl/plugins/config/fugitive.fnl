(local {: map!} (require :lib))

(fn config []
  (let [md {:noremap true :silent true}]
    (map! [:n] :<leader>gb "<cmd>Git blame<CR>" md "Git Blame")
    (map! [:n] :<leader>gd :<cmd>Gdiffsplit<CR> md "Git Diff")
    (map! [:n] :<leader>gx "<cmd>.GBrowse %<CR>" md "Git Browse")
    (map! [:n] :<leader>gl.
          #(vim.cmd "exe \":G log -U1 -L \" . string(getpos('.')[1]) . \",+1:%\"")
          md "History Line")
    (map! [:n] :<leader>gfm "<cmd>Git pull<CR>" md "Git Merge")
    (map! [:n] :<leader>gfr "<cmd>Git pull --rebase<CR>" md "Git Rebase")
    (map! [:n] :<leader>gps "<cmd>Git push<CR>" md "Git Push")
    (map! [:n] :<leader>gpf "<cmd>Git push --force-with-lease<CR>" md
          "Push(force with lease)")
    (map! [:n] :<leader>gpF "<cmd>Git push --force<CR>" md "Push(force)")
    (map! [:n] :<leader>gR :<cmd>Gread<CR> md "Git Reset")
    (map! [:n] :<leader>gS :<cmd>Git<CR> md "Git Status")
    (map! [:n] :<leader>gW :<cmd>Gwrite<CR> md "Git Write")
    (map! [:x] :<leader>gx ":'<,'>GBrowse %<CR>" md "Git Browse")
    (map! [:x] :<leader>glv
          #(vim.cmd "exe \":G log -L \" . string(getpos(\"'<'\")[1]) . \",\" . string(getpos(\"'>'\")[1]) . \":%\"")
          md "History Visual Block")))

{: config}
