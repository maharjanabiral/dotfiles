vim.g.mapleader = " "

local keymap = vim.keymap
local opts = { noremap = true, silent = true }

keymap.set("n", "<C-u>", "<C-u>zz")
keymap.set("n", "<C-d>", "<C-d>zz")
keymap.set("i", "jk", "<Esc>")
keymap.set('n', 'x', '"_x', opts)


keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })

keymap.set("n", "<C-Up>", ":resize +2<CR>", { desc = "Increase height" })
keymap.set("n", "<C-Down>", ":resize -2<CR>", { desc = "Decrease height" })
keymap.set("n", "<C-Left>", ":vertical resize -4<CR>", { desc = "Narrower" })
keymap.set("n", "<C-Right>", ":vertical resize +4<CR>", { desc = "Wider" })

keymap.set("n", "<Tab>", "<cmd>BufferLineCycleNext<CR>", { desc = "Go to next buffer" })
keymap.set("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<CR>", { desc = "Go to previous buffer" })
keymap.set("n", "<leader>x", "<cmd>bdelete<CR>", { desc = "Close current buffer" })
keymap.set("n", "<leader>b", "<cmd>tabnew<CR>", { desc = "New tab" })
keymap.set("n", "<leader>bo", function()
  local current = vim.api.nvim_get_current_buf()
  local bufdelete = require("bufdelete")

  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if buf ~= current and vim.bo[buf].buflisted then
      bufdelete.bufdelete(buf, true)
    end
  end
end, { desc = "Force Delete Other Buffers" })

keymap.set('n', '<leader>lw', '<cmd>set wrap!<CR>', opts)
keymap.set('n', '<C-k>', ':wincmd k<CR>', opts)
keymap.set('n', '<C-j>', ':wincmd j<CR>', opts)
keymap.set('n', '<C-h>', ':wincmd h<CR>', opts)
keymap.set('n', '<C-l>', ':wincmd l<CR>', opts)

keymap.set('v', '<', '<gv', opts)
keymap.set('v', '>', '>gv', opts)

keymap.set('v', 'p', '"_dP', opts)

keymap.set('n', 'vA', 'gg0vG$', { desc = 'Select all text exactly' })
keymap.set('n', 'vay', function()
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local content = table.concat(lines, '\n')
  vim.fn.setreg('+', content)
end, { desc = 'Copy entire file to clipboard cleanly' })


keymap.set("n", "<leader>ts", "<cmd>Theme<CR>", { desc = "Select theme" })
keymap.set("n", "<leader>tn", "<cmd>ThemeNext<CR>", { desc = "Next theme" })
keymap.set("n", "<leader>tp", "<cmd>ThemePrev<CR>", { desc = "Previous theme" })

