(local {: pack} (require :lib))

(if (= :luasnip conf.options.snippets)
    [(pack :L3MON4D3/LuaSnip {:build "make install_jsregexp" :config true})
     (pack :saadparwaiz1/cmp_luasnip {:config false})
     (pack :rafamadriz/friendly-snippets
           {:event [:InsertEnter]
            :config #(let [from_vscode (require :luasnip.loaders.from_vscode)]
                       (from_vscode.lazy_load))})] [])
