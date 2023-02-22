(local {: pack} (require :lib))

[;; Nice UI
 (pack :stevearc/dressing.nvim {:config false})
 ;; Winbar
 (pack :SmiteshP/nvim-navic {:config false})
 (pack :utilyre/barbecue.nvim (require :plugins.config.barbecue))
 ;; Notify
 (pack :rcarriga/nvim-notify (require :plugins.config.notify))
 ;; Lualine
 (pack :nvim-lualine/lualine.nvim (require :plugins.config.lualine))
 ;; Buferline
 (pack :akinsho/bufferline.nvim (require :plugins.config.bufferline))
 ;; NeoZoom
 (pack :nyngwang/NeoZoom.lua (require :plugins.config.neozoom))
 ;; Better QF
 (pack :kevinhwang91/nvim-bqf (require :plugins.config.bqf))
 ;; Which-Key
 (pack :folke/which-key.nvim (require :plugins.config.which-key))]
