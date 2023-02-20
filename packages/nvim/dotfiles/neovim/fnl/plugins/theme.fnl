(local {: pack} (require :lib))

[(pack :NTBBloodbath/doom-one.nvim
       {:init #(do
                 (set vim.g.doom_one_terminal_colors true)
                 (set vim.g.doom_one_italic_comments true)
                 (set vim.g.doom_one_enable_treesitter true)
                 (set vim.g.doom_one_plugin_neorg false)
                 (set vim.g.doom_one_plugin_barbar false)
                 (set vim.g.doom_one_plugin_telescope true)
                 (set vim.g.doom_one_plugin_neogit false)
                 (set vim.g.doom_one_plugin_nvim_tree true)
                 (set vim.g.doom_one_plugin_dashboard false)
                 (set vim.g.doom_one_plugin_startify false)
                 (set vim.g.doom_one_plugin_whichkey true)
                 (set vim.g.doom_one_plugin_indent_blankline true)
                 (set vim.g.doom_one_plugin_vim_illuminate true)
                 (set vim.g.doom_one_plugin_lspsaga false))
        :config #(vim.cmd.colorscheme :doom-one)})]
