(local {: pack} (require :lib))

[;; CSV
 (pack :chrisbra/csv.vim {:config false})
 ;; Ansible
 (pack :mfussenegger/nvim-ansible {:config false})
 ;; Markdown
 (pack :gpanders/vim-medieval
       {:ft :markdown
        :config #(set vim.g.medieval_langs
                      [:python :ruby :sh :console=bash :bash :perl :fish :bb])})
 (pack :jakewvincent/mkdnflow.nvim (require :plugins.config.mkdnflow))
 (pack :mickael-menu/zk-nvim (require :plugins.config.zk-nvim))
 ; Terraform
 (pack :hashivim/vim-terraform
       {:config #(do
                   (set vim.g.terraform_align 1)
                   (set vim.g.terraform_fmt_on_save 0))})
 ;; Python
 (pack :Vimjas/vim-python-pep8-indent {:ft :python :event [:InsertEnter]})
 ;; Helm
 (pack :towolf/vim-helm
       {:ft :helm
        :init #(vim.api.nvim_create_autocmd [:BufRead :BufNewFile]
                                            {:command "set ft=helm"
                                             :pattern [:*/templates/*.yaml
                                                       :*/templates/*.tpl
                                                       :Chart.yaml
                                                       :values.yaml]})})
 ;; Lisps related
 (pack :guns/vim-sexp (require :plugins.config.vim-sexp))
 (pack :Olical/conjure
       {:config #(let [maps {"conjure#mapping#prefix" :<leader>c
                             "conjure#mapping#def_word" :g
                             "conjure#mapping#doc_word" :h}]
                   (each [k v (pairs maps)] (tset vim.g k v)))})]
