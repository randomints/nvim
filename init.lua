vim.filetype.add({
  extension = {
    ino = "arduino",
    pde = "arduino",
  },
})

require("config.lazy")

local set = vim.opt_local
set.number = true
set.relativenumber = true
set.expandtab = true
set.tabstop = 2
set.softtabstop = 2
set.shiftwidth = 2
set.clipboard = "unnamedplus"

-- Navigate vim panes better
vim.keymap.set('n', '<c-k>', ':wincmd k<CR>')
vim.keymap.set('n', '<c-j>', ':wincmd j<CR>')
vim.keymap.set('n', '<c-h>', ':wincmd h<CR>')
vim.keymap.set('n', '<c-l>', ':wincmd l<CR>')

vim.keymap.set("n", "<space><space>x", "<cmd>source %<CR>")
vim.keymap.set("n", "<space>x", ":.lua<CR>")
vim.keymap.set("v", "<space>x", ":lua<CR>")

vim.keymap.set("n", "c<C-j>", "<cmd>cnext<CR>")
vim.keymap.set("n", "c<C-k>", "<cmd>cprev<CR>")

vim.keymap.set("n", "-", ":Oil<CR>")

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd('TermOpen', {
  group = vim.api.nvim_create_augroup('custom-term-open', { clear = true }),
  callback = function()
    vim.opt.number = false
    vim.opt.relativenumber = false
  end,
})

job_id = 0
vim.keymap.set("n", "<space>st", function()
  vim.cmd.vnew()
  vim.cmd.term()
  vim.cmd.wincmd("J")
  vim.api.nvim_win_set_height(0, 5)

  job_id = vim.bo.channel
end)

-- later on, write this as a way to push to arduino
-- vim.keymap.set("n", "<space>hello", function()
--   vim.fn.chansend(job_id, { "echo 'hi'\r\n" })
-- end)

vim.cmd.colorscheme "catppuccin-nvim"
