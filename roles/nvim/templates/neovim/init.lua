local plugins_path = vim.fn.stdpath("data") .. "/lazy"
-- Bootstrap lazy.nvim
local lazy_path = plugins_path .. "/lazy.nvim"
if not vim.loop.fs_stat(lazy_path) then
  vim.notify("Bootstrapping lazy.nvim...", vim.log.levels.INFO)
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--single-branch",
    "https://github.com/folke/lazy.nvim.git",
    lazy_path,
  })
end
-- Bootstrap hotpot.nvim
local hotpot_path = plugins_path .. "/hotpot.nvim"
if not vim.loop.fs_stat(hotpot_path) then
  vim.notify("Bootstrapping hotpot.nvim...", vim.log.levels.INFO)
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--single-branch",
    "https://github.com/rktjmp/hotpot.nvim.git",
    hotpot_path,
  })
end
-- Add lazy.nvim to rtp
vim.opt.runtimepath:prepend(lazy_path)
-- Add hotpot.nvim to rtp
vim.opt.runtimepath:prepend(hotpot_path)
-- Generate plugins table
local plugins = {
  { "rktjmp/hotpot.nvim" },
}
-- Configure hotpot.nvim
require("hotpot").setup({
  provide_require_fennel = true,
})
-- Load configuration
require("init")
-- Add plugins to table
local ft_path = vim.fn.stdpath("config") .. "/fnl/ft"
if vim.loop.fs_stat(ft_path) then
  for file in vim.fs.dir(ft_path) do
    file = file:match("^(.*)%.fnl$")
    if file then
      require("ft." .. file)
    end
  end
end

local plugins_path = vim.fn.stdpath("config") .. "/fnl/plugins"
if vim.loop.fs_stat(plugins_path) then
  for file in vim.fs.dir(plugins_path, { depth = 2 }) do
    file = file:match("^(.*)%.fnl$")
    if file then
      plugins[#plugins + 1] = require("plugins." .. file)
    end
  end
end
-- -- Add conf.lsp to plugins table
-- plugins[#plugins + 1] = require("conf.lsp")

-- Configure lazy.nvim
require("lazy").setup(plugins)
