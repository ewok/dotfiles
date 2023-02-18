-- https://github.com/tpope/vim-fugitive

local map = require("utils.api").map.map

local M = {
    -- requires = {
    --     "colorizer",
    -- },
}

function M.before()
    M.register_key()
end

function M.load()
    _G.git_show_block_history = function()
        vim.cmd [[exe ":G log -L " . string(getpos("'<'")[1]) . "," . string(getpos("'>'")[1]) . ":%"]]
    end

    _G.git_show_line_history = function()
        vim.cmd [[exe ":G log -U1 -L " . string(getpos('.')[1]) . ",+1:%"]]
    end
end

function M.after()
end

function M.register_key()
    local md = { noremap = true }
    map("n", "<leader>gb",'<cmd>Git blame<CR>', md, 'Git Blame')
    map("n", "<leader>gd",'<cmd>Gdiffsplit<CR>', md, 'Git Diff')
    map("n", "<leader>gg",'<cmd>.GBrowse %<CR>', md, 'Git Browse')
    map("n", "<leader>gl.",function() git_show_line_history() end, md, 'History Line')
    map("n", "<leader>gll",'<cmd>GlLog<CR>', md, 'History')
    map("n", "<leader>glf",'<cmd>GlLog %<CR>', md, 'History File')
    map("n", "<leader>gfm",'<cmd>Git pull<CR>', md, 'Git Merge')
    map("n", "<leader>gfr",'<cmd>Git pull --rebase<CR>', md, 'Git Rebase')
    map("n", "<leader>gps",'<cmd>Git push<CR>', md, 'Git Push')
    map("n", "<leader>gpf",'<cmd>Git push --force-with-lease<CR>', md, 'Push(force with lease)')
    map("n", "<leader>gpF",'<cmd>Git push --force<CR>', md, 'Push(force)')
    map("n", "<leader>gR",'<cmd>Gread<CR>', md, 'Git Reset')
    map("n", "<leader>gs",'<cmd>Git<CR>', md, 'Git Status')
    map("n", "<leader>gW",'<cmd>Gwrite<CR>', md, 'Git Write')
    map("x", "<leader>gg",[[:'<,'>GBrowse %<CR>]], md, 'Git Browse')
    map("x", "<leader>glv",function() git_show_block_history() end, md, 'History Visual Block')
end

return M
