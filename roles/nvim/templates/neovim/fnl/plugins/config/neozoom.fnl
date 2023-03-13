(local {: map!} (require :lib))

(fn config []
  (let [neozoom (require :neo-zoom)]
    (neozoom.setup {:winopts {:offset {:width 0.9 :height 0.85}
                              :border :single}
                    :exclude_filetypes [:lspinfo :mason :lazy :fzf :toggleterm]
                    :presets [{:filetypes [:dapui_.* :dap-repl]
                               :config {:top 0.25
                                        :left 0.6
                                        :width 0.4
                                        :height 0.65}
                               :callbacks [(fn [] (vim.wo.wrap true))]}]}))
  (map! :n :<leader>z :<cmd>NeoZoomToggle<cr> {:silent true :nowait true} :Zoom))

{: config}
