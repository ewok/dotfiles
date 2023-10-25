;; Nvim-Tree

(local {: pack : map! : toggle_sidebar} (require :lib))

(fn config []
  (let [nvim-tree (require :nvim-tree)
        on_attach (fn [bufnr]
                    (let [api (require :nvim-tree.api)
                          opts #{:desc (.. "nvim-tree: " $1)
                                 :buffer bufnr
                                 :noremap true
                                 :silent true
                                 :nowait true}]
                      (vim.keymap.set :n :<CR> api.node.open.edit (opts :Open))
                      (vim.keymap.set :n :o api.node.open.edit (opts :Open))
                      (vim.keymap.set :n :l api.node.open.edit (opts :Open))
                      (vim.keymap.set :n "<C-]>" api.tree.change_root_to_node
                                      (opts :CD))
                      (vim.keymap.set :n :C api.tree.change_root_to_node
                                      (opts :CD))
                      (vim.keymap.set :n :v api.node.open.vertical
                                      (opts "Open: Vertical Split"))
                      (vim.keymap.set :n :s api.node.open.horizontal
                                      (opts "Open: Horizontal Split"))
                      (vim.keymap.set :n :t api.node.open.tab
                                      (opts "Open: New Tab"))
                      (vim.keymap.set :n :h api.node.navigate.parent_close
                                      (opts "Close Directory"))
                      (vim.keymap.set :n :<Tab> api.node.open.preview
                                      (opts "Open Preview"))
                      (vim.keymap.set :n :I api.tree.toggle_gitignore_filter
                                      (opts "Toggle Git Ignore"))
                      (vim.keymap.set :n :H api.tree.toggle_hidden_filter
                                      (opts "Toggle Dotfiles"))
                      (vim.keymap.set :n :r api.tree.reload (opts :Refresh))
                      (vim.keymap.set :n :R api.tree.reload (opts :Refresh))
                      (vim.keymap.set :n :a api.fs.create (opts :Create))
                      (vim.keymap.set :n :d api.fs.remove (opts :Delete))
                      (vim.keymap.set :n :m api.fs.rename (opts :Rename))
                      (vim.keymap.set :n :M api.fs.rename_sub
                                      (opts "Rename: Omit Filename"))
                      (vim.keymap.set :n :x api.fs.cut (opts :Cut))
                      (vim.keymap.set :n :c api.fs.copy.node (opts :Copy))
                      (vim.keymap.set :n :p api.fs.paste (opts :Paste))
                      (vim.keymap.set :n "[g" api.node.navigate.git.prev
                                      (opts "Prev Git"))
                      (vim.keymap.set :n "[g" api.node.navigate.git.next
                                      (opts "Next Git"))
                      (vim.keymap.set :n :u api.tree.change_root_to_parent
                                      (opts :Up))
                      (vim.keymap.set :n :q api.tree.close (opts :Close))))]
    (nvim-tree.setup {: on_attach
                      :open_on_tab false
                      :disable_netrw false
                      :hijack_netrw false
                      :hijack_cursor true
                      :sync_root_with_cwd false
                      :reload_on_bufenter true
                      :update_focused_file {:enable true}
                      :system_open {:cmd nil :args []}
                      :view {:side :left
                             :width 40
                             ; :hide_root_folder false
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
                                                          :anchor :NE})}}
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
                                                :git true}}}})))

(fn init []
  (map! :n :<leader>1 #(do
                         (toggle_sidebar :NvimTree)
                         (vim.cmd :NvimTreeToggle))
        {:silent true} "Open File Explorer")
  (map! :n :<leader>fp #(do
                          (toggle_sidebar :NvimTree)
                          (vim.cmd :NvimTreeFocus))
        {:silent false} "Find the current file and open it in file explorer"))

(pack :kyazdani42/nvim-tree.lua
      {: init : config :cmd [:NvimTreeToggle :NvimTreeFocus]})
