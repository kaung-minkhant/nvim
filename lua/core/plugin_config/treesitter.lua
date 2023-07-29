local status_ok, treesitterConfigs = pcall(require, 'nvim-treesitter.configs')
if not status_ok then
  return
end

treesitterConfigs.setup{
  ensure_installed = 'all',
  ignore_install = { '' },
  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true,
    disable = { '' },
    additional_vim_regex_highlighting = true,
  },
  indent = { enable = true, disable = { 'yaml' } },
  rainbow = {
    enable = true,
    disable = { 'javascript' },
  },
  playground = {
    enable = true,
  },
  autopairs = {
    enable = true,
  },
  autotag = {},
  context_commentstring = {
    enable = true,
    enable_autocmd = false, 
    --[[ config = {
      javascript = {
        __default = '// %s',
        jsx_element = '{/* %s */}',
      },
    }, ]]
  },
}

