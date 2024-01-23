-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.keymap.set

-- FloaTerm configuration
map("n", "<leader>ft", ":FloatermNew --name=myfloat --height=0.8 --width=0.7 --autoclose=2<CR> ")
map("n", "<leader>tt", ":FloatermToggle myfloat<CR>")
map("t", "<Esc>", "<C-\\><C-n>:q<CR>")
