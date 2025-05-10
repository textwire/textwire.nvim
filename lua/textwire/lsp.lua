local lsp = {}

local utils = require("textwire.utils")

---@return string
local function binary_ext()
    if vim.loop.os_uname().sysname == "Windows_NT" then
        return ".exe"
    end

    return ""
end

---@return string
local function arch_name()
    local arch = vim.loop.os_uname().machine:lower()

    if arch == "arm64" or arch == "aarch64" then
        return "arm64"
    elseif arch == "i386" or arch == "i686" then
        return "386"
    elseif arch == "x86_64" then
        return "amd64"
    end

    vim.notify("Unsupported architecture: " .. arch, vim.log.levels.WARN)

    return "amd64"
end

---@return string
local function platform_name()
    local platform = vim.loop.os_uname().sysname

    if platform == "Darwin" then
        return "darwin"
    elseif platform == "Linux" then
        return "linux"
    elseif platform == "Windows_NT" then
        return "windows"
    end

    vim.notify("Unsupported platform: " .. platform, vim.log.levels.WARN)

    return "linux"
end

-- Function to get the file path for the LSP binary, directory and
-- destination URL.
--
--- @return string LSP binary path
local function lsp_path()
    local plat = platform_name()
    local arch = arch_name()
    local ext = binary_ext()
    local file_name = string.format("textwire_lsp_%s_%s%s", plat, arch, ext)

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
