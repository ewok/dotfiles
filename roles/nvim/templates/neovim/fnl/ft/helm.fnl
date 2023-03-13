(local {: reg-ft : map!} (require :lib))

(reg-ft :helm #(do
                 (map! [:n] :<leader>cr
                       #(do
                          (vim.cmd :write)
                          (vim.api.nvim-command "!helm template ./ --output-dir .out"))
                       {:noremap true} "Render Helm")))
