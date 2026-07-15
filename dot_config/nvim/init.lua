-- Environment Path Insurance Block (Fixes 'go is not executable')
-- ---------------------------------------------------------------------------
local home = os.getenv("HOME")
local paths = {
  home .. "/go/bin",
  home .. "/.local/bin",
  "/usr/local/go/bin",
  "/usr/local/bin",
  "/usr/bin",
  "/bin"
}

-- Combine our custom paths with a colon delimiter
local custom_path_string = table.concat(paths, ":")

-- Combine them cleanly with the existing system PATH without an extra trailing colon
if vim.env.PATH and vim.env.PATH ~= "" then
    vim.env.PATH = custom_path_string .. ":" .. vim.env.PATH
else
    vim.env.PATH = custom_path_string
end

-- Set own undodir for Neovim
vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath("state") .. "/undo"
vim.fn.mkdir(vim.fn.stdpath("state") .. "/undo", "p")

-- ============================================================================
-- Neovim Global Options Core Configuration
-- ============================================================================

vim.g.mapleader = " "

-- --- UI Options ---
vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.cursorline = false
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
require("user.mappings")       -- Bootstraps personal action shortcuts
require("lsp")                 -- Modern 0.11+ Native Language Processing Core
require("user.abbreviations")

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

vim.opt.runtimepath:append("/home/mskramst/repos/github.com/mskramst/codewrite")


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
vim.api.nvim_create_autocmd("BufNewFile", {
    group = augroup,
    pattern = "main.go",
    command = "0r $STARTANEW/snippets/skele/main.go"
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

-- Automatically force Caps Lock OFF using system X11 utilities
local function turn_off_caps()
    -- 1. Query xset for the current keyboard state
    local xset_output = vim.fn.system("xset -q")
    
    -- 2. Use a clean Lua pattern match to grab the Caps Lock state
    -- This mimics your exact Vimscript matchstr filter
    local caps_state = string.match(xset_output, "Caps Lock:%s+([a-z]+)")

    -- 3. If Caps Lock is currently active, tap it via xdotool to kill it
    if caps_state == "on" then
        vim.fn.system("xdotool key Caps_Lock")
    end
end

-- Create an automated hook to strip Caps Lock every time you leave Insert Mode
vim.api.nvim_create_autocmd("InsertLeave", {
    group = vim.api.nvim_create_augroup("ClearCapsLockGroup", { clear = true }),
    callback = function()
        turn_off_caps()
    end,
    desc = "Automatically turn off Caps Lock on InsertLeave",
})

require("user.colorschemes")
