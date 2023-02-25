(local ignore_filetype {:help :startify
                        :dashboard :lazy
                        :neo-tree :neogitstatus
                        :NvimTree :Trouble
                        :alpha :lir
                        :Outline :spectre_panel
                        :toggleterm :DressingSelect
                        :Jaq :harpoon
                        :dap-repl :dap-terminal
                        :dapui_console :dapui_hover
                        :lab :notify
                        :noice ""})

(fn config [] ; local nvim_navic = require("nvim-navic")
  (let [barbecue (require :barbecue)
        ui (require :barbecue.ui)]
    (barbecue.setup {:create_autocmd false :attach_navic false :theme conf.options.theme})
    (vim.api.nvim_create_autocmd [:CursorHold
                                  :BufWinEnter
                                  :InsertLeave
                                  :WinScrolled
                                  :BufWritePost
                                  :TextChanged
                                  :TextChangedI]
                                 {:group (vim.api.nvim_create_augroup :barbecue.updater
                                                                      {})
                                  :callback #(ui.update)})))

{: config}
