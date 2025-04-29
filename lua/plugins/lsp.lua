require("mason").setup({
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗"
    }
  }
})

require("mason-lspconfig").setup({
  -- 确保安装，根据需要填写
  ensure_installed = {
    "clangd",
  },
})

local capabilities = require('cmp_nvim_lsp').default_capabilities()

require("lspconfig").clangd.setup({
  on_attach = function(client, bufnr)
    -- 启用诊断信息
    vim.diagnostic.config()

    -- 设置快捷键
    local bufopts = { noremap=true, silent=true, buffer=bufnr }
    vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', bufopts)
    vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', bufopts)
    vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', bufopts)
    vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', bufopts)
    vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', bufopts)
    -- 更多快捷键配置
  end,
  capabilities = capabilities,
  cmd = { "clangd" },
  filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
  root_dir = require("lspconfig").util.root_pattern(
      ".clangd",
      ".clang-tidy",
      ".clang-format",
      "compile_commands.json",
      "compile_flags.txt",
      "configure.ac",
      ".git"
  ),
})
