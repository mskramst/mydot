-- ============================================================================
-- {{ Personal Quick Actions }}
-- ============================================================================

-- Fast Escape configuration in Insert Mode
vim.keymap.set('i', 'jk', '<Esc>')

-- Configuration Reloads & File System Access Hooks
-- Force-reload the entire configuration ecosystem on the fly
vim.keymap.set('n', '<leader>so', function()
  -- 1. Clear the internal Lua cache for your custom modules
  package.loaded["user.mappings"] = nil
  package.loaded["user.colorschemes"] = nil
  package.loaded["lsp"] = nil

  -- 2. Source the main entry point file
  vim.cmd("source " .. vim.fn.expand("~/.config/nvim/init.lua"))
  print("Configuration hot-reloaded successfully!")
end, { desc = "Hot-reload all configuration modules" })

vim.keymap.set('n', '<Leader>gg', function()
  require('telescope.builtin').find_files()
end, { desc = "Fuzzy find files" })


-- Smart Git File Search with automatic fallback to standard search
vim.keymap.set('n', '<leader>gf', function()
  -- Run a silent system check to see if we are inside a git repo
  vim.fn.system('git rev-parse --is-inside-work-tree')

  if vim.v.shell_error == 0 then
    -- We are in a git repo! Run the optimized tracked file search
    require('telescope.builtin').git_files()
  else
    -- Not a git repo. Silently fall back to standard file find
    require('telescope.builtin').find_files()
  end
end, { desc = "Fuzzy find files (Git tracking with local fallback)" })

-- Open the Neovim configuration directory and trigger file search instantly
vim.keymap.set('n', '<leader>vim', function()
  -- 1. Change the current window's directory to your Neovim config root
  vim.cmd("cd ~/.config/nvim")

  -- 2. Open Telescope's fuzzy finder right away in that directory
  require('telescope.builtin').find_files()
end, { desc = "Manage Neovim configurations ecosystem" })

-- Press Escape in normal mode to clear search highlights cleanly
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR><Esc>', { silent = true })

vim.keymap.set('n', '<leader>not', '<cmd>e $STARTANEW/software/vim.md<CR>', { 
  desc = "Open Vim tracking notes" })
  vim.keymap.set('n', '<leader>abbr', '<cmd>e ~/.vim/vimabbrs.vim<CR>', { 
    desc = "Edit text abbreviations" })

    -- Navigating Home-Row Line Motions (Replaces traditional ^ and $)
    vim.keymap.set('n', 'H', '^')
    vim.keymap.set('n', 'L', '$')

    -- Buffer Controls
    vim.keymap.set('n', '<leader>bp', '<cmd>bp<CR>')
    vim.keymap.set('n', '<leader>bn', '<cmd>bn<CR>')
    vim.keymap.set('n', '<leader>bd', '<cmd>bd<CR>', { desc = "Delete active buffer" })

    -- Window/Split Consolidation
    vim.keymap.set('n', '<leader>o', '<cmd>only<CR>')
    vim.keymap.set('n', '<Leader>b', '<cmd>ls<CR>:b<Space>')

    vim.keymap.set('v', '<Leader>y', '"+y', { desc = "Send selection to outside world" })

    -- Refactoring & Global Search Replacements
    vim.keymap.set('n', '<Leader>ff', 'vipgq', { desc = "Format current text paragraph" })

    -- Smart Universal Code Formatter
    vim.keymap.set('n', '<Leader>for', function()
      -- Check if any active LSPs support formatting right now
      local has_lsp = false
      for _, client in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
        if client.server_capabilities.documentFormattingProvider then
          has_lsp = true
          break
        end
      end

      if has_lsp then
        -- Safe, modern native API call that bypasses user commands entirely
        vim.lsp.buf.format({ async = true })
        print("Formatted via LSP.")
      else
        -- If no LSP is running, fall back to native internal indentation fixes
        -- gg=G runs indentation auto-alignment across the whole file without breaking text limits
        local save_cursor = vim.fn.getpos(".")
        vim.cmd("normal! gg=G")
        vim.fn.setpos(".", save_cursor)
        print("No active LSP. Auto-aligned indentation lines instead.")
      end
    end, { desc = "Universal safe code format" })

    vim.keymap.set('n', '<leader>th', function()
      -- Get the active colorscheme name from Neovim's internal global state
      local current_theme = vim.g.colors_name
      if current_theme == "gruvbox" then
        vim.cmd([[colorscheme tokyonight-storm]])
        print("Switched to TokyoNight Storm 🌌")
      elseif current_theme == "tokyonight-storm" or current_theme == "tokyonight" then
        vim.cmd([[colorscheme vscode]])
        print("Switched to VSCode Dark Plus 💻")
      else
        vim.cmd([[colorscheme gruvbox]])
        print("Switched to Gruvbox Hard 🪵")
      end
    end, { desc = "Toggle environment colorscheme layout" })

    vim.keymap.set('n', '<leader>r', [[:%s/\<<C-r><C-w>\>//gc<Left><Left><Left>]], 
    { desc = "Search and replace current word match" })
    vim.keymap.set('n', '<F2>', '*<C-o>cgn', { desc = "High speed multiline occurrence refactoring" })
    vim.keymap.set('n', 'q:', '<nop>') -- Disables accidental command history window popups

    -- System Clipboard Integration Accessors
    vim.keymap.set('v', '<leader>y', '"+y')
    vim.keymap.set({'n', 'v'}, '<leader>p', '"+p')

    -- Modern Markdown Block Extensions
    vim.keymap.set('n', '<leader>code', 'i```<CR><CR>```<Esc>ki')

    -- ============================================================================
    -- {{ External Binary Piping Actions }}
    -- ============================================================================
    vim.keymap.set('n', '<leader>gp',  '<cmd>.!gp<CR>')
    vim.keymap.set('n', '<leader>gpm', '<cmd>.!gpmac<CR>')
    vim.keymap.set('n', '<leader>mm',  '<cmd>.!mdurl<CR>')
    vim.keymap.set('n', '<Leader>put', '<cmd>.!yyy<CR>')
    vim.keymap.set('n', '<Leader>get', '<cmd>r $TARTANEW/saved/buf<CR>')

    -- Your updated standalone shell script bindings
    vim.keymap.set('v', '<leader>s',   ':w !newgist<CR>', { silent = true })

    -- Search gists with fzf inside a perfectly centered floating terminal popup
    vim.keymap.set('n', '<leader>l', function()
      -- 1. Calculate the math for a centered popup window (60% width, 40% height)
      local width = math.floor(vim.o.columns * 0.6)
      local height = math.floor(vim.o.lines * 0.4)
      local col = math.floor((vim.o.columns - width) / 2)
      local row = math.floor((vim.o.lines - height) / 2)

      -- 2. Create a temporary, completely blank scratch buffer
      local buf = vim.api.nvim_create_buf(false, true)

      -- 3. Define the floating window layout parameters
      local win_opts = {
        relative = "editor",
        width = width,
        height = height,
        col = col,
        row = row,
        style = "minimal", -- Strips away status lines and side column clutter
        border = "rounded", -- Gives you a clean, smooth bordered frame
      }

      -- 4. Open the window and instantly link our scratch buffer to it
      local win = vim.api.nvim_open_win(buf, true, win_opts)

      -- 5. Execute your script inside the floating terminal space
      vim.fn.termopen("searchgists", {
        on_exit = function()
          -- Automatically clean up and wipe out the floating container on exit
          if vim.api.nvim_win_is_valid(win) then
            vim.api.nvim_win_close(win, true)
          end
          if vim.api.nvim_buf_is_valid(buf) then
            vim.api.nvim_buf_delete(buf, { force = true })
          end
        end
      })

      -- 6. Trigger insert mode immediately so you can type into fzf right away
      vim.cmd("startinsert")
    end, { desc = "Fuzzy search system gists in a floating window" })

    -- ============================================================================
    -- {{ Seamless Split Navigation }}
    -- ============================================================================
    vim.keymap.set('n', '<C-h>', '<C-w>h')
    vim.keymap.set('n', '<C-j>', '<C-w>j')
    vim.keymap.set('n', '<C-k>', '<C-w>k')
    vim.keymap.set('n', '<C-l>', '<C-w>l')

    -- ============================================================================
    -- {{ Git / Fugitive Orchestrations }}
    -- ============================================================================
    vim.keymap.set('n', '<leader>gs', '<cmd>G<CR>')
    vim.keymap.set('n', '<leader>gc', '<cmd>GCheckout<CR>')
    vim.keymap.set('n', '<leader>gu', '<cmd>diffget //2<CR>')
    vim.keymap.set('n', '<leader>gh', '<cmd>diffget //3<CR>')

-- ============================================================================
-- {{ Snippet & Script Management }}
-- ============================================================================
--
vim.keymap.set('n', '<leader>xx', function()
    local raw_paths = {}
    
    -- 1. Resolve your private repo path if the environment variable is live
    local env_path = vim.fn.getenv("STARTANEW")
    if env_path ~= vim.NIL and env_path ~= "" then
        table.insert(raw_paths, vim.fn.expand(env_path .. "/snippets"))
    end
    
    -- 2. Resolve your public chezmoi dotfile path forcefully
    table.insert(raw_paths, vim.fn.expand("~/.snippets"))

    -- 3. FILTER STEP: Only keep directories that actually exist on your machine
    local search_paths = {}
    for _, path in ipairs(raw_paths) do
        if vim.fn.isdirectory(path) == 1 then
            table.insert(search_paths, path)
        end
    end

    -- Safety check: If absolutely no directories exist, let the user know gently
    if #search_paths == 0 then
        print("Error: Neither your private vault nor ~/.snippets exist yet!")
        return
    end

    -- Launch Telescope parsing across only the valid target locations
    require('telescope.builtin').find_files({
        prompt_title = "Select Snippet (Public & Private Vaults)",
        search_dirs = search_paths, 
        path_display = { "tail" },
        hidden = true, -- Force Telescope to see hidden files if any exist
        attach_mappings = function(_, map)
            map('i', '<CR>', function(prompt_bufnr)
                local selection = require('telescope.actions.state').get_selected_entry()
                require('telescope.actions').close(prompt_bufnr)
                if selection then
                    -- Insert the snippet content directly below the cursor
                    vim.cmd("read " .. vim.fn.fnameescape(selection.path))
                end
            end)
            return true
        end,
    })
end, { desc = "Fuzzy find and insert code snippet from aggregated vaults" })

-- 2. Instantly browse and edit any custom shell scripts
vim.keymap.set('n', '<leader>sc', function()
    local scripts_path = vim.fn.getenv("STARTANEW") .. "/scripts"
    
    -- Scope Telescope strictly to your scripts folder
    require('telescope.builtin').find_files({
        prompt_title = "System Management Scripts",
        cwd = scripts_path,
    })
end, { desc = "Fuzzy find and edit automation scripts" })

