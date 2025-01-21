return {
  'scalameta/nvim-metals',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  opts = function()
    local metals_config = require('metals').bare_config()

    metals_config.on_attach = function(client, bufnr)
      require('metals').setup_dap()
    end

    metals_config.settings = {
      serverVersion = '1.4.2',
      showImplicitArguments = true,
      excludedPackages = { 'akka.actor.typed.javadsl', 'com.github.swagger.akka.javadsl' },
      testUserInterface = 'Test Explorer',
      javaHome = '/Users/charlie/.sdkman/candidates/java/11.0.24-amzn/',
      -- javaHome = '/Users/charlie/.sdkman/candidates/java/21.0.5-amzn',
      bloopJvmProperties = {
        '-Xmx16G',
        '-XX:+UseZGC',
        '-Xss4m',
      },
    }

    return metals_config
  end,
  config = function(self, metals_config)
    local nvim_metals_group = vim.api.nvim_create_augroup('nvim-metals', { clear = true })
    vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWinEnter' }, {
      pattern = { '*.scala', '*.sbt', '*.java', 'pom.xml' },
      callback = function()
        require('metals').initialize_or_attach(metals_config)
      end,
      group = nvim_metals_group,
    })
  end,
}
