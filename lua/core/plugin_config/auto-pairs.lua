local status_ok, npairs = pcall(require, 'nvim-autopairs')
if not status_ok then
  return
end


npairs.setup({
  disable_filetype = { 'TelescopePrompt', 'spectre_panel'},
  check_ts = true,
  ts_config = {
    lua = {},
    javascript = {'template_string'},
    java = false,
  },
  enable_check_bracket_line = false,
  ignore_next_char = '[%w%.]',
  fast_wrap = {
    map = '<M-e>',
    chars = { '{', '[', '(', '"', "'" },
    pattern = [=[[%'%"%>%]%)%}%,]]=],
    end_key = '$',
    keys = 'qwertyuiopzxcvbnmasdfghjkl',
    check_comma = true,
    manual_position = true,
    highlight = 'Search',
    highlight_grey='Comment'
  },
})

local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local cmp_status_ok, cmp = pcall(require, 'cmp')
if not cmp_status_ok then
  return
end
cmp.event:on(
  'confirm_done',
  cmp_autopairs.on_confirm_done({ map_char = { tex = '' }})
)
