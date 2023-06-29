(local {: pack} (require :lib))

[(pack :williamboman/mason-lspconfig.nvim {:config false})
 (pack :stevearc/aerial.nvim (require :plugins.config.aerial))
 (pack :neovim/nvim-lspconfig (require :plugins.config.nvim-lspconfig))
 (pack :j-hui/fidget.nvim {:opts {:window {:blend 0}
                                  :sources {:pyright {:ignore true}}
                                  :tag :legacy}})
 (pack :jose-elias-alvarez/null-ls.nvim (require :plugins.config.null-ls))]
