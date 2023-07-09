local has_lspconfig, lspconfig = pcall(require, "lspconfig")
if not has_lspconfig then
  return
end

local cmp_nvim_lsp_status, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_nvim_lsp_status then
  return
end

local disable_builtin_lsp_formatter = function(client)
  client.server_capabilities.document_formatting = false
  client.server_capabilities.document_range_formatting = false
end

require("rust-tools").setup({
  server  = {
    on_attach = function(client, bufnr)
      -- Hover actions
      -- vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })

      -- Code action groups
      -- vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
      require 'illuminate'.on_attach(client)
    end,
    settings = {
      ['rust-analyzer'] = {
        checkOnSave = {
          command = "clippy"
        }
      }
    }
  }
})

-- used to enable autocompletion (assign to every lsp server config)
local capabilities = cmp_nvim_lsp.default_capabilities()
lspconfig.jsonls.setup {
  capabilities = capabilities,
  on_attach = disable_builtin_lsp_formatter,
}

lspconfig.pyright.setup {
  capabilities = capabilities,
  on_attach = disable_builtin_lsp_formatter,
}

lspconfig.tsserver.setup {
  capabilities = capabilities,
  on_attach = disable_builtin_lsp_formatter,
}

lspconfig.lua_ls.setup({
  capabilities = {},
  commands = {
    Format = {
      function()
        require("stylua-nvim").format_file()
      end,
    },
  },
})

lspconfig.yamlls.setup {
  capabilities = capabilities,
  filetypes = { "yaml", "yml" },
  settings = {
    yaml = {
      completion = true,
      customTags = {
        "!And",
        "!If",
        "!Not",
        "!Equals",
        "!Equals sequence",
        "!Or",
        "!FindInMap sequence",
        "!Base64",
        "!Cidr",
        "!Ref",
        "!Sub",
        "!GetAtt",
        "!GetAZs",
        "!ImportValue",
        "!Select",
        "!Select sequence",
        "!Split",
        "!Join sequence"
      },
      format = {
        enable = true,
      },
      hover = true,
      validate = true,
    },
  },
}

-- These server just use the vanilla setup
local servers = { "bashls", "dockerls", "html", "cssls", "tailwindcss", "gopls" }
for _, server in pairs(servers) do
  lspconfig[server].setup({ capabilities = capabilities })
end
