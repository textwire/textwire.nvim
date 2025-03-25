-- Add file type detection for .tw and .tw.html
vim.filetype.add({
    extension = {
        tw = "textwire",
        ["tw.html"] = "textwire",
    },
})

vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
        print("Start LSP server for Textwire")

        local client = vim.lsp.start({
            name = "textwirelsp",
            cmd = { "/Users/serhiichornenkyi/www/open/textwire/lsp/main" },
        })

        local startLspServer = function()
            if not client then
                vim.notify("Textwire LSP Client error. Could not start", vim.log.levels.ERROR)
                return
            end

            vim.lsp.buf_attach_client(0, client)
        end

        vim.api.nvim_create_autocmd("FileType", {
            pattern = "textwire",
            callback = startLspServer,
        })
    end,
})
