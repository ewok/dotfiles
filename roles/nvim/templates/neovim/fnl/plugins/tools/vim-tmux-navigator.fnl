(local {: pack} (require :lib))

(pack :christoomey/vim-tmux-navigator
      {:init #(do
                (tset vim.g :tmux_navigator_save_on_switch 2)
                (tset vim.g :tmux_navigator_disable_when_zoomed 1))})
