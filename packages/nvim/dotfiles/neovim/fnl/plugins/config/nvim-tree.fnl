(local {: map! : toggle_sidebar} (require :lib))

(fn config []
  (let [nvim-tree (require :nvim-tree)]
    (nvim-tree.setup {:open_on_tab false
                      :disable_netrw false
                      :hijack_netrw false
                      :hijack_cursor true
                      :sync_root_with_cwd false
                      :reload_on_bufenter true
                      :update_focused_file {:enable false :update_root false}
                      :system_open {:cmd nil :args []}
                      :view {:side :left
                             :width 35
                             :hide_root_folder false
                             :signcolumn :yes
                             :mappings {:custom_only true
                                        :list [{:key [:<CR>] :action :edit}
                                               {:key [:o] :action :edit}
                                               {:key [:l] :action :edit}
                                               {:key ["<C-]>"] :action :cd}
                                               {:key [:C] :action :cd}
                                               {:key [:v] :action :vsplit}
                                               {:key [:s] :action :split}
                                               {:key [:t] :action :tabnew}
                                               {:key [:h] :action :close_node}
                                               {:key [:<Tab>] :action :preview}
                                               {:key [:I]
                                                :action :toggle_ignored}
                                               {:key [:H]
                                                :action :toggle_dotfiles}
                                               {:key [:r] :action :refresh}
                                               {:key [:R] :action :refresh}
                                               {:key [:a] :action :create}
                                               {:key [:d] :action :remove}
                                               {:key [:m] :action :rename}
                                               {:key [:M] :action :full_rename}
                                               {:key [:x] :action :cut}
                                               {:key [:c] :action :copy}
                                               {:key [:p] :action :paste}
                                               {:key ["[g"]
                                                :action :prev_git_item}
                                               {:key ["]g"]
                                                :action :next_git_item}
                                               {:key [:u] :action :dir_up}
                                               {:key [:q] :action :close}]}}
                      :diagnostics {:enable true
                                    :show_on_dirs true
                                    :icons {:hint conf.icons.Hint
                                            :info conf.icons.Info
                                            :warning conf.icons.Warn
                                            :error conf.icons.Error}}
                      :actions {:use_system_clipboard true
                                :change_dir {:enable true
                                             :global true
                                             :restrict_above_cwd false}
                                :open_file {:resize_window true
                                            :quit_on_open true
                                            :window_picker {:enable false}}}
                      :trash {:cmd :trash :require_confirm true}
                      :filters {:dotfiles false
                                :custom [:node_modules "\\.cache" :__pycache__]
                                :exclude []}
                      :renderer {:add_trailing true
                                 :group_empty true
                                 :highlight_git true
                                 :highlight_opened_files :none
                                 :icons {:show {:file true
                                                :folder true
                                                :folder_arrow true
                                                :git true}
                                         :glyphs {:default ""
                                                  :symlink ""
                                                  :git {:unstaged ""
                                                        :staged ""
                                                        :unmerged ""
                                                        :renamed "凜"
                                                        :untracked ""
                                                        :deleted ""
                                                        :ignored ""}
                                                  :folder {:arrow_open ""
                                                           :arrow_closed ""
                                                           :default ""
                                                           :open ""
                                                           :empty ""
                                                           :empty_open ""
                                                           :symlink ""
                                                           :symlink_open ""}}}}})))

(fn init []
  (map! :n :<leader>1 #(do
                         (toggle_sidebar :NvimTree)
                         (vim.cmd :NvimTreeToggle))
        {:silent true} "Open File Explorer")
  (map! :n :<leader>fp #(do
                          (toggle_sidebar :NvimTree)
                          (vim.cmd :NvimTreeFindFile))
        {:silent true} "Find the current file and open it in file explorer"))

{:cmd [:NvimTreeToggle :NvimTreeFindFile] : init : config}
