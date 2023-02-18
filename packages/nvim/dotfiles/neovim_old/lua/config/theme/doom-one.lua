-- https://github.com/
--
local options = require("core.options")

local M = {}

function M.before()
    vim.g.doom_one_terminal_colors = true
    vim.g.doom_one_italic_comments = true
    vim.g.doom_one_enable_treesitter = true

    -- vim.g.doom_one_plugin_neorg = true
    -- vim.g.doom_one_plugin_barbar = false
    vim.g.doom_one_plugin_telescope = true
    -- vim.g.doom_one_plugin_neogit = true
    vim.g.doom_one_plugin_nvim_tree = true
    -- vim.g.doom_one_plugin_dashboard = true
    -- vim.g.doom_one_plugin_startify = true
    vim.g.doom_one_plugin_whichkey = true
    vim.g.doom_one_plugin_indent_blankline = true
    vim.g.doom_one_plugin_vim_illuminate = true
    -- vim.g.doom_one_plugin_lspsaga = false

    --if options.overlength then
    --    vim.api.nvim_exec([[
    --         " Mark 80-th character
    --         hi! OverLength ctermbg=168 guibg=${color_14} ctermfg=250 guifg=${color_0}
    --         call matchadd('OverLength', '\%81v', 100)
    --       ]] % colors, true)
    --end
end

function M.load()
    vim.cmd [[ packadd doom-one.nvim ]]
    vim.cmd [[ colorscheme doom-one]]
end

function M.after()
end

return M
