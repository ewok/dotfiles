(local {: map! : toggle_sidebar} (require :lib))

(fn config []
  (let [nvim-tree (require :nvim-tree)]
    (nvim-tree.setup {:open_on_tab false
                      :disable_netrw false
                      :hijack_netrw false
                      :hijack_cursor true
                      :sync_root_with_cwd false
                      :reload_on_bufenter true
                      :update_focused_file {:enable true}
                      :system_open {:cmd nil :args []}
                      :view {:side :left
                             :width 40
                             :hide_root_folder false
                             :signcolumn :yes
                             :float {:enable false
                                     :quit_on_focus_loss false
                                     :open_win_config #(let [min 30
                                                             max 50
                                                             width-ratio 0.3
                                                             win-w (vim.api.nvim_win_get_width 0)
                                                             screen-h (- (: vim.opt.lines
                                                                            :get)
                                                                         (: vim.opt.cmdheight
                                                                            :get))
                                                             window-w (let [_win-w (math.floor (* win-w
                                                                                                  width-ratio))]
                                                                        (match [_win-w
                                                                                max
                                                                                min]
                                                                          (where [a
                                                                                  b
                                                                                  _]
                                                                                 (> a
                                                                                    b))
                                                                          b
                                                                          (where [a
                                                                                  _
                                                                                  c]
                                                                                 (< a
                                                                                    c))
                                                                          c
                                                                          _ _win-w))
                                                             window-h (math.floor (* screen-h
                                                                                     0.9))]
                                                         {:border :rounded
                                                          :relative :win
                                                          :col win-w
                                                          :row 1
                                                          :width window-w
                                                          :height window-h
                                                          :focusable false
                                                          :anchor :NE})}
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
                      :update_focused_file {:enable true}
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
                          (vim.cmd :NvimTreeFocus))
        {:silent false} "Find the current file and open it in file explorer"))

{: init : config}
