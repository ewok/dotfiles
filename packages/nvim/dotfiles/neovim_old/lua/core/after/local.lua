  vim.api.nvim_exec([[
  try
  source ~/.vimrc.local
  catch
  " Ignoring
  endtry
  ]], true)
