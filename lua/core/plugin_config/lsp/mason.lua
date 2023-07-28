local servers = {
  'lua_ls',
  --[[ 'jsonls', ]]
  'texlab',
  'pyright',
  'tsserver',
}

local settings = {
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗"
    },
  },
  log_level = vim.log.levels.INFO,
  max_concurrent_installers = 4,
}


require('mason').setup(settings)
require('mason-lspconfig').setup({
  ensure_install = servers,
  automatic_installation = true
})


local lspconfig_status_ok, lspconfig = pcall(require, 'lspconfig')
if not lspconfig_status_ok then
  return
end

local opts = {}

for _, server in pairs(servers) do
  opts = {
    on_attach = require('core.plugin_config.lsp.handlers').on_attach,
    capabilities = require('core.plugin_config.lsp.handlers').addCapabilities(),
  }
  -- server = vim.split(server, '@')[1]
  -- print(server)
  local require_ok, conf_opts = pcall(require, 'core.plugin_config.lsp.settings.' .. server)
  if require_ok then
    opts = vim.tbl_deep_extend('force', conf_opts, opts)
  end
  lspconfig[server].setup(opts)
end
