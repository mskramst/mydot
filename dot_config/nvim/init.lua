-- ============================================================================
-- Neovim Global Options Core Configuration
-- ============================================================================

vim.g.mapleader = " "

-- --- UI Options ---
vim.opt.number = true
vim.opt.relativenumber = false     -- Toggle to true if you prefer relative tracking
vim.opt.cursorline = true
vim.opt.signcolumn = "yes"
vim.opt.colorcolumn = "80"
vim.opt.ruler = true
vim.opt.termguicolors = true

-- --- Clipboards & Mouse ---
vim.opt.mouse = "a"
vim.opt.clipboard = "unnamedplus"

-- --- Structural Indentation Defaults ---
vim.opt.textwidth = 80
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.autoindent = true

-- --- Safety & Backups ---
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false

-- --- Persistent Undo Memory Storage ---
vim.opt.undofile = true
vim.opt.undodir = vim.fn.expand("~/.vim/undodir")
vim.opt.history = 10000
vim.opt.viminfo = "'20,<1000,s1000"

-- --- Search & Matching Behavior ---
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.wrapscan = true
vim.opt.showmatch = true
vim.opt.belloff = "all"

-- --- Format Options Layout ---
-- t: wrap text, c: wrap comments, r: continue comments, q: format with gq, n: lists
vim.opt.formatoptions:append("tcrqn")

-- ============================================================================
-- {{ Module Integration Core Routes }}
-- ============================================================================
require("config.lazy")         -- Loads package layouts
require("user.colorschemes")   -- Pulls colorschemes
require("user.mappings")       -- Bootstraps personal action shortcuts
require("lsp")                 -- Modern 0.11+ Native Language Processing Core

-- ============================================================================
-- {{ Legacy Script Bridges & File Handling Hooks }}
-- ============================================================================

-- Safely pull in your old abbreviation and text expansion script files
local source_if_readable = function(path)
    local expanded = vim.fn.expand(path)
    if vim.fn.filereadable(expanded) == 1 then
        vim.cmd("source " .. expanded)
    end
end
source_if_readable("~/.vim/vimabbrs.vim")
source_if_readable("~/.vim/vim-functions.vim")

-- Centralized Autocommand Event Handlers
local augroup = vim.api.nvim_create_augroup("UserConfigGroup", { clear = true })

-- Dynamic Skeleton File Injections for New Files
vim.api.nvim_create_autocmd("BufNewFile", {
    group = augroup,
    pattern = "*.java",
    command = "0r $STARTANEW/snippets/skele/Main.java"
})
vim.api.nvim_create_autocmd("BufNewFile", {
    group = augroup,
    pattern = "main.py",
    command = "0r $STARTANEW/snippets/skele/main.py"
})

-- Markdown Wrapping Enforcement
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    group = augroup,
    pattern = "*.md",
    callback = function()
        vim.opt_local.textwidth = 80
    end
})

-- YAML and JSON Language Parameters
vim.api.nvim_create_autocmd("FileType", {
    group = augroup,
    pattern = "yaml",
    callback = function()
        vim.opt_local.tabstop = 2
        vim.opt_local.softtabstop = 2
        vim.opt_local.shiftwidth = 2
        vim.opt_local.expandtab = true
    end
})

-- Interactive Shell Caps-Lock Clear Hook
vim.api.nvim_create_autocmd("InsertLeave", {
    group = augroup,
    pattern = "*",
    command = "call TurnOffCaps()"
})
