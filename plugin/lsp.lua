-- Add file type detection for .tw and .tw.html
vim.filetype.add({
    extension = {
        tw = "textwire",
        ["tw.html"] = "textwire",
    },
})

local lsp = require("lspconfig")

-- Store the client ID to manage the server instance
local textwire_client = nil

-- LSP setup
lsp.textwire.setup({
    cmd = { "/Users/serhiichornenkyi/www/open/textwire/lsp/main" },
    on_attach = function(client)
        textwire_client = client.id
    end,
})

-- Create autocmd to stop the server when Neovim exits
vim.api.nvim_create_autocmd("VimLeavePre", {
    callback = function()
        if textwire_client then
            local client = vim.lsp.get_client_by_id(textwire_client)
            if client then
                client.stop()
            end
        end
    end,
})
