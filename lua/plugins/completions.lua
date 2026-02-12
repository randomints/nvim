return {
  {
    "saghen/blink.cmp",
    opts = {
      -- keep LazyVim defaults so completion actually triggers
      keymap = {
        preset = "default",

        ["<Tab>"] = {
          function(cmp)
            if cmp.is_visible() then
              cmp.select_next()
              return true
            elseif cmp.snippet_active() then
              cmp.snippet_jump_forward()
              return true
            end
          end,
          "fallback",
        },

        ["<S-Tab>"] = {
          function(cmp)
            if cmp.is_visible() then
              cmp.select_prev()
              return true
            elseif cmp.snippet_active() then
              cmp.snippet_jump_backward()
              return true
            end
          end,
          "fallback",
        },

        ["<C-b>"] = { "scroll_documentation_up" },
        ["<C-f>"] = { "scroll_documentation_down" },
        ["<C-Space>"] = { "show" },
        ["<C-e>"] = { "hide" },
        ["<CR>"] = { "accept", "fallback" },
      },

      -- make sure completion sources exist
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
      },
    },
  },
}
