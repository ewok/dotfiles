(local {: pack : map! : is_ft_open?} (require :lib))

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
        ui (require :barbecue.ui)
        au_group (vim.api.nvim_create_augroup :barbecue.updater {})]
    (barbecue.setup {:create_autocmd false
                     :attach_navic false
                     :theme conf.options.theme
                     :symbols {:separator conf.separator.alt_left}})
    (vim.api.nvim_create_autocmd [:CursorHold
                                  :BufWinEnter
                                  :InsertLeave
                                  :WinScrolled
                                  :BufWritePost
                                  :TextChanged
                                  :TextChangedI]
                                 {:group au_group :callback #(ui.update)})
    (vim.api.nvim_create_autocmd [:BufEnter]
                                 {:group au_group
                                  :callback #(if (is_ft_open? :fugitiveblame)
                                                 (ui.toggle false)
                                                 (ui.toggle true))})))

(pack :utilyre/barbecue.nvim {: config :event [:BufReadPre :BufNewFile]})
