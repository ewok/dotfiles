(local {: reg-ft : map!} (require :lib))

(reg-ft :markdown #(do
                     (set vim.opt_local.expandtab true)
                     (set vim.opt_local.shiftwidth 4)
                     (set vim.opt_local.tabstop 4)
                     (set vim.opt_local.softtabstop 4)
                     (set vim.wo.foldlevel 2)
                     (set vim.wo.conceallevel 2)
                     (let [md {:noremap true :silent true :buffer true}]
                       (map! [:n] :<leader>cb :<cmd>EvalBlock<CR> md
                             "Run Block")
                       (map! [:n] :<CR> "<Cmd>lua vim.lsp.buf.definition()<CR>"
                             md "Open Link")
                       (map! [:v] :<CR>
                             ":'<,'>ZkNewFromTitleSelection { dir = vim.fn.expand('%:p:h') }<CR>"
                             md "Create Link")
                       (map! [:n] :<leader>wb :<Cmd>ZkBacklinks<CR>
                             {:silent true} :Backlinks)
                       (map! [:n] :<leader>wl :<Cmd>ZkLinks<CR> {:silent true}
                             :Links))))
