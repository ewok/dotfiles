(local {: pack} (require :lib))

[;; Mason
 (pack :williamboman/mason.nvim (require :plugins.config.mason))
 ;; Telescope
 (pack :nvim-telescope/telescope-fzf-native.nvim {:build :make})
 (pack :nvim-telescope/telescope.nvim (require :plugins.config.telescope))
 ;; Mind
 (pack :phaazon/mind.nvim (require :plugins.config.mind))
 ;; Sessions
 (pack :olimorris/persisted.nvim (require :plugins.config.persisted))
 ;; Nice TODO-comments
 (pack :folke/todo-comments.nvim (require :plugins.config.todo-comments))
 ;; Search and Replace
 (pack :windwp/nvim-spectre (require :plugins.config.spectre))
 (pack :gabrielpoca/replacer.nvim {:config false})
 ;; Undo tree
 (pack :mbbill/undotree (require :plugins.config.undotree))
 ;; Nvim-Tree
 (pack :kyazdani42/nvim-tree.lua (require :plugins.config.nvim-tree))
 ; (let [m (require :plugins.config.nvim-tree)] m))
 ;; TMUX and terminal things
 (pack :akinsho/toggleterm.nvim (require :plugins.config.toggleterm))
 (pack :christoomey/vim-tmux-navigator
       {:init #(do
                 (tset vim.g :tmux_navigator_save_on_switch 2)
                 (tset vim.g :tmux_navigator_disable_when_zoomed 1))})]
