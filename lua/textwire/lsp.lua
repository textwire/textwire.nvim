local lsp = {}

function lsp.attach()
    vim.api.nvim_create_autocmd("FileType", {
        pattern = "textwire",
        callback = function()
            vim.lsp.start({
                name = "textwire",
                cmd = { "/Users/serhiichornenkyi/www/open/textwire/lsp/main" },
                root_dir = vim.fs.dirname(vim.fs.find({ "go.mod", ".git" }, { upward = true })[1])
            })
        end
    })
end

return lsp