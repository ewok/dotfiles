(local {: reg-ft : map!} (require :lib))

(reg-ft :terraform #(do
                      (map! [:n] :<leader>cf :<CMD>TerraformFmt<CR>
                            {:noremap true :buffer true}
                            "Format buffer[vim-terraform]")))

(reg-ft :hcl #(do
                (map! [:n] :<leader>cf ":!terragrunt hclfmt --terragrunt-hclfmt-file %<CR><CR>"
                      {:noremap true :buffer true :silent true}
                      "Format buffer[terragrunt]")))
