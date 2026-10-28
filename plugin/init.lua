-- Add file type detection for .tw and .tw.html
vim.filetype.add({
    extension = {
        tw = "textwire",
        ["tw.html"] = "textwire",
    },
})

-- In your textwire.nvim/plugin/init.lua
local function register_textwire()
    local parsers = require("nvim-treesitter.parsers")
    parsers.textwire = {
        install_info = {
            url = "https://github.com/textwire/tree-sitter-textwire",
            files = { "src/parser.c", "src/scanner.c" },
            branch = "master",
            generate_requires_npm = false,
            requires_generate_from_grammar = true,
        },
    }
end

-- Register immediately
register_textwire()

-- Re-register after every parser reload (TSUpdate, TSInstall, etc.)
vim.api.nvim_create_autocmd("User", {
    pattern = "TSUpdate",
    callback = register_textwire,
})

require("textwire.icon").set_icon()
require("textwire.lsp").attach()

-- Change comment for Textwire
vim.api.nvim_create_autocmd("FileType", {
    pattern = "textwire",
    callback = function()
        vim.bo.commentstring = "{{-- %s --}}"
    end,
})
