-- set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

---------------------
-- General Keymaps
---------------------

-- quick save
keymap.set("n", "<C-s>", ":w<cr>")

-- use jk to exit insert mode
keymap.set("i", "jk", "<ESC>")

-- clear search highlights
keymap.set("n", "<leader>nh", ":nohl<CR>")

-- delete single character without copying into register
keymap.set("n", "x", '"_x')

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>") -- increment
keymap.set("n", "<leader>-", "<C-x>") -- decrement

-- window management
keymap.set("n", "<leader>s|", "<C-w>v")          -- split window vertically
keymap.set("n", "<leader>s-", "<C-w>s")          -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=")          -- make split windows equal width & height
keymap.set("n", "<leader>sx", ":close<CR>")      -- close current split window

keymap.set("n", "<leader>to", ":tabnew<CR>")     -- open new tab
keymap.set("n", "<leader>tx", ":tabclose  <CR>") -- close current tab
keymap.set("n", "<leader>tn", ":tabn<CR>")       --  go to next tab
keymap.set("n", "<leader>tp", ":tabp<CR>")       --  go to previous tab

keymap.set("n", "<C-d>", "<C-d>zz")
keymap.set("n", "<C-u>", "<C-u>zz")
----------------------
-- Plugin Keybinds
----------------------

-- vim-maximizer
keymap.set("n", "<leader>sm", ":MaximizerToggle<CR>") -- toggle split window maximization

-- nvim-tree
keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>") -- toggle file explorer

-- telescope
keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>")  -- find files within current working directory, respects .gitignore
keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>")   -- find string in current working directory as you type
keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>") -- find string under cursor in current working directory
keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>")     -- list open buffers in current neovim instance
keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>")   -- list available help tags
keymap.set("n", "<Leader>fr", ":Telescope oldfiles<CR>", { noremap = true, silent = true })
keymap.set("n", "<leader>mc", require("telescope").extensions.metals.commands)
local builtin = require('telescope.builtin')
keymap.set('n', '<leader>fp', builtin.commands, {})
keymap.set('n', '<leader>fgr', builtin.lsp_references, {})
keymap.set('n', '<leader>fws', builtin.lsp_dynamic_workspace_symbols, {})
keymap.set('n', '<leader>fi', builtin.lsp_implementations, {})
keymap.set('n', '<leader>fd', builtin.lsp_definitions, {})


keymap.set("n", "<Leader>i", ":MetalsOrganizeImports<CR>")
keymap.set("n", "gD", function()
  vim.lsp.buf.definition()
end)

-- keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts) -- show documentation for what is under cursor
keymap.set("n", "K", function()
  vim.lsp.buf.hover()
end)

local remap = keymap.set
local opts = { noremap = true, silent = true, buffer = bufnr }

-- map("n", "gf", "<cmd>Lspsaga lsp_finder<CR>", opts)

remap("n", "gi", function()
  vim.lsp.buf.implementation()
end)

remap("n", "gr", function()
  vim.lsp.buf.references()
end)

remap("n", "gds", function()
  vim.lsp.buf.document_symbol()
end)

remap("n", "gws", function()
  vim.lsp.buf.workspace_symbol()
end)

remap("n", "<leader>cl", function()
  vim.lsp.codelens.run()
end)

remap("n", "<leader>sh", function()
  vim.lsp.buf.signature_help()
end)

remap("n", "<leader>rn", function()
  vim.lsp.buf.rename()
end)

remap("n", "<leader>f", function()
  vim.lsp.buf.format()
end)


remap("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts)
-- remap("n", "<leader>ca", function()
--   vim.lsp.buf.code_action()
-- end)

remap("n", "<leader>ws", function()
  require("metals").hover_worksheet()
end)

-- all workspace diagnostics
remap("n", "<leader>aa", function()
  vim.diagnostic.setqflist()
end)

-- all workspace errors
remap("n", "<leader>ae", function()
  vim.diagnostic.setqflist({ severity = "E" })
end)

-- all workspace warnings
remap("n", "<leader>aw", function()
  vim.diagnostic.setqflist({ severity = "W" })
end)

-- buffer diagnostics only
keymap.set("n", "<leader>d", "<cmd>Lspsaga show_line_diagnostics<CR>", opts) -- show  diagnostics for line
-- map("n", "<leader>d", function()
--   vim.diagnostic.setloclist()
-- end)
--
remap("n", "[c", function()
  vim.diagnostic.goto_prev({ wrap = false })
end)

remap("n", "]c", function()
  vim.diagnostic.goto_next({ wrap = false })
end)

-- Example mappings for usage with nvim-dap. If you don't use that, you can
-- skip these
vim.keymap.set('n', '<F5>', function() require('dap').continue() end)
vim.keymap.set('n', '<F10>', function() require('dap').step_over() end)
vim.keymap.set('n', '<F11>', function() require('dap').step_into() end)
vim.keymap.set('n', '<F12>', function() require('dap').step_out() end)
vim.keymap.set('n', '<Leader>b', function() require('dap').toggle_breakpoint() end)
vim.keymap.set('n', '<Leader>B', function() require('dap').set_breakpoint() end)
vim.keymap.set('n', '<Leader>dr', function() require('dap').repl.open() end)
vim.keymap.set('n', '<Leader>dl', function() require('dap').run_last() end)
vim.keymap.set({ 'n', 'v' }, '<Leader>dh', function()
  require('dap.ui.widgets').hover()
end)
vim.keymap.set({ 'n', 'v' }, '<Leader>dp', function()
  require('dap.ui.widgets').preview()
end)
vim.keymap.set('n', '<Leader>df', function()
  local widgets = require('dap.ui.widgets')
  widgets.centered_float(widgets.frames)
end)
vim.keymap.set('n', '<Leader>ds', function()
  local widgets = require('dap.ui.widgets')
  widgets.centered_float(widgets.scopes)
end)

vim.keymap.set("n", "<leader>zz", function()
  require("zen-mode").toggle()
end)

vim.keymap.set("n", "<leader>tt", function()
  require("transparent").toggle_transparent()
end)

local harpoon_mark = require("harpoon.mark")
remap("n", "<leader>ha", function()
  harpoon_mark.add_file()
end)

local harpoon_ui = require("harpoon.ui")
remap("n", "<leader>ht", function()
  harpoon_ui.toggle_quick_menu()
end)
remap("n", "<leader>hn", function()
  harpoon_ui.nav_next()
end)
remap("n", "<leader>hp", function()
  harpoon_ui.nav_prev()
end)

local harpoon_term = require("harpoon.term")
remap("n", "<leader>hr", function()
  harpoon_term.gotoTerminal(1)
end)
