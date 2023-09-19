(local {: pack} (require :lib))

(fn config [] ; local nvim_lightbulb = require("nvim-lightbulb")
  (let [nvim-lightbulb (require :nvim-lightbulb)]
    (nvim-lightbulb.setup {:ignore []
                           :sign {:enabled true :priority 15}
                           :float {:enabled false :text "💡" :win-opts {}}
                           :virtual-text {:enabled false
                                          :text "💡"
                                          :hl-mode :replace}
                           :status-text {:enabled false
                                         :text "💡"
                                         :text-unavailable ""}})
    (vim.fn.sign_define :LightBulbSign
                        {:text "💡"
                         :texthl :DiagnosticSignWarn
                         :linehl ""
                         :numhl ""})
    (vim.api.nvim_create_autocmd [:CursorHold :CursorHoldI]
                                 {:pattern ["*"]
                                  :callback #(nvim-lightbulb.update_lightbulb)})))

(pack :kosayoda/nvim-lightbulb {: config :event [:BufReadPre :BufNewFile]})
