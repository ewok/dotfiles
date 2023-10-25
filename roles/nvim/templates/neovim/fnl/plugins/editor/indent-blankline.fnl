;;; Indent blankline
(local {: pack} (require :lib))

(fn config []
  (let [indent (require :ibl)]
    (do
      (set vim.g.indent_blankline_buftype_exclude conf.ui-ft)
      (indent.setup {}))))

(pack :lukas-reineke/indent-blankline.nvim
      {: config :event [:BufReadPre :BufNewFile]})
