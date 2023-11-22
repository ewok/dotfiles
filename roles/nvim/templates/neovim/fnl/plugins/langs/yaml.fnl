(local {: pack : map!} (require :lib))

(pack :someone-stole-my-name/yaml-companion.nvim
      {:config #(let [yamlconfig (require :yaml-companion)
                      cfg (yamlconfig.setup {:schemas [{:name "Kubernetes 1.22.4"
                                                        :uri "https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/v1.22.4-standalone-strict/all.json"}]})
                      telescope (require :telescope)
                      lspconfig (require :lspconfig)]
                  (telescope.load_extension :yaml_schema)
                  (lspconfig.yamlls.setup cfg)
                  (map! :n :<leader>cs #(yamlconfig.open_ui_select)
                        {:noremap true} "Switch Schema"))})
