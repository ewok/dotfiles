-- https://github.com/jakewvincent/mkdnflow.nvim

local api = require("utils.api")
local map = api.map.map

local M = {
    requires = {
        "zk",
        "telescope"
    },
}

function M.before()
    M.register_key()
end

function M.load()
    local home = vim.fn.expand("~/Notes")
    vim.fn.setenv('ZK_NOTEBOOK_DIR', home)

    M.zk.setup({
        picker = "telescope",
    })

    M.telescope.load_extension("zk")
end

function M.after() end

function M.register_key()
    local opts = { noremap=true, silent=false }

    map("n", "<leader>wn", "<Cmd>ZkNew { title = vim.fn.input('Title: ') }<CR>", opts, "New note")
    map("n", "<leader>wi", "<Cmd>ZkIndex<CR>", opts, "Reindex notes")
    map("n", "<leader>wo", "<Cmd>ZkNotes { sort = { 'modified' } }<CR>", opts, "Open note")
    map("n", "<leader>wt", "<Cmd>ZkTags<CR>", opts, "Open tag")
    map("n", "<leader>wf", "<Cmd>ZkNotes { sort = { 'modified' }, match = { vim.fn.input('Search: ') } }<CR>", opts, "Find in notes")
    map("v", "<leader>wf", ":'<,'>ZkMatch<CR>", opts, "Find in notes")

end

return M
