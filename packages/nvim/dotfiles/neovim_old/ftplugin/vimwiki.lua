local map = require("utils.api").map.map

vim.opt_local.expandtab = true
vim.opt_local.shiftwidth = 4
vim.opt_local.tabstop = 4
vim.opt_local.softtabstop = 4
-- vim.opt_local.foldmethod = "expr"
-- vim.opt_local.foldexpr = "nvim_treesitter#foldexpr()"

vim.wo.foldlevel = 2
vim.wo.conceallevel = 2

-- cmd [[ command! -bang -nargs=? EvalBlock call medieval#eval(<bang>0, <f-args>) ]]

-- bmap('x', '<CR>', ":'<,'>ZkNewFromTitleSelection<CR>", { silent = true })

local md = { noremap = true, silent = true, buffer = true }

map("n", "<CR>", "<cmd>VimwikiFollowLink<CR>", md, "Follow Link")
map("n", "<Backspace>", "<cmd>VimwikiGoBackLink<CR>", md, "Go Back")
map("n", "]w", "<cmd>VimwikiNextLink<CR>", md, "Next Wiki Link")
map("n", "[w", "<cmd>VimwikiPrevLink<CR>", md, "Prev Wiki Link")
map("n", "<leader>cb", "<cmd>EvalBlock<CR>", md, "Run Block")
map("n", "<leader>wb", "<cmd>VimwikiBacklinks<cr>", md, "Backlinks")
map("n", "<leader>wC", ":VimwikiColorize<space>", md, "Colorize")
map("n", "<leader>wD", "<cmd>VimwikiDeleteFile<CR>", md, "Delete page")
map("n", "<leader>wr", "<cmd>VimwikiRenameFile<CR>", md, "Rename page")
-- map("n", "<leader>wi", "<cmd>Telescope vimwiki link", md, "Insert page")
map("n", "<leader>wj", "<cmd>VimwikiDiaryNextDay<CR>", md, "Show Next Day")
map("n", "<leader>wk", "<cmd>VimwikiDiaryPrevDay<CR>", md, "Show Previous Day")
map("n", "<leader>wmc", "<cmd>VimwikiCheckLinks<CR>", md, "Check Links")
map("n", "<leader>wmt", "<cmd>VimwikiRebuildTags<CR>", md, "Rebuild Tags")
