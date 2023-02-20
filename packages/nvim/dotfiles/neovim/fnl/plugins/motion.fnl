(local {: pack} (require :lib))

[(pack :chaoren/vim-wordmotion {:config false})
 (pack :tpope/vim-repeat {:config false})
 (pack :mg979/vim-visual-multi (require :plugins.config.vim-visual-multi))
 (pack :aznhe21/hop.nvim (require :plugins.config.hop))]
