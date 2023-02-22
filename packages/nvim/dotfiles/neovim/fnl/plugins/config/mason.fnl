(local installer_resources {:lsp [:ansible-language-server
                                  :bash-language-server
                                  :clojure-lsp
                                  :fennel-language-server
                                  :jq
                                  :json-lsp
                                  :lua-language-server
                                  :pyright
                                  :rnix-lsp
                                  :terraform-ls
                                  :vim-language-server
                                  :zk]
                            :linter [:alex
                                     :yamllint
                                     :sqlfluff
                                     :markdownlint
                                     :jsonlint
                                     :ansible-lint
                                     :pylint
                                     :codespell
                                     :hadolint
                                     :mypy
                                     :write-good
                                     :tflint]
                            :formatter [:joker
                                        :black
                                        :yamlfmt
                                        :markdownlint
                                        :shfmt
                                        :jq
                                        :autopep8
                                        :sql-formatter
                                        :stylua]})

(local installed-resources [])

(fn config []
  (let [notify (require :notify)
        {: setup} (require :mason)
        {: is_installed : get_package} (require :mason-registry)]
    (do
      (setup {:max_concurrent_installers 10
              :ui {:border (or (and conf.options.float_border :rounded) :none)}
              :icons {:package_installed ""
                      :package_pending ""
                      :package_uninstalled ""}
              :github {:download_url_template (.. conf.options.download_source
                                                  "%s/releases/download/%s/%s")}})
      ;; Install resources
      (each [_ resource-tbl (pairs installer_resources)]
        (each [_ resource-name (pairs resource-tbl)]
          (if (not (is_installed resource-name))
              (let [(ok? resource) (pcall get_package resource-name)]
                (if ok?
                    (do
                      (resource.install resource)
                      (table.insert installed-resources resource-name))
                    (notify (.. "Invalid resource name " resource-name) :ERROR
                            {:title :Mason}))))))
      ;; Notify if any resources failed to install
      (if (not (vim.tbl_isempty installed-resources))
          (notify (.. "Install resource: \n - "
                      (table.concat installed-resources "\n - "))
                  :INFO {:title :Mason})))))

{: config}
