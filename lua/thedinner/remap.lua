vim.g.mapleader = " "
vim.keymap.set("n", "<leader>fv", vim.cmd.Ex)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- fighting one eyed kirby
vim.keymap.set("v", "<leader>fe", ":s/\\(.*\\)/thing")

-- greatest remap ever
vim.keymap.set("x", "<leader>P", [["_dP]])

-- pastr from system clipboard
vim.keymap.set("n", "<leader>p", [["+p]])
vim.keymap.set("x", "<leader>p", [["+p]])

vim.keymap.set("n", "<leader>P", [["+P]])
vim.keymap.set("x", "<leader>P", [["+P]])

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

vim.keymap.set("n", "Q", "<nop>")
-- vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("n", "<leader>fp", vim.lsp.buf.format)

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })
-- run makefile (will brake if not in a cpp project)
vim.keymap.set("n", "<leader>m", "<cmd>!make CXX='ccache g++'<CR>")

vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("so")
end)

-- auto close {}, [], and (), and <>?
-- vim.keymap.set("i", "{", "{}<esc>i")
-- vim.keymap.set("i", "[", "[]<esc>i")
-- vim.keymap.set("i", "(", "()<esc>i")
-- vim.keymap.set("i", "<", "<><esc>i")
