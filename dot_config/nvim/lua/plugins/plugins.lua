return {
  'tpope/vim-fugitive',
  {'folke/tokyonight.nvim'},
  { "Mofiqul/vscode.nvim", priority = 1000 },
	{
    'ellisonleao/gruvbox.nvim',
    priority = 1000, -- Load this early if you want it as your primary theme
    config = function()
      -- This setup function replaces your need to configure it elsewhere
      require("gruvbox").setup({
        contrast = "hard", -- Options: "soft", "medium", "hard"
        inverse = true,    -- Keeps visual selections and search highlights crisp
      })
    end
  },
  {'neovim/nvim-lspconfig'},
  {'hrsh7th/cmp-nvim-lsp'},
  {'hrsh7th/nvim-cmp'},
  'ray-x/go.nvim',
{
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-lua/plenary.nvim" }
},
  {
    dir = "/home/mskramst/repos/github.com/mskramst/codewrite",
    lazy = false,
    priority = 1000,
  },
{
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  -- Using 'opts' tells Lazy to pass these configurations to the setup function safely
  opts = {
    ensure_installed = { "go", "javascript", "typescript", "python", "java", "lua", "vim", "vimdoc" },
    sync_install = false,
    highlight = { 
      enable = true, 
      additional_vim_regex_highlighting = false,
    },
  },
  -- This config function runs safely ONLY after the code is fully cloned to disk
  config = function(_, opts)
    require("nvim-treesitter").setup(opts)
  end,
},
}




