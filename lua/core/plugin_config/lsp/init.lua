local status_ok, _ = pcall(require, 'lspconfig')
if not status_ok then
  return
end

require('core.plugin_config.lsp.mason')
require('core.plugin_config.lsp.handlers').setup()
require('core.plugin_config.lsp.null-ls')

if not require'lspconfig.configs'.hdl_checker then
  require'lspconfig.configs'.hdl_checker = {
    default_config = {
    cmd = {"hdl_checker", "--lsp", };
    filetypes = {"vhdl", "verilog", "systemverilog"};
      root_dir = function(fname)
        -- will look for the .hdl_checker.config file in parent directory, a
        -- .git directory, or else use the current directory, in that order.
        local util = require'lspconfig'.util
        return util.root_pattern('.hdl_checker.config')(fname) or util.find_git_ancestor(fname) or util.path.dirname(fname)
      end;
      settings = {};
    };
  }
end

require('lspconfig').hdl_checker.setup {}
