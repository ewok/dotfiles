-- https://github.com/andrewradev/splitjoin.vim
local map = require("utils.api").map.map

local M = {}

function M.before()
    vim.g.splitjoin_split_mapping = ''
    vim.g.splitjoin_join_mapping = ''
end

function M.load()
    map("n", "gs", "<cmd>SplitjoinSplit<CR>", {}, "Magic Split")
    map("n", "gj", "<cmd>SplitjoinJoin<CR>", {}, "Magic Join")
end

function M.after() end

return M



