(local {: pack : map!} (require :lib))

(local packages ;; Helpers
       [(pack :github/copilot.vim
              {:config (fn []
                         (set vim.g.copilot_filetypes
                              {:markdown true :yaml true}))})
        ;;; Surround
        (pack :tpope/vim-surround {:config false})
        ;;; Autopairs
        (pack :windwp/nvim-autopairs (require :plugins.config.nvim-autopairs))
        ;; Comments
        (pack :numToStr/Comment.nvim (require :plugins.config.comment))
        ;; Heuristically set buffer options
        (pack :tpope/vim-sleuth {:config false})
        ;; Allignment
        (pack :junegunn/vim-easy-align
              {:config (fn []
                         (map! [:n] :ga "<Plug>(LiveEasyAlign)" {:noremap true}
                               "Align Block")
                         (map! [:x] :ga "<Plug>(LiveEasyAlign)" {:noremap true}
                               "Align Block"))})
        ;; Fix trailing whitespace
        (pack :ntpeters/vim-better-whitespace
              {:config (fn []
                         (set vim.g.better_whitespace_filetypes_blacklist
                              conf.ui-ft)
                         (map! [:n] :<leader>cw :<cmd>StripWhitespace<cr> {}
                               "Strip Whitespaces"))})
        ;; Split/Join
        (pack :Wansmer/treesj (require :plugins.config.treesj))
        ;; Treesitter related
        (pack :JoosepAlviste/nvim-ts-context-commentstring {:config false})
        (pack :nvim-treesitter/nvim-treesitter
              (require :plugins.config.treesitter))])

(when conf.options.rainbow_parents
  (table.insert packages (pack :p00f/nvim-ts-rainbow {:config false})))

packages
