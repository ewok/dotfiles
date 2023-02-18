-- https://github.com/kevinhwang91/nvim-bqf
local map = require("utils.api").map.map

local M = {
    requires = {
        "bqf",
    },
}

function M.before()
    M.register_key()
end

function M.load()
    M.bqf.setup({
        func_map = {
            tab = '<C-t>',
            vsplit = '<C-v>',
            split = '<C-s>'
        },
        filter = {
            fzf = {
                action_for = {
                    ['ctrl-t'] = 'tabedit',
                    ['ctrl-v'] = 'vsplit',
                    ['ctrl-s'] = 'split',
                }
            }
        }
    })
end

function M.after() end

function M.toggle_qf()
    local qf_exists = false
    for _, win in pairs(vim.fn.getwininfo()) do
        if win["quickfix"] == 1 then
            qf_exists = true
        end
    end
    if qf_exists == true then
        vim.cmd "cclose"
        return
    end
    if not vim.tbl_isempty(vim.fn.getqflist()) then
        vim.cmd "copen"
    end
end

function M.register_key()
    map("n", "<leader>tq", M.toggle_qf, { silent = true }, "Toggle qf")
end

return M
