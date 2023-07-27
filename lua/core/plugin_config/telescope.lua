local status_ok, telescope = pcall(require, 'telescope')
if not status_ok then
  return
end

local keymap_status_ok, keymaps = pcall(require, 'core.keymaps')
if not keymap_status_ok then
  return
end


telescope.load_extension('media_files')

telescope.setup({
  defaults = {
    mappings = keymaps.telescopeMaps,
    prompt_prefix = ' ',
    selection_caret = ' ',
    sorting_strategy = 'descending',
    path_display = { 'smart' },
  },
  extensions = {
    media_files = {
      filetypes = {'png', 'webp', 'jpg', 'jpeg', 'svg'},
      find_cmd = 'rg',
    },
  },
})
