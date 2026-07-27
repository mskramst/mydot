return {
  -- Mason manages external tools installed through :Mason.
  {
    "williamboman/mason.nvim",
    opts = {},
  },

  -- Intelephense provides PHP completion and symbol navigation.
  {
    "neovim/nvim-lspconfig",
    config = function()
      vim.lsp.config("intelephense", {
        settings = {
          intelephense = {
            diagnostics = {
              enable = false,
            },
            environment = {
              phpVersion = "8.3.0",
            },
            format = {
              enable = true,
              braces = "per",
            },
            stubs = {
              "bcmath", "bz2", "calendar", "Core", "curl", "date",
              "dom", "fileinfo", "filter", "gd", "gettext", "hash",
              "iconv", "imap", "json", "libxml", "mbstring", "mcrypt",
              "mysql", "mysqli", "password", "pcntl", "pcre", "PDO",
              "pdo_mysql", "Phar", "readline", "regex", "session",
              "SimpleXML", "sockets", "sodium", "standard", "superglobals",
              "tokenizer", "xml", "xdebug", "xmlreader", "xmlwriter",
              "yaml", "zip", "zlib", "wordpress",
            },
            files = { maxSize = 5000000 },
          },
        },
      })
      vim.lsp.enable("intelephense")

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "php",
        callback = function(event)
          vim.bo[event.buf].expandtab = true
          vim.bo[event.buf].shiftwidth = 4
          vim.bo[event.buf].softtabstop = 4
          vim.bo[event.buf].tabstop = 4

          vim.api.nvim_buf_create_user_command(
            event.buf,
            "PhpFormat",
            function()
              vim.lsp.buf.format({
                async = false,
                bufnr = event.buf,
                name = "intelephense",
              })
            end,
            { desc = "Format PHP with Intelephense" }
          )

          vim.keymap.set("n", "<leader>pf", "<cmd>PhpFormat<cr>", {
            buffer = event.buf,
            desc = "Format PHP buffer",
            silent = true,
          })
        end,
      })
    end,
  },

  -- PHP checks syntax; PHPCS reports PSR-12 style problems.
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "rshkarin/mason-nvim-lint",
    },
    config = function()
      local lint = require("lint")

      lint.linters_by_ft = {
        php = { "php", "phpcs" },
      }

      require("mason-nvim-lint").setup({
        ensure_installed = { "phpcs" },
        automatic_installation = false,
      })

      local lint_augroup =
        vim.api.nvim_create_augroup("lint", { clear = true })

      vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost" }, {
        group = lint_augroup,
        callback = function()
          lint.try_lint()
        end,
      })
    end,
  },
}
