local M = {}

---------------------------- plugin requires -----------------------------
local cmp_status_ok, cmp = pcall(require, 'cmp')
if not cmp_status_ok then
  return
end

local snip_status_ok, luasnip = pcall(require, 'luasnip')
if not snip_status_ok then
  return
end

local tele_action_status_ok, actions = pcall(require, 'telescope.actions')
if not tele_action_status_ok then
  return
end

local fold_ufo_status_ok, ufo = pcall(require, 'ufo')
if not fold_ufo_status_ok then
  return
end

-------------------------------------------------------------------------------

local opts = { noremap = true, silent = true}

local term_opts = { silent =  true }

local keymap = vim.api.nvim_set_keymap

keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '


----------------------------------- plugin remappings -----------------------------

local check_backspace = function()
  local col = vim.fn.col "." - 1
  return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
end

M.cmpMaps = {
    ["<c-k>"] = cmp.mapping.select_prev_item(),
		["<c-j>"] = cmp.mapping.select_next_item(),
    ["<c-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
    ["<c-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
    ["<c-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
    ["<c-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    ["<c-e>"] = cmp.mapping {
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    },
    ["<CR>"] = cmp.mapping.confirm { select = true },
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expandable() then
        luasnip.expand()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif check_backspace() then
        fallback()
      else
        fallback()
      end
    end, { 
      "i", "s",
    }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, {
      "i",
      "s",
    }),
}

M.telescopeMaps = {
      i = {
        ["<c-j>"] = actions.move_selection_next,
        ["<c-k>"] = actions.move_selection_previous,
        ["<c-u>"] = actions.preview_scrolling_up,
        ["<c-d>"] = actions.preview_scrolling_down,
      },
      n = {
        ["<esc>"] = actions.close,
        ["j"] = actions.move_selection_next,
        ["k"] = actions.move_selection_previous,
        ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
        ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
      },
}

keymap('n', '<leader>f', '<cmd>Telescope find_files<cr>', opts)
keymap('n', '<leader>g', '<cmd>Telescope live_grep<cr>', opts)
keymap('n', '<leader>m', '<cmd>Telescope media_files<cr>', opts)

M.lspHandlersMaps = function(bufnr)
  local api = vim.api
  api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  --api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  api.nvim_buf_set_keymap(bufnr, 'n', '[d', '<cmd>lua vim.diagnostic.goto_prev({border="rounded"})<CR>', opts)
  api.nvim_buf_set_keymap(bufnr, 'n', 'gl', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  api.nvim_buf_set_keymap(bufnr, 'n', ']d', '<cmd>lua vim.diagnostic.goto_prev({border="rounded"})<CR>', opts)
  api.nvim_buf_set_keymap(bufnr, 'n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
end

vim.cmd [[ command! Format execute 'lua vim.lsp.buf.format()' ]]

keymap('n', '<leader>p', ':TSPlaygroundToggle<cr>', opts)

keymap('n', 'F', ':Format<cr>', opts)

vim.keymap.set('n', 'foa', ufo.openAllFolds)
vim.keymap.set('n', 'fca', ufo.closeAllFolds)
keymap('n', 'fo', 'zo', opts)
keymap('n', 'fc', 'zfj', opts)

-----------------------------------------------------------------------------------




-- normal mode --
keymap("n", "<c-h>", "<C-w>h", opts)
keymap("n", "<c-j>", "<C-w>j", opts)
keymap("n", "<c-k>", "<C-w>k", opts)
keymap("n", "<c-l>", "<C-w>l", opts)

keymap("n", "<leader>e", ":NvimTreeFindFileToggle<CR>", opts)

-- move text
vim.cmd([[
nnoremap <A-k> :m .-2<CR>==
  nnoremap <A-j> :m .+1<CR>==
]])


-- resize with arrows -- 
keymap('n', '<c-Up>', ':resize +2<CR>', opts)
keymap('n', '<c-Down>', ':resize -2<CR>', opts)
keymap('n', '<c-Left>', ':vertical resize -2<CR>', opts)
keymap('n', '<c-Right>', ':vertical resize +2<CR>', opts)

-- Insert -- 
keymap('i', 'jj', '<ESC>', opts)

-- visual --
-- Stay in indent mode 
keymap('v', '<', '<gv', opts)
keymap('v', '>', '>gv', opts)

-- Move text up and Down
vim.cmd([[
vnoremap <A-k> :m .-2<CR>gv=gv
vnoremap <A-j> :m '>+1<CR>gv=gv
]])

keymap('v', 'p', '"_dP', opts)

-- Terminal --
-- Navigation
keymap('t', '<c-h>', '<C-\\><C-N><C-w>h', term_opts)
keymap('t', '<c-j>', '<C-\\><C-N><C-w>j', term_opts)
keymap('t', '<c-k>', '<C-\\><C-N><C-w>k', term_opts)
keymap('t', '<c-l>', '<C-\\><C-N><C-w>l', term_opts)





-- extra utils
keymap('n', '<leader>h', ':nohlsearch<cr>', opts)



return M
