-- import lspsaga safely
local saga_status, saga = pcall(require, "lspsaga")
if not saga_status then
  return
end

saga.setup({
  lightbulb = {
    enable = false
  },
  code_action = {
    extend_gitsigns = true
  }
  -- symbol_in_winbar = {
  --   enable = true,
  --   separator = " > ",
  --   ignore_patterns = {},
  --   hide_keyword = true,
  --   show_file = true,
  --   folder_level = 2,
  --   respect_root = false,
  --   color_mode = true,
  -- },
})
