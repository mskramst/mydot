-- ============================================================================
-- {{ Colorscheme Global Options }}
-- ============================================================================
vim.o.background = "dark"

local status_ok, gruvbox = pcall(require, "gruvbox")
if status_ok then
  gruvbox.setup({
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
    
    -- 1. FIX: Intercept the color palette before the engine assigns it to strings
    palette_overrides = {
      bright_yellow = "#b8bb26", -- Changes the raw string color token to Gruvbox Green
      neutral_yellow = "#98971a", -- Mutes the fallback fallback token to standard moss green
    },
    
    -- 2. Keep your background overrides intact here safely
    overrides = {
      Normal = { bg = "#000000" },
      WinSeparator = { fg = "#282828", bg = "#000000" },
      SignColumn = { bg = "#000000" },
    },
    dim_inactive = false,
    transparent_mode = false,
  })
end

-- 3. Launch the theme last
vim.cmd([[colorscheme gruvbox]])
