-- 1. Modern Native Keymapper Abstraction
local buf_map = function(bufnr, mode, lhs, rhs, opts)
    vim.keymap.set(mode, lhs, rhs, vim.tbl_extend("force", { buffer = bufnr, silent = true }, opts or {}))
end

-- 2. Modern Centralized On-Attach Handler
local on_attach = function(client, bufnr)
    -- Define user commands using the clean native Vim API
    vim.api.nvim_buf_create_user_command(bufnr, "LspDef", function() vim.lsp.buf.definition() end, {})
    vim.api.nvim_buf_create_user_command(bufnr, "LspFormatting", function() vim.lsp.buf.format({ async = true }) end, {})
    vim.api.nvim_buf_create_user_command(bufnr, "LspCodeAction", function() vim.lsp.buf.code_action() end, {})
    vim.api.nvim_buf_create_user_command(bufnr, "LspHover", function() vim.lsp.buf.hover() end, {})
    vim.api.nvim_buf_create_user_command(bufnr, "LspRename", function() vim.lsp.buf.rename() end, {})
    vim.api.nvim_buf_create_user_command(bufnr, "LspRefs", function() vim.lsp.buf.references() end, {})
    vim.api.nvim_buf_create_user_command(bufnr, "LspTypeDef", function() vim.lsp.buf.type_definition() end, {})
    vim.api.nvim_buf_create_user_command(bufnr, "LspImplementation", function() vim.lsp.buf.implementation() end, {})
    vim.api.nvim_buf_create_user_command(bufnr, "LspDiagPrev", function() vim.diagnostic.goto_prev() end, {})
    vim.api.nvim_buf_create_user_command(bufnr, "LspDiagNext", function() vim.diagnostic.goto_next() end, {})
    vim.api.nvim_buf_create_user_command(bufnr, "LspDiagLine", function() vim.diagnostic.open_float() end, {})
    vim.api.nvim_buf_create_user_command(bufnr, "LspSignatureHelp", function() vim.lsp.buf.signature_help() end, {})

    -- Keybindings mapping directly using native vim.keymap.set
    buf_map(bufnr, "n", "gd", vim.lsp.buf.definition)
    buf_map(bufnr, "n", "gr", vim.lsp.buf.rename)
    buf_map(bufnr, "n", "gy", vim.lsp.buf.type_definition)
    buf_map(bufnr, "n", "K",  vim.lsp.buf.hover)
    buf_map(bufnr, "n", "[a", vim.diagnostic.goto_prev)
    buf_map(bufnr, "n", "]a", vim.diagnostic.goto_next)
    buf_map(bufnr, "n", "ga", vim.lsp.buf.code_action)
    buf_map(bufnr, "n", "<Leader>a", vim.diagnostic.open_float)
    buf_map(bufnr, "i", "<C-x><C-x>", vim.lsp.buf.signature_help)
end

-- 3. Set up capabilities from your nvim-cmp autocomplete engine
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- 4. Set up global default configuration parameters across ALL clients
-- Instead of writing duplicate boilerplate configuration loops, we inject this universally
vim.lsp.config('*', {
    capabilities = capabilities,
    on_attach = on_attach,
})

-- 5. Native Server Registration & Initialization
-- ----------------------------------------------------------------------------

-- TypeScript Setup (ts_ls)
vim.lsp.config('ts_ls', {
    on_attach = function(client, bufnr)
        -- Disable standard LSP formatting so null-ls / prettier handles it exclusively
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
        
        -- Custom inline mappings originally handled by ts-utils
        buf_map(bufnr, "n", "gs", "<cmd>LspCodeAction<CR>") -- Uses native code actions for organization now
        on_attach(client, bufnr)
    end,
    init_options = {
        preferences = {
            disableSuggestions = true,
        },
    },
})
vim.lsp.enable('ts_ls')

-- Python (Pyright)
vim.lsp.enable('pyright')

-- Kotlin Language Server
vim.lsp.enable('kotlin_language_server')

-- ----------------------------------------------------------------------------
-- 6. External Engine Tools (Non-Native Ecosystem Hooks)
-- ----------------------------------------------------------------------------

-- Go Environment (Handled smoothly via ray-x/go.nvim plugin integration)
require('go').setup({
    lsp_on_attach = on_attach,
    lsp_cfg = {
        capabilities = capabilities,
    }
})
