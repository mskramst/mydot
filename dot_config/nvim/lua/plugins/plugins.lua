return {
  'tpope/vim-fugitive',
  { "ellisonleao/gruvbox.nvim", priority = 1000 , config = true, opts = ...},
  {'folke/tokyonight.nvim'},
  { "Mofiqul/vscode.nvim", priority = 1000 },
  {'neovim/nvim-lspconfig'},
  {'hrsh7th/cmp-nvim-lsp'},
  {'hrsh7th/nvim-cmp'},
  'ray-x/go.nvim',
{
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-lua/plenary.nvim" }
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




