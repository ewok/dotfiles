-- {% raw %}
local map = require("utils.api").map.map

local mapping = {}

local md = {noremap = true, silent = false}

-- Navigation
map('n', '<C-O><C-O>', '<C-O>', md, 'Go Back')
map('n', '<C-O><C-I>', '<Tab>', md, 'Go Forward')

-- Windows manipulation
map('n', '<C-W>t', '<cmd>tabnew<CR>', md, 'New Tab')
map('n', '<C-W>S', vim.fn.exists('$TMUX') == 1
    and '<cmd>!tmux split-window -v -p 20<CR><CR>'
    or '<cmd>split term://bash<CR>i', md, 'Split window')
map('n', '<C-W>V', vim.fn.exists('$TMUX') == 1
    and '<cmd>!tmux split-window -h -p 20<CR><CR>'
    or '<cmd>vsplit term://bash<CR>i', md, 'VSplit window')
map('n', '<C-W><C-J>', ':resize +5<CR>', md, 'Increase height +5')
map('n', '<C-W><C-K>', ':resize -5<CR>', md, 'Decrease height -5')
map('n', '<C-W><C-L>', ':vertical resize +5<CR>', md, 'Increase width +5')
map('n', '<C-W><C-H>', ':vertical resize -5<CR>', md, 'Decrease width -5')
map('n', '<C-W>q', '<cmd>close<CR>', md, 'Close window')
map('n', '<C-W><C-Q>', '<cmd>close<CR>', md, 'Close window')

-- Folding
map('n', ']z', 'zjmzzMzvzz15<c-e>`z', md, 'Next Fold')
map('n', '[z', 'zkmzzMzvzz15<c-e>`z', md, 'Previous Fold')
map('n', 'zO', 'zczO', md, 'Open all folds under cursor')
map('n', 'zC', 'zcV:foldc!<CR>', md, 'Close all folds under cursor')
map('n', 'z<Space>', 'mzzMzvzz15<c-e>`z', md, 'Show only current Fold')
map('n', '<Space><Space>', 'za"{{{"', md, 'Toggle Fold')

map('x','<Space><Space>', 'zf"}}}"', md, 'Toggle Fold')

-- Yank
map('n', '<leader>yy', '<cmd>.w! ~/.vbuf<CR>', md, 'Yank to ~/.vbuf')
map('n', '<leader>yp', '<cmd>r ~/.vbuf<CR>', md, 'Paste from ~/.vbuf')
map('x', '<leader>yy', [[:'<,'>w! ~/.vbuf<CR>]], md, 'Yank to ~/.vbuf')

map('n', '<leader>yfl', [[:let @+=expand("%") . ':' . line(".")<CR>]], md, 'Yank file name and line')
map('n', '<leader>yfn', [[:let @+=expand("%")<CR>]], md, 'Yank file name')
map('n', '<leader>yfp', [[:let @+=expand("%:p")<CR>]], md, 'Yank file path')

-- Packer
map('n', '<leader>pC', function ()
    require'packer'.clean()
    print("Packer: clean - finished")
end, md, "Clean")
map('n', '<leader>pc', function ()
    require'packer'.compile()
    print("Packer: compile - finished")
end, md, "Compile")
map('n', '<leader>pi', function ()
    require'packer'.install()
    print("Packer: install: - finished")
end, md, "Install")
map('n', '<leader>pu', function ()
    require'packer'.sync()
    print("Packer: install: - finished")
end, md, "Update")
map('n', '<leader>ps', function ()
    require'packer'.status()
end, md, "Status")

-- Profiling

map('n', '<leader>pS', '<cmd>profile start /tmp/profile_vim.log|profile func *|profile file *<CR>', md, 'Profiling | Start')
map('n', '<leader>pT', '<cmd>profile stop|e /tmp/profile_vim.log|nmap <buffer> q :!rm /tmp/profile_vim.log<CR>', md, 'Profiling | Stop')


-- Replace search
vim.api.nvim_exec([[
nmap <expr>  MR  ':%s/\(' . @/ . '\)/\1/g<LEFT><LEFT>'
vmap <expr>  MR  ':s/\(' . @/ . '\)/\1/g<LEFT><LEFT>'
]], true)


-- Replace without yanking
map('v', 'p', ':<C-U>let @p = @+<CR>gvp:let @+ = @p<CR>', { noremap = true })

-- Tunings
map('n', 'Y', 'y$', { noremap = true })

-- Don't cancel visual select when shifting
map('x', '<', '<gv', { noremap = true })
map('x', '>', '>gv', { noremap = true })

-- Keep the cursor in place while joining lines
map('n', 'J', 'mzJ`z', { noremap = true })

-- [S]plit line (sister to [J]oin lines) S is covered by cc.
map('n', 'S', 'mzi<CR><ESC>`z', { noremap = true })

-- Don't move cursor when searching via *
map('n', '*', ':let stay_star_view = winsaveview()<cr>*:call winrestview(stay_star_view)<CR>', { noremap = true, silent = true })

-- Keep search matches in the middle of the window.
map('n', 'n', 'nzzzv', { noremap = true })
map('n', 'N', 'Nzzzv', { noremap = true })

-- Smart start line
_G.start_line = function(mode)
mode = mode or 'n'
if mode == 'v' then
  vim.api.nvim_exec('normal! gv', false)
elseif mode == 'n' then
else
  print('Unknown mode, using normal.')
end
local cursor = vim.api.nvim_win_get_cursor(vim.api.nvim_get_current_win())
vim.api.nvim_exec('normal ^', false)
local check_cursor = vim.api.nvim_win_get_cursor(vim.api.nvim_get_current_win())
if cursor[2] == check_cursor[2] then
  vim.api.nvim_exec('normal 0', false)
end
end
map('n', 'H', ':lua start_line()<CR>', { noremap = true, silent = true })
map('n', 'L', '$', { noremap = true })
map('v', 'H', [[:lua start_line('v')<CR>]], { noremap = true, silent = true })
map('v', 'L', '$', { noremap = true })

-- Terminal
vim.cmd [[tnoremap <Esc> <C-\><C-n>]]

return mapping
-- {% endraw %}
