-- > Libs {{{
local map = function(mode, lhs, rhs, options, desc)
    options.desc = desc
    vim.keymap.set(mode, lhs, rhs, options)
end

local function umap(mode, lhs, opts)
    vim.keymap.del(mode, lhs, opts)
end

local path = {}
function path.join(...)
    return table.concat(vim.tbl_flatten({ ... }), "/")
end

local reg_ft = function(ft, fun)
    vim.api.nvim_create_augroup("ft_" .. ft, { clear = true })
    vim.api.nvim_create_autocmd({ "FileType" }, {
        pattern = { ft },
        callback = fun,
        group = "ft_" .. ft,
    })
end
-- }}}
-- > Lib other {{{
local function str_title(s)
    return (s:gsub("(%a)([%w_']*)", function(f, r)
        return f:upper() .. r:lower()
    end))
end

local function get_importable_subfiles(dir)
    local sub_dir = dir:gsub("%.", "/")
    local root_dir = path.join(vim.fn.stdpath("config"), "lua", sub_dir)

    ---@diagnostic disable-next-line: param-type-mismatch
    local file_tbl = vim.fn.globpath(root_dir, "*.lua", false, true)

    for i, v in ipairs(file_tbl) do
        file_tbl[i] = string.format("%s/%s", sub_dir, vim.fn.fnamemodify(v, ":t:r"))
    end

    return file_tbl
end

local function get_all_win_buf_ft()
    local result = {}
    local win_tbl = vim.api.nvim_list_wins()
    for _, win_id in ipairs(win_tbl) do
        if vim.api.nvim_win_is_valid(win_id) then
            local buf_id = vim.api.nvim_win_get_buf(win_id)
            table.insert(result, {
                win_id = win_id,
                buf_id = buf_id,
                buf_ft = vim.api.nvim_buf_get_option(buf_id, "filetype"),
            })
        end
    end
    return result
end

local function get_all_float_win()
    local result = {}
    local win_tbl = vim.api.nvim_list_wins()
    for _, win_id in ipairs(win_tbl) do
        local win_config = vim.api.nvim_win_get_config(win_id)
        if ((win_config.width or 0) > 1) and win_config.relative ~= "" then
            table.insert(result, {
                id = win_id,
                config = win_config,
            })
        end
    end
    return result
end

-- LSP related:

local function scroll_to_up()
    local scroll_floating_filetype = { "lsp-signature-help", "lsp-hover" }

    for _, opts in ipairs(get_all_win_buf_ft()) do
        if vim.tbl_contains(scroll_floating_filetype, opts.buf_ft) then
            local win_height = vim.api.nvim_win_get_height(opts.win_id)
            local cursor_line = vim.api.nvim_win_get_cursor(opts.win_id)[1]
            local buf_total_line = vim.api.nvim_buf_line_count(opts.buf_id)
            ---@diagnostic disable-next-line: redundant-parameter
            local win_first_line = vim.fn.line("w0", opts.win_id)

            if buf_total_line <= win_height or cursor_line == 1 then
                vim.api.nvim_echo({ { "Can't scroll up", "MoreMsg" } }, false, {})
                return
            end

            vim.opt.scrolloff = 0
            if cursor_line > win_first_line then
                if win_first_line - 5 > 1 then
                    vim.api.nvim_win_set_cursor(opts.win_id, { win_first_line - 5, 0 })
                else
                    vim.api.nvim_win_set_cursor(opts.win_id, { 1, 0 })
                end
            elseif cursor_line - 5 < 1 then
                vim.api.nvim_win_set_cursor(opts.win_id, { 1, 0 })
            else
                vim.api.nvim_win_set_cursor(opts.win_id, { cursor_line - 5, 0 })
            end
            -- vim.opt.scrolloff = setting.opt.scrolloff

            return
        end
    end

    local _map = "<c-b>"
    local key = vim.api.nvim_replace_termcodes(_map, true, false, true)
    ---@diagnostic disable-next-line: param-type-mismatch
    vim.api.nvim_feedkeys(key, "n", true)
end

local function scroll_to_down()
    local scroll_floating_filetype = { "lsp-signature-help", "lsp-hover" }

    for _, opts in ipairs(get_all_win_buf_ft()) do
        if vim.tbl_contains(scroll_floating_filetype, opts.buf_ft) then
            local win_height = vim.api.nvim_win_get_height(opts.win_id)
            local cursor_line = vim.api.nvim_win_get_cursor(opts.win_id)[1]
            local buf_total_line = vim.api.nvim_buf_line_count(opts.buf_id)
            ---@diagnostic disable-next-line: redundant-parameter
            local win_last_line = vim.fn.line("w$", opts.win_id)

            if buf_total_line <= win_height or cursor_line == buf_total_line then
                vim.api.nvim_echo({ { "Can't scroll down", "MoreMsg" } }, false, {})
                return
            end

            vim.opt.scrolloff = 0

            if cursor_line < win_last_line then
                if win_last_line + 5 < buf_total_line then
                    vim.api.nvim_win_set_cursor(opts.win_id, { win_last_line + 5, 0 })
                else
                    vim.api.nvim_win_set_cursor(opts.win_id, { buf_total_line, 0 })
                end
            elseif cursor_line + 5 >= buf_total_line then
                vim.api.nvim_win_set_cursor(opts.win_id, { buf_total_line, 0 })
            else
                vim.api.nvim_win_set_cursor(opts.win_id, { cursor_line + 5, 0 })
            end
            -- vim.opt.scrolloff = setting.opt.scrolloff

            return
        end
    end

    local _map = "<c-f>"
    local key = vim.api.nvim_replace_termcodes(_map, true, false, true)
    ---@diagnostic disable-next-line: param-type-mismatch
    vim.api.nvim_feedkeys(key, "n", true)
end

local function focus_float_window()
    local prev_win = {}

    return function()
        if not vim.tbl_isempty(prev_win) and vim.api.nvim_win_is_valid(prev_win.id) then
            vim.fn.win_gotoid(prev_win.id)
            vim.api.nvim_win_set_cursor(prev_win.id, prev_win.cursor)
            if prev_win.mode == "i" then
                vim.cmd([[startinsert]])
            end
            prev_win = {}
            return
        end

        for _, float_win in ipairs(get_all_float_win()) do
            local mode = vim.fn.mode()

            prev_win = {
                id = vim.fn.win_getid(),
                cursor = vim.api.nvim_win_get_cursor(0),
                mode = mode,
            }

            vim.fn.win_gotoid(float_win.id)

            if mode == "i" then
                vim.cmd([[stopinsert]])
            end

            return
        end

        local _map = "<c-]>"
        local key = vim.api.nvim_replace_termcodes(_map, true, false, true)
        ---@diagnostic disable-next-line: param-type-mismatch
        vim.api.nvim_feedkeys(key, "n", true)
    end
end

local function sigature_help()
    -- When the signature is visible, pressing <c-j> again will close the window
    for _, opts in ipairs(get_all_win_buf_ft()) do
        if opts.buf_ft == "lsp-signature-help" then
            vim.api.nvim_win_close(opts.win_id, false)
            return
        end
    end
    vim.lsp.buf.signature_help()
end

local function lsp_hover(_, result, ctx, config)
    -- add file type for LSP hover
    local bufnr, winner = vim.lsp.handlers.hover(_, result, ctx, config)

    if bufnr and winner then
        vim.api.nvim_buf_set_option(bufnr, "filetype", config.filetype)
        return bufnr, winner
    end
end

local function lsp_signature_help(_, result, ctx, config)
    -- add file type for LSP signature help
    local bufnr, winner = vim.lsp.handlers.signature_help(_, result, ctx, config)

    -- put the signature floating window above the cursor
    local current_cursor_line = vim.api.nvim_win_get_cursor(0)[1]
    local ok, win_height = pcall(vim.api.nvim_win_get_height, winner)

    if not ok then
        return
    end

    if current_cursor_line > win_height + 2 then
        ---@diagnostic disable-next-line: param-type-mismatch
        vim.api.nvim_win_set_config(winner, {
            anchor = "SW",
            relative = "cursor",
            row = 0,
            col = -1,
        })
    end

    if bufnr and winner then
        vim.api.nvim_buf_set_option(bufnr, "filetype", config.filetype)
        return bufnr, winner
    end
end

-- CMP related
local function under_compare(entry1, entry2)
    -- decrease priority if suggestion starts with _
    local _, entry1_under = entry1.completion_item.label:find("^_+")
    local _, entry2_under = entry2.completion_item.label:find("^_+")

    entry1_under = entry1_under or 0
    entry2_under = entry2_under or 0

    return entry1_under < entry2_under
end

local function toggle_sidebar(target_ft)
    local offset_ft = {
        "NvimTree",
        "undotree",
        "dbui",
        "spectre_panel",
        "mind",
    }
    for _, opts in ipairs(get_all_win_buf_ft()) do
        if opts.buf_ft ~= target_ft and vim.tbl_contains(offset_ft, opts.buf_ft) then
            vim.api.nvim_win_close(opts.win_id, true)
        end
    end
end

-- }}}
-- > Options {{{
local options = {}

options.transparent = false
options.float_border = true
options.download_source = "https://github.com/"
options.show_winbar = false

options.snippets_directory = path.join(vim.fn.stdpath("config"), "snippets")

-- auto command manager
options.auto_save = true
options.auto_switch_input = false
options.auto_restore_cursor_position = true
options.auto_remove_new_lines_comment = true
options.auto_toggle_rnu = true
options.auto_hide_cursorline = true

-- options.blacklist_bufftypes = {
--     "help",
--     "neo-tree",
--     "nerdtree",
--     "nofile",
--     "nvimtree",
--     "NvimTree",
--     "terminal",
--     "which_key",
--     "mind",
-- }

-- options.blacklist_filetypes = {
--     "coc-explorer",
--     "dashboard",
--     "dashpreview",
--     "help",
--     "neo-tree",
--     "nerdtree",
--     "nofile",
--     "nvimtree",
--     "NvimTree",
--     "packer",
--     "sagahover",
--     "startify",
--     "terminal",
--     "vista",
--     "which_key",
--     "mind,",
-- }

options.colors = {
    color_0 = "#{{@@ colors.color0 @@}}",
    color_1 = "#{{@@ colors.color1 @@}}",
    color_2 = "#{{@@ colors.color2 @@}}",
    color_3 = "#{{@@ colors.color3 @@}}",
    color_4 = "#{{@@ colors.color4 @@}}",
    color_5 = "#{{@@ colors.color5 @@}}",
    color_6 = "#{{@@ colors.color6 @@}}",
    color_7 = "#{{@@ colors.color7 @@}}",
    color_8 = "#{{@@ colors.color8 @@}}",
    color_9 = "#{{@@ colors.color9 @@}}",
    color_10 = "#{{@@ colors.color10 @@}}",
    color_11 = "#{{@@ colors.color11 @@}}",
    color_12 = "#{{@@ colors.color12 @@}}",
    color_13 = "#{{@@ colors.color13 @@}}",
    color_14 = "#{{@@ colors.color14 @@}}",
    color_15 = "#{{@@ colors.color15 @@}}",
    -- color_0 = "#282c34",
    -- color_1 = "#e06c75",
    -- color_2 = "#98c379",
    -- color_3 = "#e5c07b",
    -- color_4 = "#61afef",
    -- color_5 = "#c678dd",
    -- color_6 = "#56b6c2",
    -- color_7 = "#abb2bf",
    -- color_8 = "#545862",
    -- color_9 = "#d19a66",
    -- color_10 = "#353b45",
    -- color_11 = "#3e4451",
    -- color_12 = "#565c64",
    -- color_13 = "#b6bdca",
    -- color_14 = "#be5046",
    -- color_15 = "#c8ccd4",
}

local icons = {}
icons.platform = {
    unix = "",
    dos = "",
    mac = "",
}
icons.diagnostic = {
    Error = "",
    Warn = "",
    Info = "ﬤ",
    Hint = "",
}
icons.tag_level = {
    Fixme = "ﰡ",
    Hack = "ﰠ",
    Warn = "",
    Note = "ﮉ",
    Todo = "ﮉ",
    Perf = "ﮉ",
}
icons.lsp_kind = {
    -- lsp type
    String = "",
    Number = "",
    Boolean = "◩",
    Array = "",
    Object = "",
    Key = "",
    Null = "ﳠ",
    -- lsp kind
    Text = "",
    Method = "",
    Function = "",
    Constructor = "",
    Namespace = "",
    Field = "ﰠ",
    Variable = "ﳋ",
    Class = "",
    Interface = "",
    Module = "ﰪ",
    Property = "",
    Unit = "塞",
    Value = "",
    Enum = "",
    Keyword = "",
    Snippet = "",
    Color = "",
    File = "",
    Reference = "",
    Folder = "",
    EnumMember = "",
    Constant = "",
    Struct = "﬌",
    Event = "",
    Operator = "",
    TypeParameter = "",
}
-- }}}
-- > Settings {{{
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local set_options = {
    shell = "bash",
    backspace = "2",
    backup = false,
    clipboard = "unnamed,unnamedplus",
    cmdheight = 1,
    compatible = false,
    confirm = true,
    encoding = "utf-8",
    enc = "utf-8",
    errorbells = false,
    exrc = true,
    hidden = true,
    history = 1000,
    hlsearch = true,
    ignorecase = true,
    incsearch = true,
    laststatus = 2,
    linespace = 0,
    mouse = "",
    ruler = true,
    scrolloff = 5,
    secure = true,
    shortmess = "aOtT",
    showmode = true,
    showtabline = 2,
    smartcase = true,
    smarttab = true,
    splitbelow = true,
    splitright = true,
    startofline = false,
    switchbuf = "useopen",
    termguicolors = true,
    timeoutlen = 500,
    titlestring = "%F",
    title = true,
    ttimeoutlen = -1,
    ttyfast = true,
    undodir = os.getenv("HOME") .. "/.vim_undo",
    undolevels = 100,
    updatetime = 300,
    visualbell = true,
    writebackup = false,
    guicursor = "n-v-c:block,i-ci-ve:block,r-cr:hor20,"
        .. "o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,"
        .. "sm:block-blinkwait175-blinkoff150-blinkon175",
    shada = [['50,<1000,s100,"10,:10,f0,n]] .. vim.fn.stdpath("data") .. [[shada/main.shada]],
    inccommand = "nosplit",

    -- Buf opts
    bomb = false,
    copyindent = true,
    expandtab = true,
    fenc = "utf-8",
    shiftwidth = 4,
    softtabstop = 4,
    swapfile = false,
    synmaxcol = 1000,
    tabstop = 4,
    undofile = true,

    -- Window opts
    cursorline = true,
    number = true,
    foldenable = false,
    wrap = false,
    list = true,
    -- list = false;
    linebreak = true,
    numberwidth = 2,

    signcolumn = "yes:1",
    pumheight = 10,
    filetype = "plugin",
    smartindent = true,
    iskeyword = "@,48-57,_,192-255",
    fillchars = "eob: ",
    sessionoptions = "buffers,curdir,folds,help,tabpages,winsize,globals",
}

for opt, val in pairs(set_options) do
    local info = vim.api.nvim_get_option_info(opt)
    local scope = info.scope

    vim.o[opt] = val
    if scope == "win" then
        vim.wo[opt] = val
    elseif scope == "buf" then
        vim.bo[opt] = val
    elseif scope == "global" then
    else
        print(opt .. " has " .. scope .. " scope?")
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

vim.api.nvim_exec(
    [[
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
]]   ,
    true
)

vim.fn.setenv("ZK_NOTEBOOK_DIR", os.getenv("HOME") .. "/Notes/")

-- Wildmenu completion {{{
vim.api.nvim_set_option("wildmenu", true)
vim.api.nvim_set_option("wildmode", "longest,list")

vim.api.nvim_set_option(
    "wildignore",
    vim.api.nvim_get_option("wildignore")
    .. "*.o,*.obj,*.pyc,"
    .. "*.png,*.jpg,*.gif,*.ico,"
    .. "*.swf,*.fla,"
    .. "*.mp3,*.mp4,*.avi,*.mkv,"
    .. "*.git*,*.hg*,*.svn*,"
    .. "*sass-cache*,"
    .. "*.DS_Store,"
    .. "log/**,"
    .. "tmp/**"
)
-- }}}

-- auto-reload files when modified externally
-- https://unix.stackexchange.com/a/383044
vim.o.autoread = true
vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "CursorHoldI", "FocusGained" }, {
    command = "if mode() != 'c' | checktime | endif",
    pattern = { "*" },
})
-- }}}
-- > Mapping {{{
local global_md = { noremap = true, silent = false }

-- Navigation
map("n", "<C-O><C-O>", "<C-O>", global_md, "Go Back")
map("n", "<C-O><C-I>", "<Tab>", global_md, "Go Forward")

-- Windows manipulation
map("n", "<C-W>t", "<cmd>tabnew<CR>", global_md, "New Tab")
map(
    "n",
    "<C-W>S",
    vim.fn.exists("$TMUX") == 1 and "<cmd>!tmux split-window -v -p 20<CR><CR>" or "<cmd>split term://bash<CR>i",
    global_md,
    "Split window"
)
map(
    "n",
    "<C-W>V",
    vim.fn.exists("$TMUX") == 1 and "<cmd>!tmux split-window -h -p 20<CR><CR>" or "<cmd>vsplit term://bash<CR>i",
    global_md,
    "VSplit window"
)
map("n", "<C-W><C-J>", ":resize +5<CR>", global_md, "Increase height +5")
map("n", "<C-W><C-K>", ":resize -5<CR>", global_md, "Decrease height -5")
map("n", "<C-W><C-L>", ":vertical resize +5<CR>", global_md, "Increase width +5")
map("n", "<C-W><C-H>", ":vertical resize -5<CR>", global_md, "Decrease width -5")
map("n", "<C-W>q", "<cmd>close<CR>", global_md, "Close window")
map("n", "<C-W><C-Q>", "<cmd>close<CR>", global_md, "Close window")

-- Folding
map("n", "]z", "zjmzzMzvzz15<c-e>`z", global_md, "Next Fold")
map("n", "[z", "zkmzzMzvzz15<c-e>`z", global_md, "Previous Fold")
map("n", "zO", "zczO", global_md, "Open all folds under cursor")
map("n", "zC", "zcV:foldc!<CR>", global_md, "Close all folds under cursor")
map("n", "z<Space>", "mzzMzvzz15<c-e>`z", global_md, "Show only current Fold")
map("n", "<Space><Space>", 'za"{{{"', global_md, "Toggle Fold")

map("x", "<Space><Space>", 'zf"}}}"', global_md, "Toggle Fold")

-- Yank
map("n", "<leader>yy", "<cmd>.w! ~/.vbuf<CR>", global_md, "Yank to ~/.vbuf")
map("n", "<leader>yp", "<cmd>r ~/.vbuf<CR>", global_md, "Paste from ~/.vbuf")
map("x", "<leader>yy", [[:'<,'>w! ~/.vbuf<CR>]], global_md, "Yank to ~/.vbuf")

map("n", "<leader>yfl", [[:let @+=expand("%") . ':' . line(".")<CR>]], global_md, "Yank file name and line")
map("n", "<leader>yfn", [[:let @+=expand("%")<CR>]], global_md, "Yank file name")
map("n", "<leader>yfp", [[:let @+=expand("%:p")<CR>]], global_md, "Yank file path")

-- Profiling
map(
    "n",
    "<leader>pS",
    "<cmd>profile start /tmp/profile_vim.log|profile func *|profile file *<CR>",
    global_md,
    "Profiling | Start"
)
map(
    "n",
    "<leader>pT",
    "<cmd>profile stop|e /tmp/profile_vim.log|nmap <buffer> q :!rm /tmp/profile_vim.log<CR>",
    global_md,
    "Profiling | Stop"
)

-- Replace search
vim.api.nvim_exec(
    [[
nmap <expr>  MR  ':%s/\(' . @/ . '\)/\1/g<LEFT><LEFT>'
vmap <expr>  MR  ':s/\(' . @/ . '\)/\1/g<LEFT><LEFT>'
]]   ,
    true
)

-- Replace without yanking
map("v", "p", ":<C-U>let @p = @+<CR>gvp:let @+ = @p<CR>", global_md)

-- Tunings
map("n", "Y", "y$", global_md)

-- Don't cancel visual select when shifting
map("x", "<", "<gv", global_md)
map("x", ">", ">gv", global_md)

-- Keep the cursor in place while joining lines
map("n", "J", "mzJ`z", global_md)

-- [S]plit line (sister to [J]oin lines) S is covered by cc.
map("n", "S", "mzi<CR><ESC>`z", global_md)

-- Converters
map("v", "<leader>6d", [[c<c-r>=system('base64 --decode', @")<cr><esc>]], global_md)
map("v", "<leader>6e", [[c<c-r>=system('base64 --encode', @")<cr><esc>]], global_md)

-- Don't move cursor when searching via *
-- Implemented in hlslens
-- map(
--     "n",
--     "*",
--     ":let stay_star_view = winsaveview()<cr>*:call winrestview(stay_star_view)<CR>",
--     { noremap = true, silent = true }
-- )

-- Keep search matches in the middle of the window.
-- Implemented in hlslens
-- map("n", "n", "nzzzv", global_md)
-- map("n", "N", "Nzzzv", global_md)

-- Smart start line
-- FIX: wrong behaviour in visual mode
local start_line = function(mode)
    mode = mode or "n"
    if mode == "v" then
        vim.api.nvim_exec("normal! gv", false)
    elseif mode == "n" then
    else
        print("Unknown mode, using normal.")
    end
    local cursor = vim.api.nvim_win_get_cursor(vim.api.nvim_get_current_win())
    vim.api.nvim_exec("normal ^", false)
    local check_cursor = vim.api.nvim_win_get_cursor(vim.api.nvim_get_current_win())
    if cursor[2] == check_cursor[2] then
        vim.api.nvim_exec("normal 0", false)
    end
end
map("n", "H", function()
    start_line()
end, { noremap = true, silent = true })
map("n", "L", "$", { noremap = true })
map("v", "H", "0", { noremap = true, silent = true })
-- map("v", "H", function()
--     start_line("v")
-- end, { noremap = true, silent = true })
map("x", "L", "$", { noremap = true })

-- Terminal
vim.cmd([[tnoremap <Esc> <C-\><C-n>]])
-- }}}
-- > Filetypes {{{
-- >> Quit {{{
for _, x in pairs({ "fugitive", "fugitiveblame", "git", "help", "replacer", "spectre_panel" }) do
    reg_ft(x, function()
        map("n", "q", ":close<cr>", { silent = true, buffer = true }, "Close")
    end)
end
-- }}}
-- >> Ansible {{{
reg_ft("kkk", function()
    vim.opt_local.expandtab = true
    vim.opt_local.shiftwidth = 2
    vim.opt_local.tabstop = 2
    vim.opt_local.softtabstop = 2
end)
-- }}}
-- >> Clojure {{{
reg_ft("clojure", function()
    local _buffer = vim.api.nvim_get_current_buf()
    require("which-key").register({
        c = { name = "Connect[conjure]" },
        ec = { name = "Eval Comment[conjure]" },
        e = { name = "Eval[conjure]" },
        l = { name = "Log[conjure]" },
        r = { name = "Refresh[conjure]" },
        s = { name = "Session[conjure]" },
        t = { name = "Test[conjure]" },
        v = { name = "View[conjure]" },
    }, { prefix = "<leader>c", mode = "n", buffer = _buffer })
end)
-- }}}
-- >> Conf {{{
reg_ft("conf", function()
    vim.opt_local.expandtab = true
    vim.opt_local.shiftwidth = 2
    vim.opt_local.tabstop = 2
    vim.opt_local.softtabstop = 2
end)
-- }}}
-- >> Go {{{
reg_ft("go", function()
    vim.opt_local.expandtab = false
    vim.opt_local.shiftwidth = 4
    vim.opt_local.tabstop = 4
    vim.opt_local.softtabstop = 4
end)
-- }}}
-- >> Fennel {{{
reg_ft("fennel", function()
    local _buffer = vim.api.nvim_get_current_buf()
    map("n", "<leader>cf", ":!fnlfmt --fix %<cr><cr>", { buffer = _buffer, silent = true }, "Formatting[fnlfmt]")
    require("which-key").register({
        ec = { name = "Eval Comment[conjure]" },
        e = { name = "Eval[conjure]" },
        l = { name = "Log[conjure]" },
        r = { name = "Reset[conjure]" },
        t = { name = "Test[conjure]" },
    }, { prefix = "<leader>c", mode = "n", buffer = _buffer })
end)
-- }}}
-- >> Helm {{{
reg_ft("helm", function()
    map("n", "<leader>cr", function()
        vim.cmd([[write]])
        api.nvim_command("!helm template ./ --output-dir .out")
    end, { noremap = true }, "Render Helm")
end)
-- }}}
-- >> Json {{{
reg_ft("json", function()
    vim.opt_local.expandtab = true
    vim.opt_local.shiftwidth = 2
    vim.opt_local.tabstop = 2
    vim.opt_local.softtabstop = 2
end)
-- }}}
-- >> Ledger {{{
reg_ft("ledger", function()
    vim.opt_local.expandtab = true
    vim.opt_local.shiftwidth = 4
    vim.opt_local.tabstop = 4
    vim.opt_local.softtabstop = 4
    vim.opt_local.foldmethod = "marker"
    vim.opt_local.foldmarker = "{{{,}}}"
    vim.opt_local.commentstring = "; %s"
    -- vim.opt_local.foldexpr = "nvim_treesitter#foldexpr()"
end)
-- }}}
-- >> Lua {{{
reg_ft("lua", function()
    vim.opt_local.expandtab = true
    vim.opt_local.shiftwidth = 4
    vim.opt_local.tabstop = 4
    vim.opt_local.softtabstop = 4
    vim.opt_local.foldmethod = "marker"
    vim.opt_local.foldmarker = "{{{,}}}"
    -- vim.opt_local.foldexpr = "nvim_treesitter#foldexpr()"
    local _buffer = vim.api.nvim_get_current_buf()
    require("which-key").register({
        e = { name = "Eval[conjure]" },
        l = { name = "Log[conjure]" },
        r = { name = "Reset[conjure]" },
        -- h = { name = "Help[conjure]" },
    }, { prefix = "<leader>c", mode = "n", buffer = _buffer })
end)
-- }}}
-- >> Markdown {{{
reg_ft("markdown", function()
    vim.opt_local.expandtab = true
    vim.opt_local.shiftwidth = 4
    vim.opt_local.tabstop = 4
    vim.opt_local.softtabstop = 4
    -- vim.opt_local.foldmethod = "expr"
    -- vim.opt_local.foldexpr = "nvim_treesitter#foldexpr()"

    vim.wo.foldlevel = 2
    vim.wo.conceallevel = 2

    local md = { noremap = true, silent = true, buffer = true }

    map("n", "<leader>cb", "<cmd>EvalBlock<CR>", md, "Run Block")
    map("n", "<CR>", "<Cmd>lua vim.lsp.buf.definition()<CR>", md, "Open Link")
    map("v", "<CR>", ":'<,'>ZkNewFromTitleSelection { dir = vim.fn.expand('%:p:h') }<CR>", md, "Create Link")

    map("n", "<leader>wb", "<Cmd>ZkBacklinks<CR>", { silent = true }, "Backlinks")
    map("n", "<leader>wl", "<Cmd>ZkLinks<CR>", { silent = true }, "Links")
end)
-- }}}
-- >> Mysql {{{
reg_ft("mysql", function()
    vim.opt_local.expandtab = true
    vim.opt_local.shiftwidth = 2
    vim.opt_local.tabstop = 2
    vim.opt_local.softtabstop = 2
end)
-- }}}
-- >> Python {{{
reg_ft("python", function()
    vim.opt_local.expandtab = true
    vim.opt_local.shiftwidth = 4
    vim.opt_local.tabstop = 4
    vim.opt_local.softtabstop = 4
    local _buffer = vim.api.nvim_get_current_buf()
    require("which-key").register({
        c = { name = "Connect[conjure]" },
        e = { name = "Eval[conjure]" },
        l = { name = "Log[conjure]" },
        -- h = { name = "Help[conjure]" },
    }, { prefix = "<leader>c", mode = "n", buffer = _buffer })
end)
-- }}}
-- >> QF {{{
reg_ft("qf", function()
    map("n", "q", ":cclose<cr>", { silent = true, buffer = true }, "Close")
    map("n", "r", function()
        require("replacer").run()
    end, { silent = true, buffer = true }, "Replace")
    map("n", "<leader>r", function()
        require("replacer").run()
    end, { silent = true, buffer = true }, "Replace")

    map("n", "]c", ":cnext|wincmd p<cr>", { silent = true, buffer = true }, "Next C item")
    map("n", "[c", ":cprevious|wincmd p<cr>", { silent = true, buffer = true }, "Previous C item")

    map("n", "]l", ":lnext|wincmd p<cr>", { silent = true, buffer = true }, "Next L item")
    map("n", "[l", ":lprevious|wincmd p<cr>", { silent = true, buffer = true }, "Previous L item")
end)
-- }}}
-- >> Sbt {{{
reg_ft("sbt", function()
    -- local aux_lspconfig = require("utils.aux.lspconfig")
    -- local metals = require("metals")
    --
    -- metals.initialize_or_attach(aux_lspconfig.metals_config())
end)
-- }}}
-- >> Scala {{{
reg_ft("scala", function()
    -- local aux_lspconfig = require("utils.aux.lspconfig")
    -- local metals = require("metals")
    --
    -- metals.initialize_or_attach(aux_lspconfig.metals_config())
end)
-- }}}
-- >> SH {{{
reg_ft("sh", function()
    vim.opt_local.expandtab = true
    vim.opt_local.shiftwidth = 2
    vim.opt_local.tabstop = 2
    vim.opt_local.softtabstop = 2
end)
-- }}}
-- >> SQL {{{
reg_ft("sql", function()
    vim.opt_local.expandtab = true
    vim.opt_local.shiftwidth = 2
    vim.opt_local.tabstop = 2
    vim.opt_local.softtabstop = 2
end)
-- }}}
-- >> Terraform {{{
reg_ft("terraform", function()
    map(
        "n",
        "<leader>cf",
        "<CMD>TerraformFmt<CR>",
        { noremap = true, buffer = vim.api.nvim_get_current_buf() },
        "Format buffer[vim-terraform]"
    )
end)
-- }}}
-- >> TXT {{{
reg_ft("txt", function()
    vim.opt_local.expandtab = true
    vim.opt_local.shiftwidth = 4
    vim.opt_local.tabstop = 4
    vim.opt_local.softtabstop = 4
end)
-- }}}
-- >> Vim {{{
reg_ft("vim", function()
    vim.opt_local.expandtab = true
    vim.opt_local.shiftwidth = 4
    vim.opt_local.tabstop = 4
    vim.opt_local.softtabstop = 4
    vim.opt_local.foldmethod = "expr"
    -- vim.opt_local.foldexpr = "nvim_treesitter#foldexpr()"
end)
-- }}}
-- >> Yaml {{{
reg_ft("yaml", function()
    vim.opt_local.expandtab = true
    vim.opt_local.shiftwidth = 2
    vim.opt_local.tabstop = 2
    vim.opt_local.softtabstop = 2
end)
reg_ft("yml", function()
    vim.opt_local.expandtab = true
    vim.opt_local.shiftwidth = 2
    vim.opt_local.tabstop = 2
    vim.opt_local.softtabstop = 2
end)
-- }}}
-- }}}
-- > Plugins {{{
-- >> Mapping {{{
map("n", "<leader>pu", "<CMD>Lazy sync<CR>", { silent = true, noremap = true }, "Sync Packages")
map("n", "<leader>pl", "<CMD>Lazy home<CR>", { silent = true, noremap = true }, "List Packages")
-- }}}
-- >> Lazy bootstrap {{{
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "--single-branch",
        "https://github.com/folke/lazy.nvim.git",
        lazypath,
    })
end

vim.opt.runtimepath:prepend(lazypath)
local plugins = {}
plugins = {
    --- }}}
    -- >> Basic {{{
    "tpope/vim-repeat", -- {{{
    -- }}}
    "nvim-lua/plenary.nvim", -- {{{
    -- }}}
    "kyazdani42/nvim-web-devicons", -- {{{
    -- }}}
    {
        "rcarriga/nvim-notify", -- {{{
        init = function()
            map("n", "<leader>fn", ":Notifications<cr>", { silent = true }, "Find notices history")
        end,
        config = function()
            local notify = require("notify")

            local echo_message = {
                -- DAP
                "could not find file",
                "Debug adapter disconnected",
                "No stopped threads. Cannot move",
                -- TODO-command
                "Invalid buffer id: %d*",
            }

            local ignore_message = {
                -- navic
                'nvim%-navic: Server ".*" does not support documentSymbols.',
                -- LSP
                "%[LSP%]%[.+%] timeout",
                "LSP%[id=%d*%] client has shut down after sending Log",
                "LSP%[id=%d*%] client has shut down during progress update",
                "LSP%[id=%d*%] client has shut down while creating progress report",
                "LSP%[%d*%] client has shut down after sending a workspace/configuration request",
                "method textDocument/signatureHelp is not supported by any of the servers registered for the current buffer",
                "method textDocument/documentSymbol is not supported by any of the servers registered for the current buffer",
            }

            local notify_options = {
                background_colour = "#000000",
                stages = "fade",
                timeout = 3000,
                fps = 120,
                icons = {
                    ERROR = icons.Error,
                    WARN = icons.Warn,
                    INFO = icons.Hint,
                },
            }

            if options.transparent then
                notify_options.background_colour = "#1E1E2E"
            end

            notify.setup(notify_options)

            vim.notify = setmetatable({}, {
                ---@diagnostic disable-next-line: unused-local
                __call = function(self, message, ...)
                    for _, v in ipairs(ignore_message) do
                        if message:match(v) then
                            return
                        end
                    end

                    for _, v in ipairs(echo_message) do
                        if message:match(v) then
                            vim.api.nvim_echo({ { message, "MoreMsg" } }, false, {})
                            return
                        end
                    end

                    return notify(message, ...)
                end,

                __index = notify,
            })
        end,
        -- }}}
    },
    {
        "williamboman/mason.nvim", -- {{{
        dependencies = { "nvim-notify" },
        config = function()
            local mason = require("mason")
            local mason_registry = require("mason-registry")

            mason.setup({
                max_concurrent_installers = 20,
                ui = {
                    border = options.float_border and "double" or "none",
                    icons = {
                        package_installed = "",
                        package_pending = "",
                        package_uninstalled = "",
                    },
                },
                github = {
                    download_url_template = options.download_source .. "%s/releases/download/%s/%s",
                },
            })

            local installer_resources = {
                lsp = {
                    "ansible-language-server",
                    "bash-language-server",
                    "clojure-lsp",
                    "fennel-language-server",
                    -- "gopls",
                    "jq",
                    "json-lsp",
                    "lua-language-server",
                    "pyright",
                    "rnix-lsp",
                    "terraform-ls",
                    "vim-language-server",
                    "zk",
                },
                dap = {
                    -- "delve",
                    "debugpy",
                },
                linter = {
                    "pylint",
                    "codespell",
                    "hadolint",
                    "mypy",
                    "tflint",
                },
                formatter = {
                    "shfmt",
                    "autopep8",
                    "prettier",
                    "sql-formatter",
                    "stylua",
                },
            }

            local installed_resources = {}

            for _, resource_tbl in pairs(installer_resources) do
                for _, resource_name in pairs(resource_tbl) do
                    if not mason_registry.is_installed(resource_name) then
                        local ok, resource = pcall(mason_registry.get_package, resource_name)
                        if ok then
                            resource:install()
                            table.insert(installed_resources, resource_name)
                        else
                            vim.notify(
                                string.format("Invalid resource name %s", resource_name),
                                "ERROR",
                                { title = "Mason" }
                            )
                        end
                    end
                end
            end

            if not vim.tbl_isempty(installed_resources) then
                vim.notify(
                    string.format("Install resource: \n - %s", table.concat(installed_resources, "\n - ")),
                    "INFO",
                    { title = "Mason" }
                )
            end

        end,
        -- }}}
    },
    {
        "nvim-treesitter/nvim-treesitter", -- {{{
        build = { "<CMD>TSUpdate<CR>" },
        config = function()
            local configs = require("nvim-treesitter.configs")
            local parsers = require("nvim-treesitter.parsers")

            local default_source = "https://github.com/"

            if options.download_source ~= default_source then
                for _, config in pairs(parsers.get_parser_configs()) do
                    config.install_info.url = config.install_info.url:gsub(default_source, options.download_source)
                end
            end

            configs.setup({
                ensure_installed = "all",
                ignore_install = {
                    "ada",
                    "agda",
                    "arduino",
                    "astro",
                    "bibtex",
                    "blueprint",
                    "capnp",
                    "chatito",
                    "cooklang",
                    "css",
                    "cuda",
                    "ebnf",
                    "eex",
                    "elixir",
                    "elm",
                    "elsa",
                    "elvish",
                    "erlang",
                    "foam",
                    "fortran",
                    "fsh",
                    "func",
                    "fusion",
                    "gdscript",
                    "gleam",
                    "glimmer",
                    "glsl",
                    "hack",
                    "heex",
                    "hlsl",
                    "hocon",
                    "kdl",
                    "kotlin",
                    "lalrpop",
                    "m68k",
                    "menhir",
                    "mermaid",
                    "meson",
                    "ninja",
                    "ocaml",
                    "ocaml_interface",
                    "ocamllex",
                    "pascal",
                    "php",
                    "phpdoc",
                    "pioasm",
                    "poe_filter",
                    "prisma",
                    "pug",
                    "qmljs",
                    "r",
                    "racket",
                    "rego",
                    "rnoweb",
                    "ron",
                    "ruby",
                    "scss",
                    "slint",
                    "smali",
                    "smithy",
                    "solidity",
                    "supercollider",
                    "surface",
                    "svelte",
                    "swift",
                    "sxhkdrc",
                    "t32",
                    "thrift",
                    "tiger",
                    "tlaplus",
                    "tsx",
                    "turtle",
                    "twig",
                    "typescript",
                    "v",
                    "verilog",
                    "vhs",
                    "wgsl",
                    "wgsl_bevy",
                    "yang",
                    "zig",
                },
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                },
                indent = {
                    enable = true,
                    disable = { "yaml", "python", "html", "vue" },
                },
                -- incremental selection
                incremental_selection = {
                    enable = false,
                    keymaps = {
                        init_selection = "<cr>",
                        node_incremental = "<cr>",
                        node_decremental = "<bs>",
                        scope_incremental = "<tab>",
                    },
                },
                -- nvim-ts-rainbow
                rainbow = {
                    enable = true,
                    extended_mode = true,
                    -- Do not enable for files with more than 1000 lines, int
                    max_file_lines = 1000,
                },
                -- nvim-ts-autotag
                autotag = {
                    enable = true,
                },
                -- nvim-ts-context-commentstring
                context_commentstring = {
                    enable = true,
                    enable_autocmd = false,
                },
            })
        end,
        -- }}}
    },
    -- }}}
    -- >> Theme {{{
    {
        "NTBBloodbath/doom-one.nvim", -- {{{
        init = function()
            vim.g.doom_one_terminal_colors = true
            vim.g.doom_one_italic_comments = true
            vim.g.doom_one_enable_treesitter = true
            -- vim.g.doom_one_plugin_neorg = true
            -- vim.g.doom_one_plugin_barbar = false
            vim.g.doom_one_plugin_telescope = true
            -- vim.g.doom_one_plugin_neogit = true
            vim.g.doom_one_plugin_nvim_tree = true
            -- vim.g.doom_one_plugin_dashboard = true
            -- vim.g.doom_one_plugin_startify = true
            vim.g.doom_one_plugin_whichkey = true
            vim.g.doom_one_plugin_indent_blankline = true
            vim.g.doom_one_plugin_vim_illuminate = true
            -- vim.g.doom_one_plugin_lspsaga = false
        end,
        config = function()
            -- if options.overlength then
            --     vim.api.nvim_exec([[
            --         " Mark 80-th character
            --         hi! OverLength ctermbg=168 guibg=${color_14} ctermfg=250 guifg=${color_0}
            --         call matchadd('OverLength', '\%81v', 100)
            --       ]] % colors, true)
            -- end
            vim.cmd([[ colorscheme doom-one]])
        end,
        -- }}}
    },
    -- }}}
    -- >> LSP {{{
    "williamboman/mason-lspconfig.nvim", -- {{{
    -- }}}
    {
        "SmiteshP/nvim-navic", -- {{{
        config = function()
            local nvim_navic = require("nvim-navic")
            nvim_navic.setup({
                icons = icons,
                highlight = true,
                separator = " > ",
            })

            if not options.show_winbar then
                return
            end

            local ignore_filetype = {
                "",
                "dap-repl",
                "markdown",
            }
            vim.api.nvim_create_autocmd(
                { "DirChanged", "CursorMoved", "BufWinEnter", "BufFilePost", "InsertEnter", "BufNewFile" },
                {
                    callback = function()
                        if not vim.bo.buflisted or vim.tbl_contains(ignore_filetype, vim.bo.filetype) then
                            vim.opt_local.winbar = ""
                            return
                        end
                        vim.opt_local.winbar = "%{%v:lua.require('nvim-navic').get_location()%}"
                    end,
                }
            )
        end,
        -- }}}
    },
    {
        "stevearc/aerial.nvim", -- {{{
        config = function()
            local aerial = require("aerial")
            aerial.setup({
                icons = icons,
                layout = {
                    min_width = 35,
                },
                show_guides = true,
                backends = { "lsp", "treesitter", "markdown" },
                update_events = "TextChanged,InsertLeave",
                ---@diagnostic disable-next-line: unused-local
                on_attach = function(bufnr)
                    map("n", "<leader>2", "<cmd>AerialToggle! right<cr>", { silent = true }, "Open Outilne Explorer")
                    map("n", "{", function()
                        aerial.prev()
                    end, { silent = true }, "Move item up")
                    map("n", "}", function()
                        aerial.next()
                    end, { silent = true }, "Move item down")
                    map("n", "[[", function()
                        aerial.prev_up()
                    end, { silent = true }, "Move up one level")
                    map("n", "]]", function()
                        aerial.next_up()
                    end, { silent = true }, "Move down one level")
                end,
                lsp = {
                    diagnostics_trigger_update = false,
                    update_when_errors = true,
                    update_delay = 300,
                },
                guides = {
                    mid_item = "├─",
                    last_item = "└─",
                    nested_top = "│ ",
                    whitespace = "  ",
                },
                filter_kind = {
                    "Module",
                    "Struct",
                    "Interface",
                    "Class",
                    "Constructor",
                    "Enum",
                    "Function",
                    "Method",
                },
            })
        end,
        -- }}}
    },
    {
        "neovim/nvim-lspconfig", -- {{{
        init = function()
            map("n", "<leader>li", "<cmd>LspInfo<CR>", { noremap = true }, "Info")
            map("n", "<leader>ls", "<cmd>LspStart<CR>", { noremap = true }, "Start")
            map("n", "<leader>lS", "<cmd>LspStop<CR>", { noremap = true }, "Stop")
            map("n", "<leader>lr", "<cmd>LspRestart<CR>", { noremap = true }, "Restart")
            map("n", "<leader>ll", "<cmd>LspLog<CR>", { noremap = true }, "Log")
        end,
        config = function()
            local lspconfig = require("lspconfig")
            local nvim_navic = require("nvim-navic")
            local mason_lspconfig = require("mason-lspconfig")

            -- Basic quickset {{{
            local lsp_handlers = {
                -- ["textDocument/hover"] = vim.lsp.with(lsp_hover, {
                --     border = options.float_border and "rounded" or "none",
                --     filetype = "lsp-hover",
                -- }),
                -- ["textDocument/signatureHelp"] = vim.lsp.with(lsp_signature_help, {
                --     border = options.float_border and "rounded" or "none",
                --     filetype = "lsp-signature-help",
                -- }),
            }

            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities.textDocument.completion.completionItem = {
                documentationFormat = { "markdown", "plaintext" },
                snippetSupport = true,
                preselectSupport = true,
                insertReplaceSupport = true,
                labelDetailsSupport = true,
                deprecatedSupport = true,
                commitCharactersSupport = true,
                tagSupport = { valueSet = { 1 } },
                resolveSupport = {
                    properties = {
                        "documentation",
                        "detail",
                        "additionalTextEdits",
                    },
                },
            }

            -- set diagnostic style
            vim.diagnostic.config({
                signs = true,
                underline = true,
                severity_sort = true,
                update_in_insert = false,
                float = { source = "always" },
                virtual_text = { prefix = "●", source = "always" },
            })

            -- FIXME: Something wrong here
            -- for _type, _icon in pairs(icons) do
            --     local hl = "DiagnosticSign" .. _type
            --     vim.fn.sign_define(hl, { text = _icon, texthl = hl, numhl = hl })
            -- end

            -- lspconfig float window set border
            local win = require("lspconfig.ui.windows")
            local _default_opts = win.default_opts

            ---@diagnostic disable-next-line: redefined-local
            win.default_opts = function(opts)
                local default_opts1 = _default_opts(opts)
                default_opts1.border = options.float_border and "double" or "none"
                return default_opts1
            end
            -- }}}

            local register_key = function(client, bufnr)
                local _md = { silent = false, buffer = bufnr }

                if client.server_capabilities.codeActionProvider then
                    map("n", "<leader>ca", function()
                        vim.lsp.buf.code_action()
                    end, _md, "Show code action[LSP]")
                end
                -- print(vim.inspect(client.server_capabilities))
                if client.server_capabilities.renameProvider then
                    map("n", "<leader>cn", function()
                        vim.lsp.buf.rename()
                    end, _md, "Variable renaming[LSP]")
                end
                if client.server_capabilities.documentFormattingProvider then
                    map("n", "<leader>cf", function()
                        vim.lsp.buf.format()
                    end, _md, "Format buffer[LSP]")
                end
                if client.server_capabilities.hoverProvider then
                    -- map("n", "gh", function()
                    --     vim.lsp.buf.hover()
                    -- end, _md, "Show help information[LSP]")
                    map("n", "K", function()
                        vim.lsp.buf.hover()
                    end, _md, "Show help information[LSP]")
                end
                if client.server_capabilities.referencesProvider then
                    map("n", "gr", function()
                        require("telescope.builtin").lsp_references()
                    end, _md, "Go to references[LSP]")
                end
                if client.server_capabilities.implementationProvider then
                    map("n", "gI", function()
                        require("telescope.builtin").lsp_implementations()
                    end, _md, "Go to implementations[LSP]")
                end
                if client.server_capabilities.definitionProvider then
                    map("n", "gd", function()
                        require("telescope.builtin").lsp_definitions()
                    end, _md, "Go to definitions[LSP]")
                end
                -- FIXME: This is not working
                -- -- if client.resolved_capabilities.type_definition then
                -- map("n", "gD", function()
                --     require("telescope.builtin").lsp_type_definitions()
                -- end, _md, "Go to type definitions[LSP]")
                -- -- end
                if client.server_capabilities.declarationProvider then
                    map("n", "gD", function()
                        require("telescope.builtin").lsp_declaration()
                    end, _md, "Go to type definitions[LSP]")
                end
                map("n", "gO", function()
                    require("telescope.builtin").diagnostics()
                end, _md, "Show Workspace Diagnostics[LSP]")
                map("n", "go", function()
                    vim.diagnostic.open_float({ border = options.float_border and "rounded" or "none" })
                end, _md, "Show Current Diagnostics[LSP]")
                map("n", "[d", function()
                    vim.diagnostic.goto_prev({ float = { border = options.float_border and "rounded" or "none" } })
                end, _md, "Jump to prev diagnostic[LSP]")
                map("n", "]d", function()
                    vim.diagnostic.goto_next({ float = { border = options.float_border and "rounded" or "none" } })
                end, _md, "Jump to next diagnostic[LSP]")

                map("i", "<c-b>", scroll_to_up, _md, "Scroll up floating window[LSP]")
                map("i", "<c-f>", scroll_to_down, _md, "Scroll down floating window[LSP]")
                map("i", "<c-]>", focus_float_window(), _md, "Focus floating window[LSP]")

                -- if client.resolved_capabilities.signature_help then
                map("i", "<c-j>", sigature_help, _md, "Toggle signature help[LSP]")
                -- end
            end

            for _, server_name in ipairs(mason_lspconfig.get_installed_servers()) do
                local ok, settings = pcall(require, ("lsp.server_configurations.%s"):format(server_name))

                if not ok then
                    settings = {}
                end

                settings.capabilities = capabilities
                settings.handlers = vim.tbl_deep_extend("force", lsp_handlers, settings.handlers or {})

                settings.on_attach = function(client, bufnr)
                    register_key(client, bufnr)
                    -- M.aerial.on_attach(client, bufnr)
                    nvim_navic.attach(client, bufnr)
                    -- client.server_capabilities.documentFormattingProvider = false
                end

                lspconfig[server_name].setup(settings)
            end
        end,
        -- }}}
    },
    {
        "j-hui/fidget.nvim", -- {{{
        config = {
            window = {
                blend = 0,
            },
            sources = {
                pyright = {
                    ignore = true,
                },
            },
        },
        -- }}}
    },
    {
        "kosayoda/nvim-lightbulb", -- {{{
        config = function()
            local nvim_lightbulb = require("nvim-lightbulb")
            nvim_lightbulb.setup({
                ignore = {},
                sign = {
                    enabled = true,
                    priority = 15,
                },
                float = {
                    enabled = false,
                    text = "💡",
                    win_opts = {},
                },
                virtual_text = {
                    enabled = false,
                    text = "💡",
                    hl_mode = "replace",
                },
                status_text = {
                    enabled = false,
                    text = "💡",
                    text_unavailable = "",
                },
            })
            -- set the highlight in the symbol column
            vim.fn.sign_define(
                "LightBulbSign",
                { text = "💡", texthl = "DiagnosticSignWarn", linehl = "", numhl = "" }
            )

            -- create an autocommand that displays a small light bulb when code actions are available
            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                pattern = { "*" },
                callback = function()
                    nvim_lightbulb.update_lightbulb()
                end,
            })
        end,
        -- }}}
    },
    {
        "jose-elias-alvarez/null-ls.nvim", -- {{{
        config = function()
            local null_ls = require("null-ls")
            local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
            null_ls.setup({
                sources = {
                    null_ls.builtins.formatting.terraform_fmt,
                    null_ls.builtins.formatting.gofmt,
                    null_ls.builtins.formatting.shfmt,
                    null_ls.builtins.formatting.prettier,
                    null_ls.builtins.formatting.autopep8,
                    null_ls.builtins.formatting.sql_formatter,
                    null_ls.builtins.formatting.stylua.with({
                        extra_args = {
                            "--indent-type=Spaces",
                            "--indent-width=4",
                        },
                    }),
                    -- M.null_ls.builtins.diagnostics.pylint.with({
                    --     extra_args = {
                    --         "-f",
                    --         "json",
                    --         "--load-plugins=pylint_django",
                    --         "--disable=django-not-configured",
                    --         "--rcfile=" .. api.path.join(options.lint_directory, "pylint.conf"),
                    --     },
                    -- }),
                },
            })
        end,
        -- }}}
    },
    -- }}}
    -- >> CMP {{{
    -- >>> CMP -Plugins {{{
    "hrsh7th/cmp-vsnip",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/cmp-calc",
    "PaterJason/cmp-conjure",
    -- }}}
    "kristijanhusak/vim-dadbod-completion", -- {{{
    -- }}}
    {
        "rafamadriz/friendly-snippets", -- {{{
        event = { "InsertEnter", "CmdlineEnter" },
        -- }}}
    },
    {
        "hrsh7th/vim-vsnip", -- {{{
        config = function()
            vim.g.vsnip_snippet_dir = options.snippets_directory
            vim.g.vsnip_filetypes = {
                javascript = { "typescript" },
                typescript = { "javascript" },
                vue = { "javascript", "typescript" },
            }
            vim.cmd([[
                  imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
                  smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
                  imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
                  smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
            ]])
        end,
        -- }}}
    },
    {
        "hrsh7th/nvim-cmp", -- {{{
        config = function()
            local cmp = require("cmp")
            local types = require("cmp.types")

            local complete_window_settings = {
                fixed = true,
                min_width = 20,
                max_width = 40,
            }

            local duplicate_keywords = {
                -- allow duplicate keywords
                ["vsnip"] = 1,
                ["nvim_lsp"] = 1,
                -- do not allow duplicate keywords
                ["buffer"] = 0,
                ["path"] = 0,
                ["cmdline"] = 0,
                ["vim-dadbod-completion"] = 0,
                ["conjure"] = 0,
            }

            local cmp_config_opts = {
                -- uncheck auto-select (gopls)
                preselect = types.cmp.PreselectMode.None,
                -- Insert or Replace
                confirmation = {
                    default_behavior = cmp.ConfirmBehavior.Insert,
                },
                snippet = {
                    expand = function(args)
                        vim.fn["vsnip#anonymous"](args.body)
                    end,
                },
                -- define completion source
                sources = cmp.config.sources({
                    { name = "calc" },
                    { name = "vsnip" },
                    { name = "nvim_lsp" },
                    { name = "conjure" },
                    { name = "path" },
                    { name = "buffer" },
                    -- { name = "cmdline" },
                    { name = "vim-dadbod-completion" },
                }),
                -- define buttons
                -- • i: valid in insert mode
                -- • s: valid in select mode
                -- • c: effective in command mode
                -- if you don't want to auto-complete when selecting, then fill in the following content in the item selection
                -- { behavior = M.cmp.SelectBehavior.Select }
                mapping = {
                    ["<cr>"] = cmp.mapping(cmp.mapping.confirm(), { "i", "s", "c" }),
                    ["<c-p>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "s", "c" }),
                    ["<c-n>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "s", "c" }),
                    ["<c-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-5), { "i", "s", "c" }),
                    ["<c-f>"] = cmp.mapping(cmp.mapping.scroll_docs(5), { "i", "s", "c" }),
                    ["<c-u>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            ---@diagnostic disable-next-line: unused-local
                            for i = 1, 5, 1 do
                                cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
                            end
                        else
                            fallback()
                        end
                    end, { "i", "s", "c" }),
                    ["<c-d>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            ---@diagnostic disable-next-line: unused-local
                            for i = 1, 5, 1 do
                                cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
                            end
                        else
                            fallback()
                        end
                    end, { "i", "s", "c" }),
                    ["<c-k>"] = cmp.mapping(function()
                        if cmp.visible() then
                            cmp.abort()
                        else
                            cmp.complete()
                        end
                    end, { "i", "s", "c" }),
                },
                -- define sorting rules
                sorting = {
                    priority_weight = 2,
                    comparators = {
                        cmp.config.compare.offset,
                        cmp.config.compare.exact,
                        cmp.config.compare.score,
                        under_compare,
                        cmp.config.compare.kind,
                        cmp.config.compare.sort_text,
                        cmp.config.compare.length,
                        cmp.config.compare.order,
                        -- aux_cmp.source_compare,
                        -- aux_cmp.kind_compare,
                    },
                },
                -- define the style of menu completion options
                formatting = {
                    format = function(entry, vim_item)
                        local kind = vim_item.kind
                        local source = entry.source.name

                        vim_item.kind = string.format("%s %s", icons[kind], kind)
                        vim_item.menu = string.format("<%s>", string.upper(source))
                        vim_item.dup = duplicate_keywords[source] or 0

                        -- determine if it is a fixed window size
                        if complete_window_settings.fixed and vim.fn.mode() == "i" then
                            local label = vim_item.abbr
                            local min_width = complete_window_settings.min_width
                            local max_width = complete_window_settings.max_width
                            local truncated_label = vim.fn.strcharpart(label, 0, max_width)

                            if truncated_label ~= label then
                                vim_item.abbr = string.format("%s %s", truncated_label, "…")
                            elseif string.len(label) < min_width then
                                local padding = string.rep(" ", min_width - string.len(label))
                                vim_item.abbr = string.format("%s %s", label, padding)
                            end
                        end

                        return vim_item
                    end,
                },
            }

            if options.float_border then
                -- define the appearance of the completion menu
                cmp_config_opts.window = {
                    completion = cmp.config.window.bordered({
                        winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
                    }),
                    documentation = cmp.config.window.bordered({
                        winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
                    }),
                }
            end

            cmp.setup(cmp_config_opts)

            -- define completion in cmd mode
            cmp.setup.cmdline("/", {
                sources = {
                    { name = "buffer" },
                },
            })

            cmp.setup.cmdline("?", {
                sources = {
                    { name = "buffer" },
                },
            })

            cmp.setup.cmdline(":", {
                sources = cmp.config.sources({
                    { name = "path" },
                    { name = "cmdline" },
                }),
            })

            local cmp_autopairs = require("nvim-autopairs.completion.cmp")
            cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
        end,
        -- }}}
    },
    -- }}}
    -- >> Debug {{{
    {
        "mfussenegger/nvim-dap", -- {{{
        config = function()
            local dap = require("dap")

            local _md = { silent = true, buffer = true }
            map("n", "<leader>db", function()
                require("dap").toggle_breakpoint()
            end, _md, "Toggle Breakpoint")
            map("n", "<leader>dc", function()
                require("dap").continue()
            end, _md, "Run/Continue")
            map("n", "<leader>dC", function()
                require("dap").clear_breakpoints()
            end, _md, "Clear breakpoints in the current buffer")
            map("n", "<leader>dn", function()
                require("dap").step_over()
            end, _md, "Step Over")
            map("n", "<leader>di", function()
                require("dap").step_into()
            end, _md, "Step Into")
            map("n", "<leader>do", function()
                require("dap").step_out()
            end, _md, "Step Out")
            map("n", "<leader>dS", function()
                require("dap").terminate()
            end, _md, "Stop")
            map("n", "<leader>dr", function()
                require("dap").repl.open()
            end, _md, "REPL")
            map("n", "<leader>dl", function()
                require("dap").run_last()
            end, _md, "Rerun debug")

            local configurations_dir_path = "dap_configurations"

            local require_file_tbl = get_importable_subfiles(configurations_dir_path)

            for _, require_file in ipairs(require_file_tbl) do
                local dap_config = require(require_file)
                dap.adapters = vim.tbl_deep_extend("force", dap.adapters, dap_config.adapters)
                dap.configurations = vim.tbl_deep_extend("force", dap.configurations, dap_config.configurations)
            end
        end,
        -- }}}
    },
    {
        "theHamsta/nvim-dap-virtual-text", -- {{{
        config = {},
        -- }}}
    },
    {
        "rcarriga/nvim-dap-ui", -- {{{
        config = function()
            local dap = require("dap")
            local dapui = require("dapui")

            map("n", "<leader>5", function()
                ---@diagnostic disable-next-line: missing-parameter
                dapui.toggle()
            end, { silent = true }, "Toggle debug ui")
            map("n", "<leader>de", function()
                for _, opts in ipairs(get_all_win_buf_ft()) do
                    if opts.buf_ft == "dapui_hover" then
                        ---@diagnostic disable-next-line: missing-parameter
                        require("dapui").eval()
                        return
                    end
                end
                ---@diagnostic disable-next-line: missing-parameter
                dapui.eval(vim.fn.input("Enter debug expression: "))
            end, { silent = true }, "Execute debug expressions")

            dapui.setup({
                layouts = {
                    {
                        elements = {
                            -- elements can be strings or table with id and size keys.
                            "scopes",
                            "breakpoints",
                            "stacks",
                            "watches",
                        },
                        size = 30,
                        position = "right",
                    },
                    {
                        elements = {
                            "repl",
                            "console",
                        },
                        size = 10,
                        position = "bottom",
                    },
                },
            })

            -- Automatically start dapui when debugging starts
            dap.listeners.after.event_initialized["dapui_config"] = function()
                ---@diagnostic disable-next-line: missing-parameter
                dapui.open()
            end
            -- Automatically close dapui and repl windows when debugging is closed
            dap.listeners.before.event_terminated["dapui_config"] = function()
                ---@diagnostic disable-next-line: missing-parameter
                dapui.close()
                dap.repl.close()
            end
            -- Automatically close dapui and repl windows when debugging is closed
            dap.listeners.before.event_exited["dapui_config"] = function()
                ---@diagnostic disable-next-line: missing-parameter
                dapui.close()
                dap.repl.close()
            end
        end,
        -- }}}
    },
    -- }}}
    -- >> Editor {{{
    {
        "github/copilot.vim", -- {{{
        config = function()
            vim.g.copilot_filetypes = { markdown = true, yaml = true }
        end,
        -- }}}
    },
    "p00f/nvim-ts-rainbow", -- {{{
    -- }}}
    "JoosepAlviste/nvim-ts-context-commentstring", -- {{{
    -- }}}
    "tpope/vim-sleuth", -- {{{
    -- }}}
    "chaoren/vim-wordmotion", -- {{{
    -- }}}
    {
        "anuvyklack/pretty-fold.nvim", -- {{{
        config = {},
        -- }}}
    },
    {
        "windwp/nvim-autopairs", -- {{{
        event = { "InsertEnter" },
        config = function()
            local npairs = require("nvim-autopairs")
            npairs.setup({
                -- disable_filetype = { "TelescopePrompt" },
                disable_in_macro = true,
                disable_in_visualblock = true,
                -- disable_in_replace_mode = true,
                enable_moveright = true,
                -- enable_afterquote = true,
                enable_check_bracket_line = false,
                -- enable_bracket_in_quote = true,
                -- enable_abbr = false,
                -- break_undo = true,
                check_ts = true,
                -- map_cr = true,
                map_bs = true,
                map_c_h = true,
                map_c_w = true,
            })
            -- local Rule = require("nvim-autopairs.rule")
            -- local cond = require("nvim-autopairs.conds")

            -- Lisp, Clojure, Scheme
            npairs.get_rule("'")[1].not_filetypes = { "scheme", "lisp", "clojure", "edn", "fennel" }
        end,
        -- }}}
    },
    {
        "tpope/vim-surround", -- {{{
        -- event = { "BufRead", "BufNewFile" },
        -- config = {
        --     -- mappings_style = "surround",
        --     space_on_closing_char = true,
        -- },
        -- }}}
    },
    {
        "RRethy/vim-illuminate", -- {{{
        event = { "BufRead", "BufNewFile" },
        config = function()
            local illuminate = require("illuminate")
            illuminate.configure({
                delay = 100,
                under_cursor = true,
                modes_denylist = { "i" },
                providers = {
                    --[[ "lsp", ]]
                    "regex",
                    "treesitter",
                },
                filetypes_denylist = {
                    "",
                    "aerial",
                    "dbui",
                    "help",
                    "lspinfo",
                    "lsp-installer",
                    "notify",
                    "NvimTree",
                    "packer",
                    "spectre_panel",
                    "startuptime",
                    "TelescopePrompt",
                    "TelescopeResults",
                    "terminal",
                    "toggleterm",
                    "undotree",
                    "mind",
                },
            })
        end,
        -- }}}
    },
    {
        "lukas-reineke/indent-blankline.nvim", -- {{{
        config = function()
            local indent_blankline = require("indent_blankline")
            vim.g.indent_blankline_filetype_exclude = {
                "",
                "aerial",
                "dbui",
                "help",
                "lspinfo",
                "lsp-installer",
                "notify",
                "NvimTree",
                "packer",
                "spectre_panel",
                "startuptime",
                "TelescopePrompt",
                "TelescopeResults",
                "terminal",
                "toggleterm",
                "undotree",
                "mind",
            }
            indent_blankline.setup({
                show_current_context_start = false,
                show_current_context = true,
                show_end_of_line = true,
            })
        end,
        -- }}}
    },
    {
        "numToStr/Comment.nvim", -- {{{
        config = function()
            local comment = require("Comment")
            local valid_filtype = { "typescriptreact" }
            local comment_utils = require("Comment.utils")
            local ts_context_commentstring_utils = require("ts_context_commentstring.utils")
            local ts_context_commentstring_internal = require("ts_context_commentstring.internal")

            comment.setup({
                opleader = {
                    line = "gc",
                    block = "gb",
                },
                toggler = {
                    line = "gcc",
                    block = "gcb",
                },
                extra = {
                    above = "gck",
                    below = "gcj",
                    eol = "gcA",
                },
                pre_hook = function(ctx)
                    if vim.tbl_contains(valid_filtype, vim.bo.filetype) then
                        -- Determine whether to use linewise or blockwise commentstring
                        local type = ctx.ctype == comment_utils.ctype.linewise and "__default" or "__multiline"

                        -- Determine the location where to calculate commentstring from
                        local location = nil
                        if ctx.cTSConstructortype == comment_utils.ctype.blockwise then
                            location = ts_context_commentstring_utils.get_cursor_location()
                        elseif ctx.cmotion == comment_utils.cmotion.v or ctx.cmotion == comment_utils.cmotion.V then
                            location = ts_context_commentstring_utils.get_visual_start_location()
                        end

                        return ts_context_commentstring_internal.calculate_commentstring({
                            key = type,
                            location = location,
                        })
                    end
                end,
            })
        end,
        -- }}}
    },
    {
        "mg979/vim-visual-multi", -- {{{
        keys = { "<c-n>" },
        config = function()
            map(
                "n",
                "<m-p>",
                ":call vm#commands#add_cursor_up(0, v:count1)<cr>",
                { silent = true },
                "Create cursor down"
            )
            map(
                "n",
                "<m-n>",
                ":call vm#commands#add_cursor_down(0, v:count1)<cr>",
                { silent = true },
                "Create cursor up"
            )

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
        end,
        -- }}}
    },
    {
        "junegunn/vim-easy-align", -- {{{
        config = function()
            map("n", "ga", "<Plug>(LiveEasyAlign)", { noremap = true }, "Align Block")
            map("x", "ga", "<Plug>(LiveEasyAlign)", { noremap = true }, "Align Block")
        end,
        -- }}}
    },
    {
        "ntpeters/vim-better-whitespace", -- {{{
        config = function()
            vim.g.better_whitespace_filetypes_blacklist =
            { "gitcommit", "unite", "qf", "help", "dotooagenda", "dotoo", "toggleterm" }
            map("n", "<leader>cw", "<cmd>StripWhitespace<CR>", {}, "Strip Whitespaces")
        end,
        -- }}}
    },
    {
        "andrewradev/splitjoin.vim", -- {{{
        cmd = { "SplitjoinSplit", "SplitjoinJoin" },
        init = function()
            vim.g.splitjoin_split_mapping = ""
            vim.g.splitjoin_join_mapping = ""
            map("n", "gS", "<cmd>SplitjoinSplit<CR>", {}, "Magic Split")
            map("n", "gJ", "<cmd>SplitjoinJoin<CR>", {}, "Magic Join")
        end,
        -- }}}
    },
    {
        "norcalli/nvim-colorizer.lua", -- {{{
        config = {
            map("n", "<leader>tc", "<cmd>ColorizerToggle<cr>", { silent = true }, "Toggle colorizer"),
        },
        -- }}}
    },
    {
        "aznhe21/hop.nvim", -- {{{
        branch = "fix-some-bugs",
        config = function()
            local hop = require("hop")
            require("hop").setup({ keys = "etovxqpdygfblzhckisuran" })
            local directions = require("hop.hint").HintDirection

            map("", "f", function()
                hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
            end, { remap = true })
            map("", "F", function()
                hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
            end, { remap = true })
            map("", "t", function()
                hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
            end, { remap = true })
            map("", "T", function()
                hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })
            end, { remap = true })

            map("", "ss", function()
                hop.hint_words()
            end, { remap = true })

            map("", "sl", function()
                hop.hint_words({ direction = directions.AFTER_CURSOR, current_line_only = false })
            end, { remap = true })
            map("", "sh", function()
                hop.hint_words({ direction = directions.BEFORE_CURSOR, current_line_only = false })
            end, { remap = true })

            map("", "sj", function()
                hop.hint_vertical({ direction = directions.AFTER_CURSOR })
            end, { remap = true })
            map("", "sk", function()
                hop.hint_vertical({ direction = directions.BEFORE_CURSOR })
            end, { remap = true })
        end,
        -- }}}
    },
    -- }}}
    -- >> Languages {{{
    "folke/neodev.nvim", -- {{{
    -- }}}
    "scalameta/nvim-metals", -- {{{
    -- }}}
    {
        "towolf/vim-helm", -- {{{
        ft = "helm",
        init = function()
            vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
                command = "set ft=helm",
                pattern = { "*/templates/*.yaml", "*/templates/*.tpl", "Chart.yaml", "values.yaml" },
            })
        end,
        -- }}}
    },
    {
        "Vimjas/vim-python-pep8-indent", -- {{{
        ft = "py",
        event = { "InsertEnter" },
        -- }}}
    },
    {
        "gpanders/vim-medieval", -- {{{
        ft = "markdown",
        config = function()
            vim.g.medieval_langs = { "python", "ruby", "sh", "console=bash", "bash", "perl", "fish", "bb" }
        end,
        -- }}}
    },
    {
        "jakewvincent/mkdnflow.nvim", -- {{{
        config = {
            modules = {
                bib = false,
                buffers = true,
                conceal = true,
                cursor = true,
                folds = true,
                links = true,
                lists = true,
                maps = true,
                paths = true,
                tables = true,
            },
            filetypes = { md = true, rmd = true, markdown = true },
            create_dirs = true,
            perspective = {
                priority = "first",
                fallback = "current",
                root_tell = false,
                nvim_wd_heel = true,
            },
            wrap = false,
            silent = false,
            links = {
                style = "markdown",
                name_is_source = false,
                conceal = false,
                implicit_extension = nil,
                transform_implicit = false,
                transform_explicit = function(text)
                    text = text:gsub(" ", "-")
                    text = text:lower()
                    text = os.date("%Y-%m-%d_") .. text
                    return text
                end,
            },
            to_do = {
                symbols = { " ", "-", "x" },
                update_parents = true,
                not_started = " ",
                in_progress = "-",
                complete = "x",
            },
            tables = {
                trim_whitespace = true,
                format_on_move = true,
                auto_extend_rows = false,
                auto_extend_cols = false,
            },
            mappings = {
                -- Using zk-nvim to create links
                MkdnEnter = { { "n", "v" }, "<M-CR>" },
                MkdnTab = false,
                MkdnSTab = false,
                MkdnNextLink = { "n", "]l" },
                MkdnPrevLink = { "n", "[l" },
                MkdnNextHeading = { "n", "]]" },
                MkdnPrevHeading = { "n", "[[" },
                MkdnGoBack = { "n", "<BS>" },
                MkdnGoForward = { "n", "<Del>" },
                MkdnFollowLink = false, -- see MkdnEnter
                -- MkdnDestroyLink = { 'n', '<M-CR>' },
                -- MkdnTagSpan = { 'v', '<M-CR>' },
                MkdnMoveSource = { "n", "<F2>" },
                MkdnYankAnchorLink = { "n", "ya" },
                MkdnYankFileAnchorLink = { "n", "yfa" },
                MkdnIncreaseHeading = { "n", "+" },
                MkdnDecreaseHeading = { "n", "-" },
                MkdnToggleToDo = { { "n", "v" }, "<C-Space>" },
                MkdnNewListItem = false,
                MkdnNewListItemBelowInsert = { "n", "o" },
                MkdnNewListItemAboveInsert = { "n", "O" },
                MkdnExtendList = false,
                MkdnUpdateNumbering = { "n", "<leader>wN" },
                MkdnTableNextCell = { "i", "<Tab>" },
                MkdnTablePrevCell = { "i", "<S-Tab>" },
                MkdnTableNextRow = false,
                MkdnTablePrevRow = { "i", "<M-CR>" },
                MkdnTableNewRowBelow = { "n", "<leader>ir" },
                MkdnTableNewRowAbove = { "n", "<leader>iR" },
                MkdnTableNewColAfter = { "n", "<leader>ic" },
                MkdnTableNewColBefore = { "n", "<leader>iC" },
                MkdnFoldSection = { "n", "zf" },
                MkdnUnfoldSection = { "n", "zF" },
            },
        },
        -- }}}
    },
    {
        "chrisbra/csv.vim", -- {{{
        ft = "csv",
        init = function()
            vim.api.nvim_create_autocmd(
                { "BufNewFile", "BufRead" },
                { pattern = { "*.csv" }, command = "set filetype=csv" }
            )
        end,
        -- }}}
    },
    {
        "mtdl9/vim-log-highlighting", -- {{{
        ft = "log",
        init = function()
            vim.api.nvim_create_autocmd(
                { "BufNewFile", "BufRead" },
                { pattern = { "*.log" }, command = "set filetype=log" }
            )
        end,
        -- }}}
    },
    {
        "hashivim/vim-terraform", -- {{{
        config = function()
            vim.g.terraform_align = 1
            vim.g.terraform_fmt_on_save = 0
        end,
        -- }}}
    },
    {
        "guns/vim-sexp", -- {{{
        init = function()
            vim.g.sexp_filetypes = "clojure,scheme,lisp,timl,edn,fennel"
            vim.g.sexp_mappings = {
                sexp_outer_list = "af",
                sexp_inner_list = "if",
                sexp_outer_top_list = "aF",
                sexp_inner_top_list = "iF",
                sexp_outer_string = "as",
                sexp_inner_string = "is",
                sexp_outer_element = "ae",
                sexp_inner_element = "ie",

                sexp_move_to_prev_bracket = "[[",
                sexp_move_to_next_bracket = "]]",

                sexp_move_to_prev_element_head = "b",
                sexp_move_to_next_element_head = "w",
                sexp_move_to_prev_element_tail = "ge",
                sexp_move_to_next_element_tail = "e",

                -- sexp_flow_to_prev_close = "<M-[>",
                -- sexp_flow_to_next_open = "<M-]>",
                -- sexp_flow_to_prev_open = "<M-{>",
                -- sexp_flow_to_next_close = "<M-}>",
                --
                -- sexp_flow_to_prev_leaf_head = "<M-S-b>",
                -- sexp_flow_to_next_leaf_head = "<M-S-w>",
                -- sexp_flow_to_prev_leaf_tail = "<M-S-g>",
                -- sexp_flow_to_next_leaf_tail = "<M-S-e>",

                -- sexp_move_to_prev_top_element = "[[",
                -- sexp_move_to_next_top_element = "]]",
                -- sexp_select_prev_element = "[e",
                -- sexp_select_next_element = "]e",
                -- sexp_indent = "=>",
                -- sexp_indent_top = "=<",

                sexp_round_head_wrap_list = "<(",
                sexp_round_tail_wrap_list = ">)",
                sexp_square_head_wrap_list = "<[",
                sexp_square_tail_wrap_list = ">]",
                sexp_curly_head_wrap_list = "<{",
                sexp_curly_tail_wrap_list = ">}",

                sexp_round_head_wrap_element = "<W(",
                sexp_round_tail_wrap_element = ">W)",
                sexp_square_head_wrap_element = "<W[",
                sexp_square_tail_wrap_element = ">W]",
                sexp_curly_head_wrap_element = "<W{",
                sexp_curly_tail_wrap_element = ">W}",

                sexp_insert_at_list_head = "<I",
                sexp_insert_at_list_tail = ">I",

                sexp_splice_list = "dsf",
                sexp_convolute = "<?",

                sexp_raise_list = "<rf",
                sexp_raise_element = "<re",

                sexp_swap_list_backward = "<F",
                sexp_swap_list_forward = ">F",
                sexp_swap_element_backward = "<E",
                sexp_swap_element_forward = ">E",

                sexp_emit_head_element = ")(",
                sexp_emit_tail_element = "()",
                sexp_capture_prev_element = "((",
                sexp_capture_next_element = "))",
            }
            -- vim.g.sexp_enable_insert_mode_mappings = 0
        end,
        -- }}}
    },
    -- {
    --     "liquidz/vim-iced", -- {{{
    --     config = function()
    --         vim.g["iced#eval#inside_comment"] = true
    --         vim.g["iced#eval#keep_inline_result"] = true
    --         -- vim.g['iced#promise#timeout_ms'] = 10000
    --         vim.g["iced#nrepl#skip_evaluation_when_buffer_size_is_exceeded"] = true
    --     end,
    --     -- }}}
    -- },
    {
        "Olical/conjure", -- {{{

        config = function()
            vim.g["conjure#mapping#prefix"] = "<leader>c"
            vim.g["conjure#mapping#def_word"] = "g"
            vim.g["conjure#mapping#doc_word"] = "h"
        end,
        -- }}}
    },
    -- {
    --     "ledger/vim-ledger", -- {{{
    --     -- }}}
    -- },
    -- }}}
    -- >> Find {{{
    {
        "kevinhwang91/nvim-hlslens", -- {{{
        config = function()
            local hlslens = require("hlslens")
            hlslens.setup({
                -- automatically clear search results
                calm_down = true,
                -- set to the nearest match to add a shot
                nearest_only = true,
            })

            map("n", "n", function()
                pcall(vim.cmd, "normal! " .. vim.v.count1 .. "nzz")
                require("hlslens").start()
            end, { silent = true }, "Skip to next search result")
            map("n", "N", function()
                pcall(vim.cmd, "normal! " .. vim.v.count1 .. "Nzz")
                require("hlslens").start()
            end, { silent = true }, "Jump to previous search result")
            map("n", "*", function()
                pcall(vim.cmd, "normal! " .. vim.v.count1 .. "*zz")
                require("hlslens").start()
            end, { silent = true }, "Jump to the next word at the current cursor")
            map("n", "#", function()
                pcall(vim.cmd, "normal! " .. vim.v.count1 .. "#zz")
                require("hlslens").start()
            end, { silent = true }, "Jump to the prev word at the current cursor")
            map("n", "g*", function()
                pcall(vim.cmd, "normal! " .. vim.v.count1 .. "g*zz")
                require("hlslens").start()
            end, { silent = true }, "Jump to the next word at the current cursor (forbidden range)")
            map("n", "g#", function()
                pcall(vim.cmd, "normal! " .. vim.v.count1 .. "g#zz")
                require("hlslens").start()
            end, { silent = true }, "Jump to the prev word at the current cursor (forbidden range)")
        end,
        -- }}}
    },
    {
        "folke/todo-comments.nvim", -- {{{
        event = { "BufRead", "BufNewFile" },
        init = function()
            map("n", "<leader>fd", function()
                require("telescope").extensions["todo-comments"].todo()
            end, { silent = true }, "Find todo tag in the current workspace")
        end,
        config = function()
            local todo_comments = require("todo-comments")

            todo_comments.setup({
                keywords = {
                    -- alt = alias
                    NOTE = { icon = icons.Note, color = "#96CDFB" },
                    TODO = { icon = icons.Todo, color = "#B5E8E0" },
                    PERF = { icon = icons.Pref, color = "#F8BD96" },
                    WARN = { icon = icons.Warn, color = "#FAE3B0" },
                    HACK = { icon = icons.Hack, color = "#DDB6F2" },
                    FIX = {
                        icon = icons.Fixme,
                        color = "#DDB6F2",
                        alt = { "FIXME", "BUG", "FIXIT", "ISSUE" },
                    },
                },
            })
        end,
        -- }}}
    },
    {
        "nvim-telescope/telescope-fzf-native.nvim", -- {{{
        build = "make",
        -- }}}
    },
    {
        "nvim-telescope/telescope.nvim", -- {{{
        config = function()
            local telescope = require("telescope")
            local actions = require("telescope.actions")
            telescope.setup({
                defaults = {
                    vimgrep_arguments = {
                        "rg",
                        "--color=never",
                        "--no-heading",
                        "--with-filename",
                        "--line-number",
                        "--column",
                        "--smart-case",
                        "--hidden",
                        "--ignore",
                        "--iglob",
                        "!.git",
                        "--ignore-vcs",
                        "--ignore-file",
                        "~/.config/git/gitexcludes",
                    },
                    prompt_prefix = " ",
                    selection_caret = " ",
                    entry_prefix = " ",
                    multi_icon = " ",
                    color_devicons = true,
                    file_ignore_patterns = { "node_modules" },
                    -- theme
                    layout_strategy = "bottom_pane",
                    -- config
                    set_env = { ["COLORTERM"] = "truecolor" },
                    layout_config = {
                        bottom_pane = {
                            height = 0.95,
                            preview_cutoff = 100,
                            prompt_position = "bottom",
                        },
                    },
                    mappings = {
                        i = {
                            ["<c-j>"] = actions.move_selection_next,
                            ["<c-k>"] = actions.move_selection_previous,

                            ["<C-s>"] = actions.select_horizontal,
                            ["<C-v>"] = actions.select_vertical,
                            ["<C-t>"] = actions.select_tab,
                            ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,

                            ["<C-Space>"] = actions.toggle_selection + actions.move_selection_next,

                            -- ["<CR>"] = actions.select_default + actions.center,
                            ["<esc>"] = actions.close,
                        },
                        n = {
                            ["<esc>"] = actions.close,
                        },
                    },
                },
                pickers = {
                    buffers = {
                        mappings = {
                            i = {
                                ["<c-d>"] = "delete_buffer",
                            },
                            n = {
                                ["dd"] = "delete_buffer",
                            },
                        },
                    },
                },
                extensions = {
                    fzf = {
                        fuzzy = true,
                        override_generic_sorter = true,
                        override_file_sorter = true,
                        case_mode = "smart_case",
                    },
                },
            })

            -- Mapping
            map("n", "<leader>fo", function()
                local find_command = {
                    "rg",
                    "--ignore",
                    "--hidden",
                    "--files",
                    "--iglob",
                    "!.git",
                    "--ignore-vcs",
                    "--ignore-file",
                    "~/.config/git/gitexcludes",
                }
                require("telescope.builtin").find_files({ find_command = find_command })
            end, { silent = true }, "Find files in the current workspace")
            map("n", "<leader>ff", function()
                require("telescope.builtin").live_grep()
            end, { silent = true }, "Find string in the current workspace")
            map("n", "<leader>fh", function()
                require("telescope.builtin").oldfiles()
            end, { silent = true }, "Find telescope history")
            map("n", "<leader>f.", function()
                require("telescope.builtin").resume()
            end, { silent = true }, "Find last lookup")
            map("n", "<leader>fm", function()
                require("telescope.builtin").marks()
            end, { silent = true }, "Find marks in the current workspace")
            map("n", "<leader>fb", function()
                require("telescope.builtin").buffers()
            end, { silent = true }, "Find all buffers")
            map("n", "<leader>f/", function()
                require("telescope.builtin").current_buffer_fuzzy_find()
            end, { silent = true }, "Find string current buffer")
            map("n", "<leader>f:", function()
                require("telescope.builtin").command_history()
            end, { silent = true }, "Find all command history")

            map("n", "<leader>fss", "<cmd>Telescope vim_options<CR>", { silent = true }, "Settings")
            map("n", "<leader>fH", function()
                require("telescope.builtin").help_tags()
            end, { silent = true }, "Help tags")
            map("n", "<leader>fsa", "<cmd>Telescope autocommands<CR>", { silent = true }, "Autocommands")
            map("n", "<leader>fsf", "<cmd>Telescope filetypes<CR>", { silent = true }, "Filetypes")
            map("n", "<leader>fsh", function()
                require("telescope.builtin").highlights()
            end, { silent = true }, "Highlights")
            map("n", "<leader>fsk", "<cmd>Telescope keymaps<CR>", { silent = true }, "Keymaps")
            map("n", "<leader>fsc", "<cmd>Telescope colorscheme<CR>", { silent = true }, "Colorschemes")

            -- Load after
            telescope.load_extension("fzf")

            -- FIX: https://github.com/nvim-telescope/telescope.nvim/issues/699
            vim.api.nvim_create_autocmd({ "BufEnter" }, {
                pattern = { "*" },
                command = "normal zx",
            })
        end,
        -- }}}
    },
    -- }}}
    -- >> Tools {{{
    -- {
    --     "dstein64/vim-startuptime", -- {{{
    --     cmd = { "StartupTime" },
    --     -- }}}
    -- },
    {
    -- NOTE: I am here
        "olimorris/persisted.nvim", -- {{{
        config = function()
            local persisted = require("persisted")
            persisted.setup({
                save_dir = path.join(vim.fn.stdpath("cache"), "sessions"),
                use_git_branche = true,
                command = "VimLeavePre",
                autosave = true,
                after_save = function()
                    vim.cmd("nohlsearch")
                end,
            })

            map("n", "<leader>sl", "<cmd>silent! SessionLoad<cr>", { silent = true }, "Session Load")
            map("n", "<leader>ss", function()
                vim.cmd("silent! SessionSave")
                vim.api.nvim_echo({ { "Session saved success", "MoreMsg" } }, true, {})
            end, { silent = true }, "Session Save")
            map("n", "<leader>sq", function()
                vim.cmd("silent! SessionSave")
                vim.cmd("qall")
            end, { silent = true }, "Session Quit")
            map("n", "<leader>sd", function()
                local ok, _ = pcall(vim.cmd, "SessionDelete")
                if ok then
                    vim.api.nvim_echo({ { "Session deleted success", "MoreMsg" } }, true, {})
                else
                    vim.api.nvim_echo({ { "Session deleted failure", "ErrorMsg" } }, true, {})
                end
            end, { silent = true }, "Session Delete")
        end,
        -- }}}
    },
    {
        "lewis6991/gitsigns.nvim", -- {{{
        event = { "BufRead", "BufNewFile" },
        config = function()
            local gitsigns = require("gitsigns")
            gitsigns.setup({
                signcolumn = true,
                numhl = false,
                linehl = false,
                word_diff = false,
                ---@diagnostic disable-next-line: unused-local
                on_attach = function(bufnr)
                    map(
                        "n",
                        "<leader>gtl",
                        "<cmd>Gitsigns toggle_current_line_blame<cr>",
                        { silent = true },
                        "Toggle current line blame"
                    )
                    map(
                        "n",
                        "<leader>ghp",
                        "<cmd>lua require'gitsigns'.preview_hunk()<cr>",
                        { silent = true },
                        "Preview current hunk"
                    )
                    map(
                        "n",
                        "<leader>ghP",
                        "<cmd>lua require'gitsigns'.blame_line{full=true}<cr>",
                        { silent = true },
                        "Show current block blame"
                    )
                    map("n", "<leader>ghd", "<cmd>Gitsigns diffthis<cr>", { silent = true }, "Open deff view")
                    map("n", "<leader>gtD", "<cmd>Gitsigns toggle_deleted<cr>", { silent = true }, "Show deleted lines")
                    map("n", "<leader>ghr", "<cmd>Gitsigns reset_hunk<cr>", { silent = true }, "Reset current hunk")
                    map("v", "<leader>ghr", "<cmd>Gitsigns reset_hunk<cr>", { silent = true }, "Reset current hunk")
                    map("n", "<leader>ghR", "<cmd>Gitsigns reset_buffer<cr>", { silent = true }, "Reset current buffer")
                    map("n", "[g", function()
                        if vim.wo.diff then
                            return "[c"
                        end
                        vim.schedule(function()
                            gitsigns.prev_hunk()
                        end)
                        return "<Ignore>"
                    end, { silent = true, expr = true }, "Jump to the prev hunk")
                    map("n", "]g", function()
                        if vim.wo.diff then
                            return "]c"
                        end
                        vim.schedule(function()
                            gitsigns.next_hunk()
                        end)
                        return "<Ignore>"
                    end, { silent = true, expr = true }, "Jump to the next hunk")
                end,
                signs = {
                    add = { hl = "GitSignsAdd", text = "+", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
                    change = {
                        hl = "GitSignsChange",
                        text = "~",
                        numhl = "GitSignsChangeNr",
                        linehl = "GitSignsChangeLn",
                    },
                    delete = {
                        hl = "GitSignsDelete",
                        text = "-",
                        numhl = "GitSignsDeleteNr",
                        linehl = "GitSignsDeleteLn",
                    },
                    topdelete = {
                        hl = "GitSignsDelete",
                        text = "‾",
                        numhl = "GitSignsDeleteNr",
                        linehl = "GitSignsDeleteLn",
                    },
                    changedelete = {
                        hl = "GitSignsChange",
                        text = "_",
                        numhl = "GitSignsChangeNr",
                        linehl = "GitSignsChangeLn",
                    },
                },
                current_line_blame_opts = {
                    virt_text = true,
                    virt_text_pos = "eol",
                    delay = 100,
                    ignore_whitespace = false,
                },
                preview_config = {
                    border = options.float_border and "rounded" or "none",
                    style = "minimal",
                    relative = "cursor",
                    row = 0,
                    col = 1,
                },
            })
        end,
        -- }}}
    },
    {
        "tpope/vim-fugitive", -- {{{
        dependencies = { { "tpope/vim-rhubarb" }, { "shumphrey/fugitive-gitlab.vim" } },
        config = function()
            local git_show_block_history = function()
                vim.cmd([[exe ":G log -L " . string(getpos("'<'")[1]) . "," . string(getpos("'>'")[1]) . ":%"]])
            end

            local git_show_line_history = function()
                vim.cmd([[exe ":G log -U1 -L " . string(getpos('.')[1]) . ",+1:%"]])
            end

            local _md = { noremap = true }
            map("n", "<leader>gb", "<cmd>Git blame<CR>", _md, "Git Blame")
            map("n", "<leader>gd", "<cmd>Gdiffsplit<CR>", _md, "Git Diff")
            map("n", "<leader>gx", "<cmd>.GBrowse %<CR>", _md, "Git Browse")
            map("n", "<leader>gl.", function()
                git_show_line_history()
            end, _md, "History Line")
            -- map("n", "<leader>gll", "<cmd>GlLog<CR>", _md, "History")
            -- map("n", "<leader>glf", "<cmd>GlLog %<CR>", _md, "History File")
            map("n", "<leader>gfm", "<cmd>Git pull<CR>", _md, "Git Merge")
            map("n", "<leader>gfr", "<cmd>Git pull --rebase<CR>", _md, "Git Rebase")
            map("n", "<leader>gps", "<cmd>Git push<CR>", _md, "Git Push")
            map("n", "<leader>gpf", "<cmd>Git push --force-with-lease<CR>", _md, "Push(force with lease)")
            map("n", "<leader>gpF", "<cmd>Git push --force<CR>", _md, "Push(force)")
            map("n", "<leader>gR", "<cmd>Gread<CR>", _md, "Git Reset")
            map("n", "<leader>gS", "<cmd>Git<CR>", _md, "Git Status")
            map("n", "<leader>gW", "<cmd>Gwrite<CR>", _md, "Git Write")
            map("x", "<leader>gx", [[:'<,'>GBrowse %<CR>]], _md, "Git Browse")
            map("x", "<leader>glv", function()
                git_show_block_history()
            end, _md, "History Visual Block")
        end,
        -- }}}
    },
    {
        "folke/which-key.nvim", -- {{{
        -- event = { "BufRead", "BufNewFile" },
        config = function()
            local which_key = require("which-key")
            which_key.setup({
                plugins = {
                    spelling = {
                        enabled = true,
                        suggestions = 20,
                    },
                },
                icons = {
                    breadcrumb = " ",
                    separator = " ",
                    group = " ",
                },
                operators = { gc = "Comments" },
                window = {
                    border = "single",
                },
            })

            -- global leader
            which_key.register({
                b = { name = "Buffers" },
                c = { name = "Code" },
                d = { name = "Debug" },
                f = { name = "Find" },
                fs = { name = "Settings" },
                g = { name = "Git" },
                gf = { name = "Git Fetch" },
                gl = { name = "Git Log" },
                gp = { name = "Git Push" },
                i = { name = "Insert" },
                l = { name = "Lsp" },
                -- o = { name = "Options" },
                -- os = { name = "Settings" },
                p = { name = "Packer | Profiling" },
                r = { name = "Replace", w = "Replace Word To ..." },
                s = { name = "Session" },
                y = { name = "Yank" },
                yf = { name = "File" },
                t = {
                    name = "Toggle",
                },
                w = { name = "Wiki" },
            }, { prefix = "<leader>", mode = "n" })

            -- comment
            which_key.register({
                c = {
                    name = "Comment",
                    c = "Toggle line comment",
                    b = "Toggle block comment",
                    a = "Insert line comment to line end",
                    j = "Insert line comment to next line",
                    k = "Insert line comment to previous line",
                },
            }, { prefix = "g", mode = "n" })
        end,
        -- }}}
    },
    {
        "christoomey/vim-tmux-navigator", -- {{{
        init = function()
            vim.g.tmux_navigator_save_on_switch = 2
            vim.g.tmux_navigator_disable_when_zoomed = 1
        end,
        -- }}}
    },
    {
        "mickael-menu/zk-nvim", -- {{{
        init = function()
            local home = vim.fn.expand("~/Notes")
            vim.fn.setenv("ZK_NOTEBOOK_DIR", home)
        end,
        config = function()
            local telescope = require("telescope")
            local zk = require("zk")

            zk.setup({
                picker = "telescope",
            })

            telescope.load_extension("zk")

            local opts = { noremap = true, silent = false }

            map("n", "<leader>wn", "<Cmd>ZkNew { title = vim.fn.input('Title: ') }<CR>", opts, "New note")
            map("n", "<leader>wi", "<Cmd>ZkIndex<CR>", opts, "Reindex notes")
            map("n", "<leader>wo", "<Cmd>ZkNotes { sort = { 'modified' } }<CR>", opts, "Open note")
            map("n", "<leader>wt", "<Cmd>ZkTags<CR>", opts, "Open tag")
            map(
                "n",
                "<leader>wf",
                "<Cmd>ZkNotes { sort = { 'modified' }, match = { vim.fn.input('Search: ') } }<CR>",
                opts,
                "Find in notes"
            )
            map("v", "<leader>wf", ":'<,'>ZkMatch<CR>", opts, "Find in notes")
        end,
        -- }}}
    },
    {
        "phaazon/mind.nvim", -- {{{
        branch = "v2.2",
        requires = { "nvim-lua/plenary.nvim" },
        config = function()
            map("n", "<leader>3", "<Cmd>MindOpenSmartProject<CR>", { silent = true }, "Open Mind")
            require("mind").setup({
                persistence = {
                    -- path where the global mind tree is stored
                    state_path = "~/Notes/mind/mind.json",

                    -- directory where to create global data files
                    data_dir = "~/Notes/mind/data",
                },
            })
        end,
        -- }}}
    },
    -- }}}
    -- >> Views {{{
    {
        "nvim-lualine/lualine.nvim", -- {{{
        config = {
            options = {
                theme = "auto",
                icons_enabled = true,
                component_separators = { left = "", right = "" },
                section_separators = { left = "", right = "" },
                -- section_separators = { left = "", right = "" },
                disabled_filetypes = {},
                globalstatus = true,
                refresh = {
                    statusline = 100,
                    tabline = 100,
                    winbar = 100,
                },
            },
        },
        -- }}}
    },
    {
        "nvim-pack/nvim-spectre", -- {{{
        config = function()
            local spectre = require("spectre")

            spectre.setup({
                color_devicons = true,
                open_cmd = "vnew",
                live_update = true, -- auto excute search again when you write any file in vim
                mapping = {
                    ["toggle_line"] = {
                        map = "x",
                        cmd = "<cmd>lua require('spectre').toggle_line()<CR>",
                        desc = "toggle current item",
                    },
                    ["enter_file"] = {
                        map = "<cr>",
                        cmd = "<cmd>lua require('spectre.actions').select_entry()<CR>",
                        desc = "goto current file",
                    },
                    ["send_to_qf"] = {
                        map = "<C-q>",
                        cmd = "<cmd>lua require('spectre.actions').send_to_qf()<CR>",
                        desc = "send all item to quickfix",
                    },
                    ["replace_cmd"] = {
                        map = "rc",
                        cmd = "<cmd>lua require('spectre.actions').replace_cmd()<CR>",
                        desc = "input replace vim command",
                    },
                    ["show_option_menu"] = {
                        map = "ro",
                        cmd = "<cmd>lua require('spectre').show_options()<CR>",
                        desc = "show option",
                    },
                    ["run_current_replace"] = {
                        map = "r<CR>",
                        cmd = "<cmd>lua require('spectre.actions').run_current_replace()<CR>",
                        desc = "replace current line",
                    },
                    ["run_replace"] = {
                        map = "R",
                        cmd = "<cmd>lua require('spectre.actions').run_replace()<CR>",
                        desc = "replace all",
                    },
                    ["change_view_mode"] = {
                        map = "tv",
                        cmd = "<cmd>lua require('spectre').change_view()<CR>",
                        desc = "change result view mode",
                    },
                    ["change_replace_sed"] = {
                        map = "trs",
                        cmd = "<cmd>lua require('spectre').change_engine_replace('sed')<CR>",
                        desc = "use sed to replace",
                    },
                    ["change_replace_oxi"] = {
                        map = "tro",
                        cmd = "<cmd>lua require('spectre').change_engine_replace('oxi')<CR>",
                        desc = "use oxi to replace",
                    },
                    ["toggle_live_update"] = {
                        map = "tu",
                        cmd = "<cmd>lua require('spectre').toggle_live_update()<CR>",
                        desc = "update change when vim write file.",
                    },
                    ["toggle_ignore_case"] = {
                        map = "ti",
                        cmd = "<cmd>lua require('spectre').change_options('ignore-case')<CR>",
                        desc = "toggle ignore case",
                    },
                    ["toggle_ignore_hidden"] = {
                        map = "th",
                        cmd = "<cmd>lua require('spectre').change_options('hidden')<CR>",
                        desc = "toggle search hidden",
                    },
                    ["resume_last_search"] = {
                        map = "r.",
                        cmd = "<cmd>lua require('spectre').resume_last_search()<CR>",
                        desc = "resume last search before close",
                    },
                },
            })

            map("n", "<leader>rp", function()
                toggle_sidebar("spectre_panel")
                require("spectre").open()
            end, { silent = true }, "Replace characters in all fs in the current workspace")
            map("n", "<leader>rf", function()
                toggle_sidebar("spectre_panel")
                require("spectre").open_file_search()
            end, { silent = true }, "Replace all characters in the current file")
            map("n", "<leader>rwf", function()
                toggle_sidebar("spectre_panel")
                require("spectre").open_visual({
                    select_word = true,
                    ---@diagnostic disable-next-line: missing-parameter
                    path = vim.fn.fnameescape(vim.fn.expand("%:p:.")),
                })
            end, { silent = true }, "Replace the character under the cursor in the current file")
            map("n", "<leader>rwp", function()
                toggle_sidebar("spectre_panel")
                require("spectre").open_visual({ select_word = true })
            end, { silent = true }, "Replace the character under the cursor in all files under the current workspace")
        end,
        -- }}}
    },
    {
        "gabrielpoca/replacer.nvim", -- {{{
        -- }}}
    },
    {
        "mbbill/undotree", -- {{{
        event = { "BufRead", "BufNewFile" },
        config = function()
            local undotree_dir = path.join(vim.fn.stdpath("cache"), "undotree")

            -- style: default 1, optional: 1 2 3 4
            -- vim.g.undotree_WindowLayout = 2

            -- custom window
            vim.g.undotree_CustomUndotreeCmd = "topleft vertical 30 new"
            vim.g.undotree_CustomDiffpanelCmd = "belowright 10 new"

            -- auto focus default 0
            vim.g.undotree_SetFocusWhenToggle = 1

            if vim.fn.has("persistent_undo") == 1 then
                ---@diagnostic disable-next-line: missing-parameter
                local target_path = vim.fn.expand(undotree_dir)
                if not vim.fn.isdirectory(target_path) then
                    vim.fn.mkdir(target_path, "p", 0700)
                end
                vim.o.undodir = target_path
                vim.o.undofile = true
            end

            map("n", "<leader>4", function()
                toggle_sidebar("undotree")
                local ok, _ = pcall(vim.cmd, "UndotreeToggle")
                if not ok then
                    vim.api.nvim_echo({ { "Can't open undotree", "ErrorMsg" } }, false, {})
                end
            end, { silent = true }, "Open Undo Explorer")
        end,
        -- }}}
    },
    {
        "kyazdani42/nvim-tree.lua", -- {{{
        cmd = { "NvimTreeToggle", "NvimTreeFindFile" },
        init = function()
            map("n", "<leader>1", function()
                toggle_sidebar("NvimTree")
                vim.cmd("NvimTreeToggle")
            end, { silent = true }, "Open File Explorer")
            map("n", "<leader>fp", function()
                toggle_sidebar("NvimTree")
                vim.cmd("NvimTreeFindFile")
            end, { silent = true }, "Find the current file and open it in file explorer")
        end,
        config = function()
            local nvim_tree = require("nvim-tree")

            nvim_tree.setup({
                open_on_tab = false,

                disable_netrw = false,
                hijack_netrw = false,
                hijack_cursor = true,
                sync_root_with_cwd = false,
                reload_on_bufenter = true,
                update_focused_file = {
                    enable = false,
                    update_root = false,
                },
                system_open = {
                    cmd = nil,
                    args = {},
                },
                view = {
                    side = "left",
                    width = 35,
                    hide_root_folder = false,
                    signcolumn = "yes",
                    mappings = {
                        custom_only = true,
                        list = {
                            { key = { "<CR>" }, action = "edit" },
                            { key = { "o" }, action = "edit" },
                            { key = { "l" }, action = "edit" },
                            { key = { "<C-]>" }, action = "cd" },
                            { key = { "C" }, action = "cd" },
                            { key = { "v" }, action = "vsplit" },
                            { key = { "s" }, action = "split" },
                            { key = { "t" }, action = "tabnew" },
                            { key = { "h" }, action = "close_node" },
                            { key = { "<Tab>" }, action = "preview" },
                            { key = { "I" }, action = "toggle_ignored" },
                            { key = { "H" }, action = "toggle_dotfiles" },
                            { key = { "r" }, action = "refresh" },
                            { key = { "R" }, action = "refresh" },
                            { key = { "a" }, action = "create" },
                            { key = { "d" }, action = "remove" },
                            { key = { "m" }, action = "rename" },
                            { key = { "M" }, action = "full_rename" },
                            { key = { "x" }, action = "cut" },
                            { key = { "c" }, action = "copy" },
                            { key = { "p" }, action = "paste" },
                            { key = { "[g" }, action = "prev_git_item" },
                            { key = { "]g" }, action = "next_git_item" },
                            { key = { "u" }, action = "dir_up" },
                            { key = { "q" }, action = "close" },
                        },
                    },
                },
                diagnostics = {
                    enable = true,
                    show_on_dirs = true,
                    icons = {
                        hint = icons.Hint,
                        info = icons.Info,
                        warning = icons.Warn,
                        error = icons.Error,
                    },
                },
                actions = {
                    use_system_clipboard = true,
                    change_dir = {
                        enable = true,
                        global = true,
                        restrict_above_cwd = false,
                    },
                    open_file = {
                        resize_window = true,
                        quit_on_open = true,
                        window_picker = {
                            enable = false,
                        },
                    },
                },
                trash = {
                    cmd = "trash",
                    require_confirm = true,
                },
                filters = {
                    dotfiles = false,
                    custom = { "node_modules", "\\.cache", "__pycache__" },
                    exclude = {},
                },
                renderer = {
                    add_trailing = true,
                    group_empty = true,
                    highlight_git = true,
                    highlight_opened_files = "none",
                    icons = {
                        show = {
                            file = true,
                            folder = true,
                            folder_arrow = true,
                            git = true,
                        },
                        glyphs = {
                            default = "",
                            symlink = "",
                            git = {
                                unstaged = "",
                                staged = "",
                                unmerged = "",
                                renamed = "凜",
                                untracked = "",
                                deleted = "",
                                ignored = "",
                            },
                            folder = {
                                arrow_open = "",
                                arrow_closed = "",
                                default = "",
                                open = "",
                                empty = "",
                                empty_open = "",
                                symlink = "",
                                symlink_open = "",
                            },
                        },
                    },
                },
            })
        end,
        -- }}}
    },
    {
        "akinsho/bufferline.nvim", -- {{{
        event = { "BufNewFile", "BufRead", "TabEnter" },
        config = function()
            local bufferline = require("bufferline")

            bufferline.setup({
                options = {
                    themable = true,
                    -- ordinal
                    numbers = "none",
                    buffer_close_icon = "",
                    modified_icon = "●",
                    -- left_trunc_marker = "",
                    -- right_trunc_marker = "",
                    diagnostics = "nvim_lsp",
                    separator_style = "slant",
                    -- indicator = { icon = "▎", style = "icon" },
                    show_buffer_close_icons = false,
                    show_close_icon = false,
                    show_tab_indicators = true,
                    sort_by = "directory",
                    persist_buffer_sort = true,
                    always_show_bufferline = true,
                    ---@diagnostic disable-next-line: unused-local
                    diagnostics_indicator = function(count, level, diagnostics_dict, context)
                        local message
                        if diagnostics_dict.error then
                            message = string.format("%s%s", icons.Error, diagnostics_dict.error)
                        elseif diagnostics_dict.warning then
                            message = string.format("%s%s", icons.Warn, diagnostics_dict.warning)
                        elseif diagnostics_dict.info then
                            message = string.format("%s%s", icons.Info, diagnostics_dict.info)
                        elseif diagnostics_dict.hint then
                            message = string.format("%s%s", icons.Hint, diagnostics_dict.hint)
                        else
                            message = ""
                        end
                        return message
                    end,
                    custom_areas = {
                        right = function()
                            local cwd = vim.fn.getcwd()
                            local home = vim.loop.os_homedir()
                            cwd = string.gsub(cwd, home, "~")
                            return {
                                { text = cwd, guifg = options.colors.color_4, guibg = options.colors.color_0 },
                            }
                        end,
                    },
                    offsets = {
                        {
                            filetype = "NvimTree",
                            text = "File Explorer",
                            highlight = "Directory",
                            text_align = "center",
                        },
                        {
                            filetype = "aerial",
                            text = "Outline Explorer",
                            highlight = "Directory",
                            text_align = "center",
                        },
                        {
                            filetype = "undotree",
                            text = "Undo Explorer",
                            highlight = "Directory",
                            text_align = "center",
                        },
                        {
                            filetype = "dbui",
                            text = "Database Explorer",
                            highlight = "Directory",
                            text_align = "center",
                        },
                        {
                            filetype = "spectre_panel",
                            text = "Project Blurry Search",
                            highlight = "Directory",
                            text_align = "center",
                        },
                        {
                            filetype = "toggleterm",
                            text = "Integrated Terminal",
                            highlight = "Directory",
                            text_align = "center",
                        },
                        {
                            filetype = "mind",
                            text = "Mind Map",
                            highlight = "Directory",
                            text_align = "center",
                        },
                    },
                },
            })

            map("n", "<C-W>d", "<cmd>BufferDelete<cr>", { silent = true }, "Close current buffer")
            map("n", "<C-W><C-D>", "<cmd>BufferDelete<cr>", { silent = true }, "Close current buffer")
            map("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<cr>", { silent = true }, "Go to left buffer")
            map("n", "<Tab>", "<cmd>BufferLineCycleNext<cr>", { silent = true }, "Go to right buffer")
            map("n", "<leader>bn", "<cmd>enew<cr>", { silent = true }, "Create new buffer")
            map("n", "<leader>bh", "<cmd>BufferLineCloseLeft<cr>", { silent = true }, "Close all left buffers")
            map("n", "<leader>bl", "<cmd>BufferLineCloseRight<cr>", { silent = true }, "Close all right buffers")
            map("n", "<leader>bo", function()
                vim.cmd("BufferLineCloseLeft")
                vim.cmd("BufferLineCloseRight")
            end, { silent = true }, "Close all other buffers")
            map("n", "<leader>ba", function()
                vim.cmd("BufferLineCloseLeft")
                vim.cmd("BufferLineCloseRight")
                vim.cmd("BufferDelete")
            end, { silent = true }, "Close all buffers")
            map("n", "<leader>bt", "<cmd>BufferLinePick<cr>", { silent = true }, "Go to buffer *")
            map(
                "n",
                "<leader>bs",
                "<cmd>BufferLineSortByDirectory<cr>",
                { silent = true },
                "Buffers sort (by directory)"
            )
            map("n", "<leader>b1", "<cmd>BufferLineGoToBuffer 1<cr>", { silent = true }, "Go to buffer 1")
            map("n", "<leader>b2", "<cmd>BufferLineGoToBuffer 2<cr>", { silent = true }, "Go to buffer 2")
            map("n", "<leader>b3", "<cmd>BufferLineGoToBuffer 3<cr>", { silent = true }, "Go to buffer 3")
            map("n", "<leader>b4", "<cmd>BufferLineGoToBuffer 4<cr>", { silent = true }, "Go to buffer 4")
            map("n", "<leader>b5", "<cmd>BufferLineGoToBuffer 5<cr>", { silent = true }, "Go to buffer 5")
            map("n", "<leader>b6", "<cmd>BufferLineGoToBuffer 6<cr>", { silent = true }, "Go to buffer 6")
            map("n", "<leader>b7", "<cmd>BufferLineGoToBuffer 7<cr>", { silent = true }, "Go to buffer 7")
            map("n", "<leader>b8", "<cmd>BufferLineGoToBuffer 8<cr>", { silent = true }, "Go to buffer 8")
            map("n", "<leader>b9", "<cmd>BufferLineGoToBuffer 9<cr>", { silent = true }, "Go to buffer 9")
        end,
        -- }}}
    },
    {
        "tpope/vim-dadbod", -- {{{
        -- }}}
    },
    {
        "kristijanhusak/vim-dadbod-ui", -- {{{
        build = { "<CMD>DBUIToggle<CR>" },
        config = function()
            vim.g.dbs = options.database_connect
            vim.g.db_ui_winwidth = 30
            vim.g.db_ui_auto_execute_table_helpers = true
            vim.g.db_ui_execute_on_save = false

            map("n", "<leader>6", function()
                toggle_sidebar("dbui")
                vim.cmd("DBUIToggle")
            end, { silent = true }, "Open Database Explorer")
        end,
        -- }}}
    },
    {
        "akinsho/toggleterm.nvim", -- {{{
        config = function()
            local toggleterm = require("toggleterm")

            local terminals = {
                vert = nil,
                float = nil,
                lazygit = nil,
            }
            local terms = require("toggleterm.terminal").Terminal

            local shell

            if vim.fn.executable("fish") == 1 then
                shell = "fish"
            else
                shell = "bash"
            end

            -- TODO: Make if beutiful
            local function open_callback(term)
                map(
                    "t",
                    "<C-J>",
                    "<c-\\><c-n><cmd>TmuxNavigateDown<cr>",
                    { silent = true, buffer = term.bufnr },
                    "Down"
                )
                map(
                    "t",
                    "<C-H>",
                    "<c-\\><c-n><cmd>TmuxNavigateLeft<cr>",
                    { silent = true, buffer = term.bufnr },
                    "Left"
                )
                map("t", "<C-K>", "<c-\\><c-n><cmd>TmuxNavigateUp<cr>", { silent = true, buffer = term.bufnr }, "Up")
                map(
                    "t",
                    "<C-L>",
                    "<c-\\><c-n><cmd>TmuxNavigateRight<cr>",
                    { silent = true, buffer = term.bufnr },
                    "Right"
                )
                map("n", "<C-N>", "i<C-N>", { silent = true, buffer = term.bufnr }, "Next")
                map("n", "<C-P>", "i<C-P>", { silent = true, buffer = term.bufnr }, "Previous")
                map("n", "<C-C>", "i<C-C>", { silent = true, buffer = term.bufnr }, "Break")
                map("t", "<C-U>", "<c-\\><c-n><C-U>", { silent = true, buffer = term.bufnr }, "ScrollUp")
                map("t", "<C-Y>", "<c-\\><c-n><C-Y>", { silent = true, buffer = term.bufnr }, "ScrollOneUp")
                map("n", "<CR>", "i", { silent = true, buffer = term.bufnr }, "Enter")

                vim.cmd("startinsert")
            end

            local function close_callback()
                map("t", "<esc>", "<c-\\><c-n>", { silent = true }, "Escape terminal insert mode")
            end

            toggleterm.setup({
                start_in_insert = false,
                shade_terminals = true,
                shading_factor = 1,
                size = function(term)
                    if term.direction == "horizontal" then
                        return vim.o.lines * 0.25
                    elseif term.direction == "vertical" then
                        return vim.o.columns * 0.25
                    end
                end,
                on_open = function()
                    vim.wo.spell = false
                end,
                highlights = {
                    Normal = {
                        link = "Normal",
                    },
                    NormalFloat = {
                        link = "NormalFloat",
                    },
                    FloatBorder = {
                        link = "FloatBorder",
                    },
                },
                shell = shell,
            })

            terminals.term = terms:new({
                direction = "horizontal",
                on_open = open_callback,
                on_close = close_callback,
            })

            terminals.vert = terms:new({
                direction = "vertical",
                on_open = open_callback,
                on_close = close_callback,
            })

            terminals.float = terms:new({
                hidden = true,
                count = 120,
                direction = "float",
                float_opts = {
                    border = options.float_border and "double" or "none",
                },
                on_open = function(term)
                    vim.cmd("startinsert")
                    umap({ "t" }, "<esc>")
                    map(
                        "t",
                        "<esc>",
                        "<c-\\><c-n><cmd>close<cr>",
                        { silent = true, buffer = term.bufnr },
                        "Escape float terminal"
                    )
                    map("n", "<C-N>", "i<C-N>", { silent = true, buffer = term.bufnr }, "Next")
                    map("n", "<C-P>", "i<C-P>", { silent = true, buffer = term.bufnr }, "Previous")
                    map("n", "<C-C>", "i<C-C>", { silent = true, buffer = term.bufnr }, "Break")
                    map("t", "<C-U>", "<c-\\><c-n><C-U>", { silent = true, buffer = term.bufnr }, "ScrollUp")
                    map("t", "<C-Y>", "<c-\\><c-n><C-Y>", { silent = true, buffer = term.bufnr }, "ScrollOneUp")
                    map("n", "<CR>", "i", { silent = true, buffer = term.bufnr }, "Enter")
                    map("n", "<esc>", "<cmd>close<cr>", { silent = true, buffer = term.bufnr }, "Close")
                end,
                on_close = close_callback,
            })

            local function lazy_open_callback(term)
                vim.cmd("startinsert")
                umap({ "t" }, "<esc>")
                map("i", "q", "<cmd>close<cr>", { silent = true, buffer = term.bufnr }, "Escape lazygit terminal")
            end

            terminals.lazygit = terms:new({
                cmd = "lazygit",
                count = 130,
                hidden = true,
                direction = "float",
                float_opts = {
                    border = options.float_border and "double" or "none",
                    width = function()
                        return vim.o.columns - 6
                    end,
                    height = function()
                        return vim.o.lines - 6
                    end,
                },
                on_open = lazy_open_callback,
                on_close = close_callback,
            })

            terminals.lazygit_log = terms:new({
                cmd = "lazygit log",
                count = 130,
                hidden = true,
                direction = "float",
                float_opts = {
                    border = options.float_border and "double" or "none",
                    width = function()
                        return vim.o.columns - 6
                    end,
                    height = function()
                        return vim.o.lines - 6
                    end,
                },
                on_open = lazy_open_callback,
                on_close = close_callback,
            })

            terminals.lazygit_branch = terms:new({
                cmd = "lazygit branch",
                count = 130,
                hidden = true,
                direction = "float",
                float_opts = {
                    border = options.float_border and "double" or "none",
                    width = function()
                        return vim.o.columns - 6
                    end,
                    height = function()
                        return vim.o.lines - 6
                    end,
                },
                on_open = lazy_open_callback,
                on_close = close_callback,
            })

            map("n", "<leader>tt", function()
                terminals.term:toggle()
            end, { silent = true }, "Toggle bottom or vertical terminal")
            map("n", "<leader>tf", function()
                terminals.float:toggle()
            end, { silent = true }, "Toggle floating terminal")
            map("n", "<leader>tv", function()
                terminals.vert:toggle()
            end, { silent = true }, "Toggle vertical terminal")

            map("n", "<leader>gg", function()
                terminals.lazygit_branch:toggle()
            end, { silent = true }, "Toggle lazygit terminal")
            map("n", "<leader>gll", function()
                terminals.lazygit_log:toggle()
            end, { silent = true }, "Toggle lazygit log")
            map("n", "<leader>glf", function()
                local lterm = terms:new({
                    cmd = "lazygit log -f " .. vim.fn.expand("%"),
                    count = 130,
                    hidden = true,
                    direction = "float",
                    float_opts = {
                        border = options.float_border and "double" or "none",
                        width = function()
                            return vim.o.columns - 6
                        end,
                        height = function()
                            return vim.o.lines - 6
                        end,
                    },
                    on_open = lazy_open_callback,
                    on_close = close_callback,
                })
                lterm:toggle()
            end, { silent = true }, "Toggle lazygit log")
            map("n", "<leader>gs", function()
                terminals.lazygit:toggle()
            end, { silent = true }, "Toggle lazygit status")
        end,
        -- }}}
    },
    {
        "kevinhwang91/nvim-bqf", -- {{{
        config = function()
            local bqf = require("bqf")
            bqf.setup({
                func_map = {
                    tab = "<C-t>",
                    vsplit = "<C-v>",
                    split = "<C-s>",
                },
                filter = {
                    fzf = {
                        action_for = {
                            ["ctrl-t"] = "tabedit",
                            ["ctrl-v"] = "vsplit",
                            ["ctrl-s"] = "split",
                        },
                    },
                },
            })

            local function toggle_qf()
                local qf_exists = false
                for _, win in pairs(vim.fn.getwininfo()) do
                    if win["quickfix"] == 1 then
                        qf_exists = true
                    end
                end
                if qf_exists == true then
                    vim.cmd("cclose")
                    return
                end
                if not vim.tbl_isempty(vim.fn.getqflist()) then
                    vim.cmd("copen")
                end
            end

            map("n", "<leader>tq", toggle_qf, { silent = true }, "Toggle qf")
        end,
        -- }}}
    },
    -- {
    --     "dhruvasagar/vim-zoom", -- {{{
    --     config = function()
    --         map("n", "<leader>z", function()
    --             local zoom_ntree = false
    --             local zoom_tag = false
    --             local all_win_buf_ft = get_all_win_buf_ft()
    --
    --             for _, opts in ipairs(all_win_buf_ft) do
    --                 if opts.buf_ft == "aerial" then
    --                     zoom_tag = true
    --                     vim.cmd("AerialCloseAll")
    --                 end
    --                 if opts.buf_ft == "NvimTree" then
    --                     zoom_ntree = true
    --                     vim.cmd("NvimTreeClose")
    --                 end
    --             end
    --
    --             vim.cmd([[call zoom#toggle()]])
    --
    --             if zoom_ntree then
    --                 vim.cmd("NvimTreeOpen")
    --                 vim.api.nvim_command(":wincmd p")
    --             end
    --
    --             if zoom_tag then
    --                 vim.cmd("AerialOpen")
    --                 vim.api.nvim_command(":wincmd p")
    --             end
    --         end, { silent = true, noremap = true }, "Zoom")
    --     end,
    --     -- }}}
    -- },
    {
        "nyngwang/NeoZoom.lua", -- {{{
        config = function()
            require("neo-zoom").setup({
                winopts = {
                    offset = {
                        width = 0.9,
                        height = 0.85,
                    },
                    border = "single",
                },
                -- disable_by_cursor = true, -- zoom-out/unfocus when you click anywhere else.
                exclude_filetypes = { "lspinfo", "mason", "lazy", "fzf" },
                -- exclude_buftypes = { 'terminal' },
                presets = {
                    {
                        filetypes = { "dapui_.*", "dap-repl" },
                        config = {
                            top = 0.25,
                            left = 0.6,
                            width = 0.4,
                            height = 0.65,
                        },
                        callbacks = {
                            function()
                                vim.wo.wrap = true
                            end,
                        },
                    },
                },
            })
            vim.keymap.set("n", "<leader>z", function()
                vim.cmd("NeoZoomToggle")
            end, { silent = true, nowait = true })
        end,
    },
    -- }}}
    -- }}}
}
-- Load Plugins
require("lazy").setup(plugins, {})
-- }}}
-- > Load after {{{

-- auto save buffer
if options.auto_save then
    vim.api.nvim_create_autocmd({ "InsertLeave", "TextChanged" }, {
        pattern = { "*" },
        command = "silent! wall",
        nested = true,
    })
end

-- switch input method
if options.auto_switch_input then
    vim.api.nvim_create_autocmd({ "InsertLeave" }, {
        pattern = { "*" },
        callback = function()
            local input_status = tonumber(vim.fn.system("fcitx5-remote"))
            if input_status == 2 then
                vim.fn.system("fcitx5-remote -c")
            end
        end,
    })
end

-- auto restore cursor position
if options.auto_restore_cursor_position then
    vim.api.nvim_create_autocmd("BufReadPost", {
        pattern = "*",
        callback = function()
            if vim.fn.line("'\"") > 0 and vim.fn.line("'\"") <= vim.fn.line("$") then
                vim.fn.setpos(".", vim.fn.getpos("'\""))
                -- how do I center the buffer in a sane way??
                -- vim.cmd('normal zz')
                vim.cmd("silent! foldopen")
            end
        end,
    })
end

-- remove auto-comments
if options.auto_remove_new_lines_comment then
    vim.api.nvim_create_autocmd({ "BufEnter" }, {
        pattern = "*",
        callback = function()
            vim.opt.formatoptions = vim.opt.formatoptions - { "c", "r", "o" }
        end,
    })
end

-- auto toggle rnu
if options.auto_toggle_rnu then
    vim.wo.rnu = true
    vim.api.nvim_create_autocmd({ "InsertLeave" }, {
        pattern = { "*" },
        callback = function()
            if vim.api.nvim_get_option("showcmd") then
                vim.wo.rnu = true
            end
        end,
    })
    vim.api.nvim_create_autocmd({ "InsertEnter" }, {
        pattern = { "*" },
        callback = function()
            if vim.api.nvim_get_option("showcmd") then
                vim.wo.rnu = false
            end
        end,
    })
end

-- auto hide cursorline
if options.auto_hide_cursorline then
    vim.api.nvim_create_autocmd({ "InsertLeave" }, {
        pattern = { "*" },
        command = "set cursorline",
    })
    vim.api.nvim_create_autocmd({ "InsertEnter" }, {
        pattern = { "*" },
        command = "set nocursorline",
    })
end

-- UserCmd
vim.api.nvim_create_user_command("BufferDelete", function()
    ---@diagnostic disable-next-line: missing-parameter
    local file_exists = vim.fn.filereadable(vim.fn.expand("%p"))
    local modified = vim.api.nvim_buf_get_option(0, "modified")

    if file_exists == 0 and modified then
        local user_choice = vim.fn.input("The file is not saved, whether to force delete? Press enter or input [y/n]:")
        if user_choice == "y" or string.len(user_choice) == 0 then
            vim.cmd("bd!")
        end
        return
    end

    local force = not vim.bo.buflisted or vim.bo.buftype == "nofile"
    if force then
        vim.cmd("bd!")
    else
        local bufnr = vim.api.nvim_get_current_buf()
        vim.cmd("bp")
        if vim.api.nvim_buf_is_loaded(bufnr) then
            vim.cmd(string.format("bd! %s", bufnr))
        end
    end
end, { desc = "Delete the current Buffer while maintaining the window layout" })
-- }}}
-- > Load local {{{
vim.api.nvim_exec(
    [[
  try
  source ~/.vimrc.local
  catch
  " Ignoring
  endtry
  ]] ,
    true
)
-- }}}
