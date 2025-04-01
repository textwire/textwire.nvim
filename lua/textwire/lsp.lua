local M = {}

M.load_lsp = function()
    local lsp = require("lspconfig")

    -- Register the Textwire LSP server
    lsp.configs.textwire = {
        default_config = {
            cmd = { "/Users/serhiichornenkyi/www/open/textwire/lsp/main" },
            filetypes = { "textwire" },
            root_dir = function(fname)
                return require("lspconfig.util").root_pattern("package.json", ".git")(fname) or vim.fn.getcwd()
            end,
        },
    }

    -- Store the client ID to manage the server instance
    -- local textwire_client = nil

    -- -- LSP setup
    -- lsp.textwire.setup({
    --     on_attach = function(client)
    --         textwire_client = client.id
    --     end,
    --     -- Prevent the server from starting automatically
    --     autostart = false,
    -- })

    -- -- Create autocmd to stop the server when Neovim exits
    -- vim.api.nvim_create_autocmd("VimLeavePre", {
    --     callback = function()
    --         if textwire_client then
    --             local client = vim.lsp.get_client_by_id(textwire_client)
    --             if client then
    --                 client.stop()
    --             end
    --         end
    --     end,
    -- })

    -- local client = vim.lsp.start({
    -- 	name = "textwirelsp",
    -- 	cmd = { "/Users/serhiichornenkyi/www/open/textwire/lsp/main" },
    -- })
    --
    -- local startLspServer = function()
    -- 	if not client then
    -- 		vim.notify("Textwire LSP Client error. Could not start", vim.log.levels.ERROR)
    -- 		return
    -- 	end
    --
    -- 	vim.lsp.buf_attach_client(0, client)
    -- end
    --
    -- vim.api.nvim_create_autocmd("FileType", {
    -- 	pattern = "textwire",
    -- 	callback = startLspServer,
    -- })
end

return M