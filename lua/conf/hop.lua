

--https://github.com/phaazon/hop.nvim

require("hop").setup()

--搜索并跳转到单词
vim.keybinds.gmap("n","<leader>hw","<cmd>HopWord<CR>",vim.keybinds.opts)
--搜索并跳转到行
vim.keybinds.gmap("n","<leader>hl","<cmd>HopLine<CR>",vim.keybinds.opts)
--搜索并跳转到字符
vim.keybinds.gmap("n","<leader>hc","<cmd>HopCharl<CR>",vim.keybinds.opts)