(local {: pack} (require :lib))

[(pack :lewis6991/gitsigns.nvim (require :plugins.config.gitsigns))
 (pack :tpope/vim-rhubarb {:config false})
 (pack :shumphrey/fugitive-gitlab.vim {:config false})
 (pack :tpope/vim-fugitive (require :plugins.config.fugitive))]
