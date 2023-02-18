local api = require("utils.api")
local map = api.map.map

local M = {}

function M.before() end
function M.load()
    vim.g.better_whitespace_filetypes_blacklist = { 'gitcommit', 'unite', 'qf', 'help', 'dotooagenda', 'dotoo' }
    map("n", "<leader>tw", "<cmd>StripWhitespace<CR>", {},  "Strip Whitespaces")
end
function M.after() end

return M
