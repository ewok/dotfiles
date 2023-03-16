(local {: path-join} (require :lib))

(vim.fn.setenv :PATH (.. (path-join conf.data-dir "mason" "bin") ":" vim.env.PATH))
