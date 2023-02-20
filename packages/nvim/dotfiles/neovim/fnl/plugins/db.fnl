(local {: pack} (require :lib))

[(pack :tpope/vim-dadbod {:config false})
 (pack :kristijanhusak/vim-dadbod-ui (require :plugins.config.vim-dadbod-ui))]
