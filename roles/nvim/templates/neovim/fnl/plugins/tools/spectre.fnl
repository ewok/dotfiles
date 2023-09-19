;; Search and Replace

(local {: pack : map! : toggle_sidebar} (require :lib))

(fn config []
  (let [spectre (require :spectre)]
    (spectre.setup {:color_devicons true
                    :open_cmd :vnew
                    :live_update true
                    :mapping {:toggle_line {:map :x
                                            :cmd "<cmd>lua require('spectre').toggle_line()<CR>"
                                            :desc "toggle current item"}
                              :enter_file {:map :<cr>
                                           :cmd "<cmd>lua require('spectre.actions').select_entry()<CR>"
                                           :desc "goto current file"}
                              :send_to_qf {:map :<C-q>
                                           :cmd "<cmd>lua require('spectre.actions').send_to_qf()<CR>"
                                           :desc "send all item to quickfix"}
                              :replace_cmd {:map :rc
                                            :cmd "<cmd>lua require('spectre.actions').replace_cmd()<CR>"
                                            :desc "input replace vim command"}
                              :show_option_menu {:map :ro
                                                 :cmd "<cmd>lua require('spectre').show_options()<CR>"
                                                 :desc "show option"}
                              :run_current_replace {:map :r<CR>
                                                    :cmd "<cmd>lua require('spectre.actions').run_current_replace()<CR>"
                                                    :desc "replace current line"}
                              :run_replace {:map :R
                                            :cmd "<cmd>lua require('spectre.actions').run_replace()<CR>"
                                            :desc "replace all"}
                              :change_view_mode {:map :tv
                                                 :cmd "<cmd>lua require('spectre').change_view()<CR>"
                                                 :desc "change result view mode"}
                              :change_replace_sed {:map :trs
                                                   :cmd "<cmd>lua require('spectre').change_engine_replace('sed')<CR>"
                                                   :desc "use sed to replace"}
                              :change_replace_oxi {:map :tro
                                                   :cmd "<cmd>lua require('spectre').change_engine_replace('oxi')<CR>"
                                                   :desc "use oxi to replace"}
                              :toggle_live_update {:map :tu
                                                   :cmd "<cmd>lua require('spectre').toggle_live_update()<CR>"
                                                   :desc "update change when vim write file."}
                              :toggle_ignore_case {:map :ti
                                                   :cmd "<cmd>lua require('spectre').change_options('ignore-case')<CR>"
                                                   :desc "toggle ignore case"}
                              :toggle_ignore_hidden {:map :th
                                                     :cmd "<cmd>lua require('spectre').change_options('hidden')<CR>"
                                                     :desc "toggle search hidden"}
                              :resume_last_search {:map :r.
                                                   :cmd "<cmd>lua require('spectre').resume_last_search()<CR>"
                                                   :desc "resume last search before close"}}})
    (map! [:n] :<leader>rp #(do
                              (toggle_sidebar :spectre_panel)
                              (spectre.open))
          {:silent true} "Replace characters in all fs in the current workspace")
    (map! [:n] :<leader>rf
          #(do
             (toggle_sidebar :spectre_panel)
             (spectre.open_file_search)) {:silent true}
          "Replace all characters in the current file")
    (map! [:n] :<leader>rwf
          #(do
             (toggle_sidebar :spectre_panel)
             (spectre.open_visual {:select_word true
                                   :path (vim.fn.fnameescape (vim.fn.expand "%:p:."))}))
          {:silent true}
          "Replace the character under the cursor in the current file")
    (map! [:n] :<leader>rwp
          #(do
             (toggle_sidebar :spectre_panel)
             (spectre.open_visual {:select_word true})) {:silent true}
          "Replace the character under the cursor in all files under the current workspace")))

(pack :windwp/nvim-spectre {: config :event [:VeryLazy]})
