(local {: pack : map!} (require :lib))

(local vimgrep_arguments [:rg
                          :--color=never
                          :--no-heading
                          :--with-filename
                          :--line-number
                          :--column
                          :--smart-case
                          :--hidden
                          :--ignore
                          :--iglob
                          :!.git
                          :--ignore-vcs
                          :--ignore-file
                          "~/.config/git/gitexcludes"])

(fn config []
  (let [telescope (require :telescope)
        actions (require :telescope.actions)
        builtin (require :telescope.builtin)]
    (telescope.setup {:defaults {: vimgrep_arguments
                                 ; :prompt_prefix " "
                                 ; :selection_caret " "
                                 ; :entry_prefix " "
                                 ; :multi_icon " "
                                 :color_devicons true
                                 :file_ignore_patterns [:node_modules]
                                 :layout_strategy :flex
                                 :set_env {:COLORTERM :truecolor}
                                 :layout_config {:flex {:height 0.95
                                                        :width 0.95
                                                        :flip_columns 130
                                                        :prompt_position :bottom
                                                        :horizontal {:width 0.99
                                                                     :height 0.95
                                                                     :preview_width 0.5}
                                                        :vertical {:width 0.99
                                                                   :height 0.99
                                                                   :preview_height 0.7}}}
                                 :mappings {:i {:<c-j> actions.move_selection_next
                                                :<c-k> actions.move_selection_previous
                                                :<c-s> actions.select_horizontal
                                                :<c-v> actions.select_vertical
                                                :<c-t> actions.select_tab
                                                :<c-q> (+ actions.smart_send_to_qflist
                                                          actions.open_qflist)
                                                :<c-i> (+ actions.toggle_selection
                                                          actions.move_selection_previous)
                                                :<esc> actions.close}
                                            :n {:<esc> actions.close}}
                                 :pickers {:buffers {:mappings {:i {:<c-d> :delete_buf}
                                                                :n {:dd :delete_buf}}}}
                                 :extensions {:fzf {:fuzzy true
                                                    :override_generic_sorter true
                                                    :override_file_sorter true
                                                    :case_mode :smart_case}}}})
    (map! [:n] :<leader>fo
          #(builtin.find_files {:find_command [:rg
                                               :--ignore
                                               :--hidden
                                               :--files
                                               :--iglob
                                               :!.git
                                               :--ignore-vcs
                                               :--ignore-file
                                               "~/.config/git/gitexcludes"]})
          {:silent true} "Find files in the current workspace")
    (map! [:n] :<leader>ff #(builtin.live_grep) {:silent true}
          "Find string in the current workspace")
    (map! [:n] :<leader>fh #(builtin.oldfiles) {:silent true}
          "Find telescope history")
    (map! [:n] :<leader>f. #(builtin.resume) {:silent true} "Find last lookup")
    (map! [:n] :<leader>fm #(builtin.marks) {:silent true}
          "Find marks in the current workspace")
    (map! [:n] :<leader>fb #(builtin.buffers) {:silent true} "Find all buffers")
    (map! [:n] :<leader>f/ #(builtin.current_buffer_fuzzy_find) {:silent true}
          "Find string current buffer")
    (map! [:n] "<leader>f:" #(builtin.command_history) {:silent true}
          "Find all command history")
    (map! [:n] :<leader>fss "<cmd>Telescope vim_options<CR>" {:silent true}
          :Settings)
    (map! [:n] :<leader>fH #(builtin.help_tags) {:silent true} "Help tags")
    (map! [:n] :<leader>fsa "<cmd>Telescope autocommands<CR>" {:silent true}
          :Autocommands)
    (map! [:n] :<leader>fsf "<cmd>Telescope filetypes<CR>" {:silent true}
          :Filetypes)
    (map! [:n] :<leader>fsh #(builtin.highlights) {:silent true} :Highlights)
    (map! [:n] :<leader>fsk "<cmd>Telescope keymaps<CR>" {:silent true}
          :Keymaps)
    (map! [:n] :<leader>fsc "<cmd>Telescope colorscheme<CR>" {:silent true}
          :Colorschemes)
    (telescope.load_extension :fzf)
    (vim.api.nvim_create_autocmd [:BufEnter]
                                 {:pattern ["*"] :command "normal zx"})))

;; Telescope
[(pack :nvim-telescope/telescope-fzf-native.nvim {:build :make})
 (pack :nvim-telescope/telescope.nvim {: config :event [:VeryLazy]})]
