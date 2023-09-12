(local {: pack} (require :lib))

[;; Nice UI
 (pack :stevearc/dressing.nvim {:config false})
 ;; Winbar
 (pack :SmiteshP/nvim-navic {:config false})
 (pack :utilyre/barbecue.nvim (require :plugins.config.barbecue))
 ;; Notify
 (pack :rcarriga/nvim-notify (require :plugins.config.notify))
 ;; Buferline
 (pack :ewok/scope.nvim {:config true})
 (case conf.options.bufferline_plugin
   :tabby
   (pack :nanozuki/tabby.nvim (require :plugins.config.tabby))
   :bufferline
   (pack :akinsho/bufferline.nvim (require :plugins.config.bufferline))
   :cokeline
   (pack :willothy/nvim-cokeline (require :plugins.config.cokeline))
   :lualine
   (pack :nvim-lualine/lualine.nvim (require :plugins.config.lualine)))
 ; ;; Lualine
 ; (pack :nvim-lualine/lualine.nvim (require :plugins.config.lualine))
 ;; NeoZoom
 (pack :nyngwang/NeoZoom.lua (require :plugins.config.neozoom))
 ;; Better QF
 (pack :kevinhwang91/nvim-bqf (require :plugins.config.bqf))
 ;; Which-Key
 (pack :folke/which-key.nvim (require :plugins.config.which-key))
 ;; Hydra
 (pack :anuvyklack/hydra.nvim (require :plugins.config.hydra))]
