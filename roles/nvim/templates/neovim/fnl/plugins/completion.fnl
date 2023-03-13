(local {: pack} (require :lib))

[(pack :hrsh7th/cmp-vsnip {:config false})
 (pack :hrsh7th/cmp-nvim-lsp {:config false})
 (pack :hrsh7th/cmp-buffer {:config false})
 (pack :hrsh7th/cmp-path {:config false})
 (pack :hrsh7th/cmp-cmdline {:config false})
 (pack :hrsh7th/cmp-calc {:config false})
 (pack :hrsh7th/cmp-emoji {:config false})
 (pack :PaterJason/cmp-conjure {:config false})
 (pack :kristijanhusak/vim-dadbod-completion {:config false})
 (pack :rafamadriz/friendly-snippets {:event [:InsertEnter :CmdlineEnter]})
 (pack :hrsh7th/vim-vsnip (require :plugins.config.vsnip))
 (pack :hrsh7th/nvim-cmp (require :plugins.config.cmp))]
