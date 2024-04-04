-------------------------------------------------------------
-- Mason
-- Installs language servers, debuggers, linters, etc.
-- https://github.com/williamboman/mason-lspconfig.nvim#setup
-------------------------------------------------------------
local has_mason, mason = pcall(require, "mason")
if not has_mason then
  return
end
mason.setup()

local has_mason_lspconfig, mason_lspconfig = pcall(require, "mason-lspconfig")
if not has_mason_lspconfig then
  return
end

local mason_null_ls_status, mason_null_ls = pcall(require, "mason-null-ls")
if not mason_null_ls_status then
  return
end

mason_lspconfig.setup({
  automatic_installation = true,
  ensure_installed = {
    "bashls",
    "css-lsp",
    "tailwindcss",
    "dockerls",
    "eslint",
    "lua_ls",
    "html",
    "jsonls",
    "tsserver",
    "yaml-language-server",
    "pyright",
    "gopls",
    "vue-language-server",
  },
})

mason_null_ls.setup({
  -- list of formatters & linters for mason to install
  ensure_installed = {
    "prettier", -- ts/js formatter
    "stylua",   -- lua formatter
    "eslint_d", -- ts/js linter
  },
  -- auto-install configured formatters & linters (with null-ls)
  automatic_installation = true,
})
