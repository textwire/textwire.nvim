local lsp = {}

local utils = require("textwire.utils")

-- Function to get the file path for the LSP binary, directory and
-- destination URL.
--
--- @return string LSP binary path
local function lsp_path()
    local os_name = vim.loop.os_uname().sysname
    local arch = vim.loop.os_uname().machine
    local file_name = ""

    -- Determine the platform and set the binary name
    if os_name == "Darwin" then
        if arch == "arm64" then
            file_name = "textwire_lsp_darwin_arm64"
        else
            file_name = "textwire_lsp_darwin_amd64"
        end
    elseif os_name == "Linux" then
        file_name = "textwire_lsp_linux_amd64"
    elseif os_name == "Windows_NT" then
        file_name = "textwire_lsp_windows_amd64.exe"
    else
        error("Unsupported platform: " .. os_name)
    end

    return utils.plugin_path() .. "/bin/" .. file_name
end

-- Function to attach the LSP to the current buffer.
--- @return nil
function lsp.attach()
    vim.api.nvim_create_autocmd("FileType", {
        pattern = "textwire",
        callback = function()
            local lsp_bin = lsp_path()

            -- Force continuous completion
            vim.bo.completeopt = "menu,menuone,noselect,noinsert"
            vim.bo.completefunc = "v:lua.vim.lsp.omnifunc"

            -- Keymap to manually trigger if needed
            vim.keymap.set("i", "<C-Space>", "<C-x><C-o>", { buffer = true })

            vim.lsp.start({
                name = "textwire",
                cmd = { lsp_bin },
                root_dir = vim.fs.root(0, { "go.mod", ".git" }),
            })
        end,
    })
end

return lsp
