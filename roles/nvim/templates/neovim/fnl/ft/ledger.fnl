;; {% raw %}
(local {: reg-ft} (require :lib))

(reg-ft "ledger" #(do
    (set vim.opt_local.expandtab true)
    (set vim.opt_local.shiftwidth 4)
    (set vim.opt_local.tabstop 4)
    (set vim.opt_local.softtabstop 4)
    (set vim.opt_local.foldmethod "marker")
    (set vim.opt_local.foldmarker "{{{,}}}")
    (set vim.opt_local.commentstring "; %s")))

;; {% endraw %}
