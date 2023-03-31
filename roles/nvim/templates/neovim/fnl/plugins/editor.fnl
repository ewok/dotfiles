(local {: pack : map!} (require :lib))

[;;; Deal with tabs size
 (pack :tpope/vim-sleuth {:config false})
 ;;; Pretty fold
 (pack :anuvyklack/pretty-fold.nvim {:config true})
 ;;; Indent blankline
 (pack :lukas-reineke/indent-blankline.nvim
       (require :plugins.config.indent-blankline))
 ;;; Illuminate
 (pack :RRethy/vim-illuminate (require :plugins.config.vim-illuminate))
 ;; Colorizer
 (pack :norcalli/nvim-colorizer.lua
       {:config #(map! [:n] :<leader>tc :<cmd>ColorizerToggle<cr>
                       {:silent true} "Code Colorizer")})
 (pack :kosayoda/nvim-lightbulb (require :plugins.config.lightbulb))]
