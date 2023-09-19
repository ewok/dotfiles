;; Helm
(local {: pack} (require :lib))

(pack :towolf/vim-helm
      {:ft :helm
       :event [:BufReadPre :BufNewFile]
       :init #(vim.api.nvim_create_autocmd [:BufReadPre :BufNewFile]
                                           {:command "set ft=helm"
                                            :pattern [:*/templates/*.yaml
                                                      :*/templates/*.tpl
                                                      :Chart.yaml
                                                      :values.yaml]})})
