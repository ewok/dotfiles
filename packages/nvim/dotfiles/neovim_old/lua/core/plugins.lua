local aux_packer = require("utils.aux.packer")

local plugins = {}

plugins.basic = {
    -- { 'lewis6991/impatient.nvim' },
    { "wbthomason/packer.nvim" },
    { "rcarriga/nvim-notify" },
    { "tpope/vim-repeat", fn = "repate#set" },
    { "nvim-lua/plenary.nvim", module = "plenary" },
    { "williamboman/mason.nvim", after = { "nvim-notify" } },
    { "nvim-treesitter/nvim-treesitter", module = "nvim-treesitter", run = { ":TSUpdate" } },
    { "kyazdani42/nvim-web-devicons", module = "nvim-web-devicons" },
}

plugins.theme = {
    { 'NTBBloodbath/doom-one.nvim' },
}

plugins.lsp = {
    { "williamboman/mason-lspconfig.nvim", after = { "mason.nvim" } },
    { "SmiteshP/nvim-navic", after = { "mason-lspconfig.nvim" } },
    { "stevearc/aerial.nvim", after = { "nvim-navic" } },
    { "neovim/nvim-lspconfig", after = { "aerial.nvim" } },
    { "j-hui/fidget.nvim", after = { "nvim-lspconfig" } },
    { "kosayoda/nvim-lightbulb", after = { "nvim-lspconfig" } },
    { "jose-elias-alvarez/null-ls.nvim", after = { "nvim-lspconfig" } },
}

plugins.complete = {
    { "rafamadriz/friendly-snippets", event = { "InsertEnter", "CmdlineEnter" } },
    { "hrsh7th/vim-vsnip", after = { "friendly-snippets" } },
    { "hrsh7th/nvim-cmp", after = { "vim-vsnip" } },
    { "hrsh7th/cmp-vsnip", after = { "nvim-cmp" } },
    { "hrsh7th/cmp-nvim-lsp", after = { "nvim-cmp" } },
    { "hrsh7th/cmp-buffer", after = { "nvim-cmp" } },
    { "hrsh7th/cmp-path", after = { "nvim-cmp" } },
    { "hrsh7th/cmp-cmdline", after = { "nvim-cmp" } },
    { "kristijanhusak/vim-dadbod-completion", after = { "nvim-cmp" } },
}

plugins.dap = {
    { "mfussenegger/nvim-dap", module = "dap" },
    { "theHamsta/nvim-dap-virtual-text", after = { "nvim-dap" } },
    { "rcarriga/nvim-dap-ui", after = { "nvim-dap" } },
}

plugins.editor = {
    { "AndrewRadev/switch.vim" },
    { "windwp/nvim-autopairs", event = { "InsertEnter" } },
    { "ur4ltz/surround.nvim", event = { "BufRead", "BufNewFile" } },
    { "RRethy/vim-illuminate", event = { "BufRead", "BufNewFile" } },
    { "lukas-reineke/indent-blankline.nvim", after = { "nvim-treesitter" } },
    { "p00f/nvim-ts-rainbow", after = { "nvim-treesitter" } },
    { "JoosepAlviste/nvim-ts-context-commentstring", after = { "nvim-treesitter" } },
    { "numToStr/Comment.nvim", module = { "Comment" }, after = { "nvim-ts-context-commentstring" } },
    { "mg979/vim-visual-multi", fn = { "vm#commands#add_cursor_up", "vm#commands#add_cursor_down" }, keys = { "<c-n>" } },
    { "tpope/vim-sleuth" },
    { "junegunn/vim-easy-align" },
    { "ntpeters/vim-better-whitespace" },
    { "chaoren/vim-wordmotion" },
    { "andrewradev/splitjoin.vim" }
}

plugins.language = {
    { "folke/neodev.nvim" },
    { "Vimjas/vim-python-pep8-indent", ft = "py", event = { "InsertEnter" } },
    { "scalameta/nvim-metals", after = { "nvim-lspconfig" } },
    { "jakewvincent/mkdnflow.nvim" },
    { "gpanders/vim-medieval" },
    { "towolf/vim-helm"},
}

plugins.find = {
    { "kevinhwang91/nvim-hlslens", module = "hlslens" },
    { "folke/todo-comments.nvim", event = { "BufRead", "BufNewFile" } },
    { "nvim-telescope/telescope.nvim", module = { "telescope" }},
    { "nvim-telescope/telescope-fzf-native.nvim", run = "make", module = { "telescope._extensions.fzf" } },
}

plugins.tools = {
    { "olimorris/persisted.nvim" },
    { "norcalli/nvim-colorizer.lua" },
    { "lewis6991/gitsigns.nvim", event = { "BufRead", "BufNewFile" } },
    { "tpope/vim-fugitive", requires = { { 'tpope/vim-rhubarb' }, { 'shumphrey/fugitive-gitlab.vim' } } },
    { "dstein64/vim-startuptime", cmd = { "StartupTime" } },
    { "folke/which-key.nvim", event = { "BufRead", "BufNewFile" } },
    { "christoomey/vim-tmux-navigator" },
    -- { "renerocksai/telekasten.nvim"},
    { "mickael-menu/zk-nvim"},
    -- { "vimwiki/vimwiki", branch = "dev", requires = {
    --     "ElPiloto/telescope-vimwiki.nvim",
    --     'gpanders/vim-medieval',
    -- } }
}

plugins.views = {
    { "nvim-lualine/lualine.nvim", after = { "nvim-web-devicons" } },
    { "nvim-pack/nvim-spectre", module = "spectre" },
    { "gabrielpoca/replacer.nvim", module = "replacer" },
    { "mbbill/undotree", event = { "BufRead", "BufNewFile" } },
    { "kyazdani42/nvim-tree.lua", cmd = { "NvimTreeToggle", "NvimTreeFindFile" } },
    { "akinsho/bufferline.nvim", events = { "BufNewFile", "BufRead", "TabEnter" } },
    { "tpope/vim-dadbod", fn = { "db#resolve" } },
    { "kristijanhusak/vim-dadbod-ui", cmd = { "DBUIToggle" } },
    { "akinsho/toggleterm.nvim", module = "toggleterm" },
    { "kevinhwang91/nvim-bqf" },
}

aux_packer.entry(plugins)

return plugins
