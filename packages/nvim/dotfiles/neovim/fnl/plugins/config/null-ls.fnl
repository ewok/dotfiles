
(fn config []
(let [null-ls (require :null-ls)]
  (null-ls.setup {:sources [null-ls.builtins.formatting.terraform_fmt
                            null-ls.builtins.formatting.gofmt
                            null-ls.builtins.formatting.shfmt
                            null-ls.builtins.formatting.prettier
                            null-ls.builtins.formatting.autopep8
                            null-ls.builtins.formatting.sql_formatter
                            (null-ls.builtins.formatting.stylua.with {:extra_args [:--indent-type=Spaces
                                                                                   :--indent-width=4]})]})))

{: config}
