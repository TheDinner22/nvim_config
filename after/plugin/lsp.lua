local lsp = require('lsp-zero').preset({
  name = 'minimal',
  set_lsp_keymaps = true,
  manage_nvim_cmp = true,
  suggest_lsp_servers = false,
})

local cmp = require("cmp")
local cmp_action = require('lsp-zero').cmp_action()

cmp.setup({
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-f>'] = cmp_action.luasnip_jump_forward(),
        ['<C-b>'] = cmp_action.luasnip_jump_backward(),
        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        ['<C-d>'] = cmp.mapping.scroll_docs(4),
    }),
    snippet = {
        expand = function(args)
        require('luasnip').lsp_expand(args.body)
        end,
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

-- (Optional) Configure lua language server for neovim
lsp.nvim_workspace()

-- lsp.configure("clangd", {
  -- cmd = { 
    -- "clangd", 
    -- "--background-index", 
    -- "--clang-tidy", 
    -- "--compile-commands-dir=build", -- Add this line
    -- "--query-driver=/usr/bin/g++,/usr/bin/gcc,/usr/bin/c++"
  -- },
  -- filetypes = { "c", "cpp", "objc", "objcpp", "hpp" },
  -- root_dir = require("lspconfig.util").root_pattern(
    -- "compile_commands.json", -- Add this to look for compile_commands.json
    -- ".git"
  -- ),
  -- capabilities = require("cmp_nvim_lsp").default_capabilities(),
  -- init_options = {
    -- clangdFileStatus = true,
    -- usePlaceholders = true,
    -- completeUnimported = true,
  -- },
-- })

-- after your current lsp setup/config for clangd, but before final lsp.setup()
-- require('lspconfig').ocamllsp.setup({
  -- cmd = { "ocamllsp" },
  -- filetypes = {
    -- "ocaml",
    -- "ocaml.interface",
    -- "ocaml.menhir",
    -- "ocaml.ocamllex",
    -- "reason",
    -- "dune",
  -- },
  -- root_dir = require("lspconfig.util").root_pattern(
    -- "dune-project", "dune-workspace", "*.opam", "esy.json", "package.json", ".git"
  -- ),
  -- settings = {},  -- you can optionally add ocamllsp-specific settings here
  -- on_attach = function(client, bufnr)
    -- -- reuse your existing keymaps (or call your shared on_attach)
    -- local opts = { buffer = bufnr, remap = false }
    -- vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    -- vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    -- vim.keymap.set("n", "<leader>ls", vim.lsp.buf.workspace_symbol, opts)
    -- vim.keymap.set("n", "<leader>ld", vim.diagnostic.open_float, opts)
    -- vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, opts)
    -- vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, opts)
    -- vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, opts)
    -- vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
  -- end,
-- })

lsp.configure("ocamllsp", {
  cmd = { "ocamllsp" },
})

lsp.configure("rust_analyzer", {
  cmd = { "rust-analyzer" }, -- MUST be the Nix one in PATH
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

lsp.setup()

vim.diagnostic.config({
    virtual_text = true
})

