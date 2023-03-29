-- import nvim-tree plugin safely
local setup, nvimtree = pcall(require, "nvim-tree")
if not setup then
  return
end

-- recommended settings from nvim-tree documentation
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
nvimtree.setup({
  view = {
    width = 60,
  },
  renderer = {
    group_empty = true,
    icons = {
      glyphs = {
        folder = {
          arrow_closed = "", -- arrow when folder is closed
          arrow_open = "", -- arrow when folder is open
        },
      },
    },
  },
  update_focused_file = {
    enable = true
  },
  actions = {
    open_file = {
      window_picker = {
        enable = false,
      },
    },
  },
  git = {
    ignore = false,
  }
})
