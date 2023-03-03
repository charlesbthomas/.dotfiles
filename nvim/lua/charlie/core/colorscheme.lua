-- set colorscheme to nightfly with protected call
-- in case it isn't installed
-- local status, _ = pcall(vim.cmd, "colorscheme nightfly")
-- if not status then
--   print("Colorscheme not found!") -- print error if colorscheme not installed
--   return
-- end
--
-- set colorscheme to tokyonight with protected call
local status, _ = pcall(vim.cmd, "colorscheme tokyonight")
if not status then
  print("Colorscheme not found!") -- print error if colorscheme not installed
  return
end
require("transparent").setup({})
vim.g.tokyonight_transparent = vim.g.transparent_enabled
