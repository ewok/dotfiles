local api = require("utils.api")
local options = {}

options.transparent = false
options.float_border = true
options.download_source = "https://github.com/"
options.show_winbar = false

options.snippets_directory = api.path.join(vim.fn.stdpath("config"), "snippets")

-- auto command manager
options.auto_save = true
options.auto_switch_input = false
options.auto_restore_cursor_position = true
options.auto_remove_new_lines_comment = true
options.auto_toggle_rnu = true
options.auto_hide_cursorline = true

options.blacklist_bufftypes = {
    'dashboard',
    'dashpreview',
    'help',
    'nerdtree',
    'nofile',
    'nvimtree',
    'NvimTree',
    'sagahover',
    'startify',
    'terminal',
    'vista',
    'which_key',
    'coc-explorer',
    'packer',
    'neo-tree',
}

options.blacklist_filetypes = {
    'dashboard',
    'dashpreview',
    'help',
    'nerdtree',
    'nofile',
    'nvimtree',
    'NvimTree',
    'sagahover',
    'startify',
    'terminal',
    'vista',
    'which_key',
    'coc-explorer',
    'packer',
    'neo-tree',
}

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
return options
