-- https://github.com/mg979/vim-visual-multi

local api = require("utils.api")

local M = {}

M._viml = true

function M.before()
    M.register_key()
end

function M.load()
    vim.g.VM_Extend_hl = "DiffAdd"
    vim.g.VM_Cursor_hl = "Visual"
    vim.g.VM_Mono_hl = "DiffText"
    vim.g.VM_Insert_hl = "DiffChange"

    vim.g.VM_default_mappings = 0

    vim.g.VM_maps = {
        ["Find Under"] = "<c-n>",
        ["Find Prev"] = "<c-p>",
        ["Skip Region"] = "<c-s>",
        ["Remove Region"] = "<c-d>",
    }
end

function M.after() end

function M.register_key()
    api.map.bulk_register({
        {
            mode = { "n" },
            lhs = "<m-p>",
            rhs = ":call vm#commands#add_cursor_up(0, v:count1)<cr>",
            options = { silent = true },
            description = "Create cursor down",
        },
        {
            mode = { "n" },
            lhs = "<m-n>",
            rhs = ":call vm#commands#add_cursor_down(0, v:count1)<cr>",
            options = { silent = true },
            description = "Create cursor up",
        },
    })
end

return M
