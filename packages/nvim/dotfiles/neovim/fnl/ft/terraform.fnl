(local {: reg-ft : map!} (require :lib))

(reg-ft :terraform #(do
                      (map! [:n] :<leader>cf :<CMD>TerraformFmt<CR>
                            {:noremap true :buffer true}
                            "Format buffer[vim-terraform]")))
