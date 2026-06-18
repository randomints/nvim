return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "folke/lazydev.nvim",
      opts = {
        library = {
          { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        },
      },
    },
    config = function()
      local capabilities = require('blink.cmp').get_lsp_capabilities()
      vim.lsp.config("lua_ls", { capabilities = capabilities })
      vim.lsp.enable("lua_ls")

      vim.lsp.config("ts_ls", { capabilities = capabilities })
      vim.lsp.enable("ts_ls")

      vim.lsp.config("cssls", { capabilities = capabilities })
      vim.lsp.enable("cssls")

      vim.lsp.config("html", { capabilities = capabilities })
      vim.lsp.enable("html")

      vim.lsp.config("arduino_language_server", {
        capabilities = capabilities,
        cmd = {
          "arduino-language-server",
          "-cli-config", vim.fn.expand("~/.arduino15/arduino-cli.yaml"),
          "-cli", "arduino-cli",
          "-clangd", "clangd",
        },
        filetypes = { "arduino", "ino" },
      })
      vim.lsp.enable("arduino_language_server")

      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('my.lsp', {}),
        callback = function(ev)
          local client = vim.lsp.get_client_by_id(ev.data.client_id)
          if not client then return end

          -- Auto-format ("lint") on save.
          -- Usually not needed if server supports "textDocument/willSaveWaitUntil".
          ---@diagnostic disable-next-line: missing-parameter
          if not client:supports_method('textDocument/willSaveWaitUntil')
              and client:supports_method('textDocument/formatting', 0) then
            vim.api.nvim_create_autocmd('BufWritePre', {
              group = vim.api.nvim_create_augroup('my.lsp', { clear = false }),
              buffer = ev.buf,
              callback = function()
                vim.lsp.buf.format({ bufnr = ev.buf, id = client.id, timeout_ms = 1000 })
              end,
            })
          end
        end,
      })
    end,
  },
}
