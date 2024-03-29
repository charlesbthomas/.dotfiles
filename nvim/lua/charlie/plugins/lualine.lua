-- import lualine plugin safely
local status, lualine = pcall(require, "lualine")
if not status then
  return
end

lualine.setup({
  options = {
    theme = 'tokyonight',
    component_separators = '|',
    section_separators = { left = '', right = '' },
    globalstatus = true
  },
  sections = {
    lualine_a = {
      { 'mode', separator= {left=' '},right_padding = 2 },
    },
    lualine_b = { 'filename' },
    lualine_c = {},
    lualine_x = {},
    lualine_y = { 'branch' },
    lualine_z = {
      { 'location', separator = { right = ' ' }, left_padding = 2 },
    },
  },
  -- inactive_sections = {
  --   lualine_a = { 'filename' },
  --   lualine_b = {},
  --   lualine_c = {},
  --   lualine_x = {},
  --   lualine_y = {},
  --   lualine_z = { 'location' },
  -- }
})
