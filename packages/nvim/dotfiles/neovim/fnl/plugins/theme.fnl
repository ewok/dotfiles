(local {: pack : map!} (require :lib))
;
(map! :n :<leader>th (.. "<cmd>echo \"hi<\" . synIDattr(synID(line(\".\"),col(\".\"),1),\"name\")"
                         "'> trans<' . synIDattr(synID(line(\".\"),col(\".\"),0),\"name\")"
                         "\"> lo<\" . synIDattr(synIDtrans(synID(line(\".\"),col(\".\"),1)),\"name\")"
                         "\">\"<CR>") {:noremap true}
      "Toggle highlighting")

; [(pack :folke/tokyonight.nvim {:name :tokyonight :config #(vim.cmd.colorscheme :tokyonight)})]

(match conf.options.theme
  :tokyonight [(pack :folke/tokyonight.nvim
                     {:name :tokyonight
                      :config #(vim.cmd.colorscheme :tokyonight)})]
  :onedark [(pack :NTBBloodbath/doom-one.nvim
                  {:init #(do
                            (set vim.g.doom_one_cursor_coloring true)
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
                            (set vim.g.doom_one_plugin_lspsaga false)
                            (vim.api.nvim_create_autocmd [:ColorScheme]
                                                         {:pattern "*"
                                                          :command (string.format "highlight Conceal guifg=%s"
                                                                                  conf.colors.base0E)})
                            (vim.api.nvim_create_autocmd [:ColorScheme]
                                                         {:pattern "*"
                                                          :command (string.format "highlight NormalFloat guibg=%s"
                                                                                  conf.colors.base00)})
                            (vim.api.nvim_create_autocmd [:ColorScheme]
                                                         {:pattern "*"
                                                          :command (string.format "highlight FloatBorder guifg=%s guibg=#%s"
                                                                                  conf.colors.base0D
                                                                                  conf.colors.base00)}))
                   :config #(vim.cmd.colorscheme :doom-one)})]
  _ [])
