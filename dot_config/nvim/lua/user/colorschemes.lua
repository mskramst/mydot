-- ============================================================================
-- {{ Colorscheme Global Options }}
-- ============================================================================
vim.o.background = "dark" -- Sets the background anchor palette

require("gruvbox").setup({
  terminal_colors = true, 
  undercurl = true,
  underline = true,
  bold = true,
  italic = {
    strings = true,
    emphasis = true,
    comments = true,
    operators = false,
    folds = true,
  },
  strikethrough = true,
  invert_selection = false,
  invert_signs = false,
  invert_tabline = false,
  invert_intend_guides = false,
  inverse = true, 
  contrast = "hard",
  palette_overrides = {},
  overrides = {
    -- Force the main workspace background to pure black
    Normal = { bg = "#000000" },
    -- Force vertical split border bars to match the darkness
    WinSeparator = { fg = "#282828", bg = "#000000" },
    -- Force the line number column to match the background
    SignColumn = { bg = "#000000" },
  },
  --overrides = {},
  dim_inactive = false,
  transparent_mode = false,
})

vim.cmd([[colorscheme gruvbox]])
