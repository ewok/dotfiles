;; Markdown
(local {: pack} (require :lib))

(pack :gpanders/vim-medieval
      {:ft :markdown
       :event [:BufReadPre :BufNewFile]
       :config #(set vim.g.medieval_langs
                     [:python :ruby :sh :console=bash :bash :perl :fish :bb])})
