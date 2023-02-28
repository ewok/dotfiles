(local {: map! : get_buf_ft} (require :lib))

(local fmt-white-list {:python true
                       :terraform true
                       :fennel true
                       :go true
                       :clojure true
                       :json true
                       :markdown true
                       :sql true
                       :yaml true
                       :sh true
                       :bash true
                       :zsh true})

(fn config []
  (let [null-ls (require :null-ls)]
    (null-ls.setup {:on_attach (fn [_ bufnr]
                                 (do
                                   (when (. fmt-white-list (get_buf_ft bufnr))
                                     (map! [:n] :<leader>cf
                                           #(vim.lsp.buf.format) {:buffer bufnr}
                                           "Format buffer[NULL-LS]"))))
                    :sources [null-ls.builtins.completion.spell
                              null-ls.builtins.diagnostics.alex
                              null-ls.builtins.diagnostics.ansiblelint
                              null-ls.builtins.diagnostics.clj_kondo
                              null-ls.builtins.diagnostics.fish
                              null-ls.builtins.diagnostics.hadolint
                              null-ls.builtins.diagnostics.jsonlint
                              (null-ls.builtins.diagnostics.markdownlint.with {:extra_args [:--disable
                                                                                            :MD013]})
                              null-ls.builtins.diagnostics.mypy
                              null-ls.builtins.diagnostics.terraform_validate
                              null-ls.builtins.diagnostics.yamllint
                              null-ls.builtins.diagnostics.write_good
                              null-ls.builtins.formatting.autopep8
                              null-ls.builtins.formatting.black
                              null-ls.builtins.formatting.fnlfmt
                              null-ls.builtins.formatting.gofmt
                              null-ls.builtins.formatting.joker
                              ;; clojure
                              null-ls.builtins.formatting.jq
                              (null-ls.builtins.formatting.markdownlint.with {:extra_args [:--disable
                                                                                           :MD013]})
                              null-ls.builtins.formatting.shfmt
                              null-ls.builtins.formatting.sql_formatter
                              null-ls.builtins.formatting.terraform_fmt
                              null-ls.builtins.formatting.yamlfmt
                              (null-ls.builtins.formatting.stylua.with {:extra_args [:--indent-type=Spaces
                                                                                     :--indent-width=4]})]})))

{: config}
