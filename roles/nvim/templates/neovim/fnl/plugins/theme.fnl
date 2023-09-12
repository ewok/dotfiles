(local {: pack : map!} (require :lib))

(match conf.options.theme
  :dracula
  [(pack :Mofiqul/dracula.nvim {:config #(vim.cmd.colorscheme :dracula)})]
  :nord [(pack :shaunsingh/nord.nvim
               {:config #(do
                           (set vim.g.nord_borders true)
                           (vim.cmd.colorscheme :nord))})]
  :tokyonight [(pack :folke/tokyonight.nvim
                     {:name :tokyonight
                      :config #(do
                                 (let [theme (require :tokyonight)
                                       util (require :tokyonight.util)]
                                   (theme.setup {:on_colors (fn [colors]
                                                              (tset colors
                                                                    :border
                                                                    (util.darken colors.magenta
                                                                                 0.4)))}))
                                 (vim.cmd.colorscheme :tokyonight))})]
  :onenord
  [(pack :rmehri01/onenord.nvim {:config #(vim.cmd.colorscheme :onenord)})]
  :onedark [(pack :navarasu/onedark.nvim
                  {:priority 1000
                   :config #(let [onedark (require :onedark)]
                              (onedark.setup {:highlights {:Visual {:bg :$cyan
                                                                    :fg :$bg0
                                                                    :fmt :bold}
                                                           :FloatBorder {:fg :$cyan}
                                                           :MatchParen {:fg :$red
                                                                        :bg :$bg0
                                                                        :fmt :bold}}
                                              :style :dark
                                              :toggle_style_key :<leader>8
                                              :toggle_style_list [:darker
                                                                  :light
                                                                  :dark]
                                              :code_style {:comments :italic
                                                           :keywords :bold
                                                           :functions :bold
                                                           :strings :none
                                                           :variables :none}
                                              :diagnostics {:darker true
                                                            :undercurl true}})
                              (onedark.load))})
            ;; (pack :cormacrelf/dark-notify
            ;;       {:config #(let [dn (require :dark_notify)
            ;;                       onedark (require :onedark)]
            ;;                   (dn.run {:onchange (fn [mode]
            ;;                                        (onedark.setup {:style mode})
            ;;                                        (onedark.load))}))})
            ]
  :onedark-one [(pack :NTBBloodbath/doom-one.nvim
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
                                (set vim.g.doom_one_plugin_indent_blankline
                                     true)
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
