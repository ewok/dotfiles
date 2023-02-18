-- https://github.com/gpanders/vim-medieval

local M = { }
function M.before() end

function M.load()
    vim.g.medieval_langs = { 'python', 'ruby', 'sh', 'console=bash', 'bash', 'perl', 'fish', 'bb' }
end

function M.after() end

return M

