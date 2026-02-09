local lsp = require('lsp-zero').preset({
  name = 'minimal',
  set_lsp_keymaps = true,
  manage_nvim_cmp = false,
  suggest_lsp_servers = false,
})
local cmp = require("cmp")
local luasnip = require('luasnip')
local cmp_action = require('lsp-zero').cmp_action()
cmp.setup({
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Insert,
            select = true,
        }),
        ['<C-f>'] = cmp_action.luasnip_jump_forward(),
        ['<C-b>'] = cmp_action.luasnip_jump_backward(),
        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        ['<C-d>'] = cmp.mapping.scroll_docs(4),
    ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
            cmp.select_next_item()
        elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
        else
            fallback()
        end
    end, {"i", "s"}),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
            cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
        else
            fallback()
        end
    end, {"i", "s"}),
    }),
    snippet = {
        expand = function(args)
        luasnip.lsp_expand(args.body)
        end,
    },
    sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'buffer' },
        { name = 'path' },
    },
})
lsp.on_attach(function(client, bufnr)
  local opts = {buffer = bufnr, remap = false}
  vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
  vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
  vim.keymap.set("n", "<leader>ls", function() vim.lsp.buf.workspace_symbol() end, opts)
  vim.keymap.set("n", "<leader>ld", function() vim.diagnostic.open_float() end, opts)
  vim.keymap.set("n", "<leader>la", function() vim.lsp.buf.code_action() end, opts)
  vim.keymap.set("n", "<leader>gr", function() vim.lsp.buf.references() end, opts)
  vim.keymap.set("n", "<leader>lr", function() vim.lsp.buf.rename() end, opts)
  vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)

local lua_opts = lsp.nvim_lua_ls()
require('lspconfig').lua_ls.setup(lua_opts)

local capabilities = require("cmp_nvim_lsp").default_capabilities()

lsp.configure("clangd", {
  cmd = { 
    "clangd", 
    "--background-index", 
    "--clang-tidy", 
    "--compile-commands-dir=build",
    "--query-driver=/usr/bin/g++,/usr/bin/gcc,/usr/bin/c++"
  },
  filetypes = { "c", "cpp", "objc", "objcpp" },
  root_dir = require("lspconfig.util").root_pattern(
    "compile_commands.json",
    ".git"
  ),
  capabilities = capabilities,
  init_options = {
    clangdFileStatus = true,
    usePlaceholders = true,
    completeUnimported = true,
  },
})

lsp.configure("ocamllsp", {
  cmd = { "ocamllsp" },
})

lsp.configure("rust_analyzer", {
  cmd = { "rust-analyzer" },
  filetypes = { "rust" },
  root_dir = require("lspconfig.util").root_pattern(
    "Cargo.toml",
    "rust-project.json",
    ".git"
  ),
  settings = {
    ["rust-analyzer"] = {
      cargo = {
        allFeatures = true,
      },
      checkOnSave = true,
    },
  },
})

lsp.configure("svls", {
  cmd = { "svls" },
  filetypes = { "verilog", "systemverilog" },
  root_dir = require("lspconfig.util").root_pattern(
    "svls.toml",
    ".git"
  ),
  capabilities = capabilities,
})

lsp.setup()
vim.diagnostic.config({
    virtual_text = true
})
