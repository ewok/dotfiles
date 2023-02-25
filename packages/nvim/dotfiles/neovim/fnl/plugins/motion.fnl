(local {: pack} (require :lib))

[(pack :chaoren/vim-wordmotion {:config false})
 (pack :tpope/vim-repeat {:config false})
 (pack :mg979/vim-visual-multi (require :plugins.config.vim-visual-multi))
 (case conf.options.motion_plugin
   :hop
   (pack :aznhe21/hop.nvim (require :plugins.config.hop))
   :leap
   (pack :ggandor/flit.nvim
         {:config true
          :dependencies [(pack :ggandor/leap.nvim
                               (require :plugins.config.leap))]}))]