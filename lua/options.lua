-- general editor settings
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wrap = false

-- prefer new windows split on right and below
vim.opt.splitbelow = true
vim.opt.splitright = true

-- tab settings
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2

-- sync nvim clipboard with system clipboard
vim.opt.clipboard = "unnamedplus"

-- keep the cursor in the middle of the screen when scrolling
--vim.opt.scrolloff = 999
-- I've disabled this because you can just press `zz`

-- misc
vim.opt.virtualedit = "block"

vim.opt.inccommand = "split"

vim.opt.ignorecase = true

vim.opt.termguicolors = true

vim.g.mapleader = " "

-- disable netrw because I'm using nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- shortcuts to run lua code
vim.keymap.set("n", "<leader>x", "<cmd>source %<CR>", {desc="Source current lua file"})
--vim.keymap.set("n", "<space>x", ":.lua<CR>")
--vim.keymap.set("v", "<space>x", ":lua<CR>")

-- stop highlighting after search is done shortcut
vim.keymap.set("n", "<leader>/", "<cmd>noh<CR>", {desc="Clear highlighting after search"})

-- insert the result of a command
function ExecIt()
  local name = vim.fn.input("Exec: ")
  vim.cmd("r!"..name)
end

function GetDateHeader()
  --vim.cmd("r!echo \"## $(date -I) $(date +%A)\"")
  vim.cmd([[r!echo "\#\# $(date -I) $(date +\%A)"]])
end

vim.api.nvim_create_user_command('DateHeader', GetDateHeader, {})

vim.keymap.set("n", "<leader>r", ExecIt, {desc="Input output from terminal program"})

vim.keymap.set("n", "<leader>t", GetDateHeader);

vim.keymap.set("n", "<leader>o", "<C-]>", {desc="Go to definition"})

vim.keymap.set("n", "<leader>e", "<cmd>Telescope oldfiles<CR>", {desc="Telescope old files"})

vim.keymap.set("n", "<leader>c", "<cmd>cd %:h<CR>", {desc="cd to current file's directory"})

-- swap : and ;
vim.keymap.set("n", ";", ":", {desc=""})
vim.keymap.set("n", ":", ";", {desc=""})

