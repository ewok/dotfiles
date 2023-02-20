(local {: map!} (require :lib))

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

;; FIXME: Colors in preview do not work
(fn config []
  (let [telescope (require :telescope)
        actions (require :telescope.actions)
        builtin (require :telescope.builtin)]
    (telescope.setup {:defaults {: vimgrep_arguments
                                 :prompt_prefix " "
                                 :selection_caret " "
                                 :entry_prefix " "
                                 :multi_icon " "
                                 :color_devicons true
                                 :file_ignore_patterns [:node_modules]
                                 :layout_strategy :bottom_pane
                                 :set_env {:COLORTERM :truecolor}
                                 :layout_config {:bottom_pane {:height 0.95
                                                               :preview_cutoff 100
                                                               :prompt_position :bottom}}
                                 :mappings {:i {:<c-j> actions.move_selection_next
                                                :<c-k> actions.move_selection_previous
                                                :<C-s> actions.select_horizontal
                                                :<C-v> actions.select_vertical
                                                :<C-t> actions.select_tab
                                                :<C-q> (+ actions.smart_send_to_qflist
                                                          actions.open_qflist)
                                                :<C-Space> (+ actions.toggle_selection
                                                              actions.move_selection_next)
                                                :<esc> actions.close}
                                            :n {:<esc> actions.close}}
                                 :pickers {:buffers {:mappings {:i {:<c-d> :delete_buffer}
                                                                :n {:dd :delete_buffer}}}}
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

{: config}
