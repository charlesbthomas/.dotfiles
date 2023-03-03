metals_config = require("metals").bare_config()

-- !WARNING! These settings are recommended on the Metals website, but they totally 
-- don't work in my setup. I have no idea why.
--
-- metals_config.init_options.statusBarProvider = "on"
-- metals_config.capabilities = require("cmp_nvim_lsp").default_capabilities()

metals_config.settings = {
  showImplicitArguments = true,
}

  -- Debug settings if you're using nvim-dap
local dap = require("dap")

dap.configurations.scala = {
  {
    type = "scala",
    request = "launch",
    name = "RunOrTest",
    metals = {
      runType = "runOrTestFile",
      --args = { "firstArg", "secondArg", "thirdArg" }, -- here just as an example
    },
  },
  {
    type = "scala",
    request = "launch",
    name = "Test Target",
    metals = {
      runType = "testTarget",
    },
  },
}

metals_config.on_attach = function(client, bufnr)
  require("metals").setup_dap()
end

local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true }) 
vim.api.nvim_create_autocmd("FileType", { pattern = { "scala", "sbt" },
  callback = function()
    require("metals").initialize_or_attach(metals_config)
  end,
  group = nvim_metals_group,
})
 
-- Debugging util.
-- function tprint (tbl, indent)
--   if not indent then indent = 0 end
--   for k, v in pairs(tbl) do
--     formatting = string.rep("  ", indent) .. k .. ": "
--     if type(v) == "table" then
--       print(formatting)
--       tprint(v, indent+1)
--     elseif type(v) == 'boolean' then
--       print(formatting .. tostring(v))      
--     else
--       print(formatting .. v)
--     end
--   end
-- end
-- tprint(metals_config.capabilities)
