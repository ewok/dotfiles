-- {% raw %}
local setting = {}

vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

local set_options = {
    shell = 'bash';
    backspace = '2';
    backup = false;
    clipboard = 'unnamed,unnamedplus';
    cmdheight = 1;
    compatible = false;
    confirm = true;
    encoding = 'utf-8';
    enc = 'utf-8';
    errorbells = false;
    exrc = true;
    hidden = true;
    history = 1000;
    hlsearch = true;
    ignorecase = true;
    incsearch = true;
    laststatus = 2;
    linespace = 0;
    mouse = '';
    ruler = true;
    scrolloff = 5;
    secure = true;
    shortmess = 'aOtT';
    showmode = true;
    showtabline = 2;
    smartcase = true;
    smarttab = true;
    splitbelow = true;
    splitright = true;
    startofline = false;
    switchbuf = 'useopen';
    termguicolors = true;
    timeoutlen = 500;
    titlestring = '%F';
    title = true;
    ttimeoutlen = -1;
    ttyfast = true;
    undodir = os.getenv('HOME')..'/.vim_undo';
    undolevels = 100;
    updatetime = 300;
    visualbell = true;
    writebackup = false;
    guicursor = 'n-v-c:block,i-ci-ve:block,r-cr:hor20,'..
    'o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,'..
    'sm:block-blinkwait175-blinkoff150-blinkon175';
    shada = [['50,<1000,s100,"10,:10,f0,n]]..vim.fn.stdpath('data')..[[shada/main.shada]];
    inccommand = 'nosplit';

    -- Buf opts
    bomb = false;
    copyindent = true;
    expandtab = true;
    fenc = 'utf-8';
    shiftwidth = 4;
    softtabstop = 4;
    swapfile = false;
    synmaxcol = 1000;
    tabstop = 4;
    undofile = true;

    -- Window opts
    cursorline = true;
    number = true;
    foldenable = false;
    wrap = false;
    list = true;
    -- list = false;
    linebreak = true;
    numberwidth = 2;

    signcolumn = "yes:1";
    pumheight = 10;
    filetype = "plugin";
    smartindent = true;
    iskeyword = "@,48-57,_,192-255";
    fillchars = "eob: ";
    sessionoptions = "buffers,curdir,folds,help,tabpages,winsize,globals";
}

for opt, val in pairs(set_options) do
    local info = vim.api.nvim_get_option_info(opt)
    local scope = info.scope

    vim.o[opt] = val
    if scope == 'win' then
        vim.wo[opt] = val
    elseif scope == 'buf' then
        vim.bo[opt] = val
    elseif scope == 'global' then
    else
        print(opt..' has '..scope.. ' scope?')
    end
end

vim.opt.shortmess:append("sI")
vim.opt.whichwrap:append("<>[]hl")

local disable_builtin_plugins = {
    -- "netrw",
    -- "netrwPlugin",
    "netrwSettings",
    "netrwFileHandlers",
    "2html_plugin",
    "getscript",
    "getscriptPlugin",
    "gzip",
    "logipat",
    "matchit",
    -- "tar",
    -- "tarPlugin",
    "rrhelper",
    "spellfile_plugin",
    "vimball",
    "vimballPlugin",
    -- "zip",
    -- "zipPlugin",
}

for _, builtin_plugin in ipairs(disable_builtin_plugins) do
    vim.g["loaded_" .. builtin_plugin] = 1
end

vim.api.nvim_exec([[
filetype plugin indent on

syntax on
syntax enable

if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

" Dynamic timeoutlen
au InsertEnter * set timeoutlen=1000
au InsertLeave * set timeoutlen=500

" Autresize windows
autocmd VimResized * wincmd =
]], true)

vim.fn.setenv('ZK_NOTEBOOK_DIR', os.getenv('HOME')..'/Notes/')

-- Wildmenu completion {{{
vim.api.nvim_set_option('wildmenu', true)
vim.api.nvim_set_option('wildmode', 'longest,list')

vim.api.nvim_set_option('wildignore', vim.api.nvim_get_option('wildignore')..
'*.o,*.obj,*.pyc,'..
'*.png,*.jpg,*.gif,*.ico,'..
'*.swf,*.fla,'..
'*.mp3,*.mp4,*.avi,*.mkv,'..
'*.git*,*.hg*,*.svn*,'..
'*sass-cache*,'..
'*.DS_Store,'..
'log/**,'..
'tmp/**')

-- auto-reload files when modified externally
-- https://unix.stackexchange.com/a/383044
vim.o.autoread = true
vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "CursorHoldI", "FocusGained" }, {
  command = "if mode() != 'c' | checktime | endif",
  pattern = { "*" },
})

return setting
-- {% endraw %}
