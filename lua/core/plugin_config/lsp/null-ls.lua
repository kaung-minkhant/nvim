local status_ok, null_ls = pcall(require, 'null-ls')
if not status_ok then
  return
end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup({
  debug = false,
  sources = {
    formatting.prettier.with { extra_args = { '--no-semi', '--jsx-single-quote', '--single-quote' } },
    formatting.black.with { extra_args = { '--fast' } },
    formatting.stylua,
    formatting.emacs_vhdl_mode,
    --[[ formatting.latexindent, ]]
    diagnostics.flake8,
  },
})
