

--https://github.com/akinsho/toggleterm.nvim


local Toggleterm = require("toggleterm")


Toggleterm.setup(
    {
      --开启终端进入插入模式
      start_in_insert = true,
      --设置终端打开的大小
      size = 6,
      --打开普通终端时关掉拼写检查
      on_open =function()
          vim.cmd("setlocal nospell")
      end
    }

)


--新建终端
local Terminal = require("toggleterm.terminal").Terminal

local function inInsert()
      --删除Esc的映射
     vim.keybinds.dgmap("t","<Esc>")
end


--新建浮动终端
local floatTerm =
    Terminal:new(
        {
          hidden = true,
          direction = "float",
          float_opts = {
              border = "double"
        },

      on_open = function(term)
          inInsert()
          --浮动终端中Esc是退出
          vim.keybinds.bmap(term.bufnr,"t","<Esc>","<C-\\><C-n>:close<CR>",vim.keybinds.opts)

      end,
      on_close = function()
          --重新映射Esc
          vim.keybinds.gmap("t","<Esc>","<C-\\><C-n>",vim.keybinds.opts)
      end
        }
      )


--新建lazygit终端
 local lazyGit =
      Terminal:new(
      {
         cmd = "lazygit",
         hidden = true,
         direction = "float",
         float_opts = {
            border = "double"
            },
         on_open = function(term)
              inInsert()
                 --lazygit中q是退出
              vim.keybinds.bmap(term.bufnr,"i","q", "<cmd>close<CR>", vim.keybinds.opts)
         end,
         on_close = function()
                --重新映射Esc
                vim.keybinds.gmap("t","<Esc>","<c-\\><C-n>", vim.keybinds.opts)
         end
        }
  )
   --定义新方法
  Toggleterm.float_toggle = function()
      floatTerm:toggle()
   end


  Toggleterm.lazygit_toggle = function()
       lazyGit:toggle()
   end
   --退出终端插入模式
   vim.keybinds.gmap("t","<Esc>", "<C-\\><C-n>", vim.keybinds.opts)
   --打开普通终端
   vim.keybinds.gmap("n", "<leader>tt", "<cmd>exe v:count.'ToggleTerm'<CR>",vim.keybinds.opts)
   --打开浮动终端
   vim.keybinds.gmap("n","<leader>tf", "<cmd>lua require('toggleterm').float_toggle()<CR>", vim.keybinds.opts)
   --打开lazygit
   vim.keybinds.gmap("n","<leader>tg", "<cmd>lua require('toggleterm').lazygit_toggle()<CR>", vim.keybinds.opts)
   --打开或关闭所有终端
   vim.keybinds.gmap("n","<leader>ta","<cmd>ToggleTermToggleAll<CR>", vim.keybinds.opts)


   --要需创建多个终端，可
   --1<键位> leader tt
   --2<键位>
   --...<键位>
   --另外，上面我们新建了2个特殊终端，所以普通终端的顺序应该是从3开始