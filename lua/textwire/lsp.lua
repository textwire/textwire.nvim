local lsp = {}

-- Function to get the file path for the LSP binary, directory and
-- destination URL.
--
--- @return string LSP binary path
--- @return string LSP directory path
--- @return string Destination URL
local function lspPath()
    local os_name = vim.loop.os_uname().sysname
    local arch = vim.loop.os_uname().machine
    local platform
    local extension = ""

    -- Determine the platform and set the binary name
    if os_name == "Darwin" then
        platform = "darwin"
        if arch == "arm64" then
            platform = platform .. "_arm64"
        else
            platform = platform .. "_amd64"
        end
    elseif os_name == "Linux" then
        platform = "linux_amd64"
    elseif os_name == "Windows_NT" then
        platform = "windows_amd64"
        extension = ".exe"
    else
        error("Unsupported platform: " .. os_name)
    end

    local lsp_dir = vim.fn.stdpath("data") .. "/lsp_servers/textwire/"
    local binURL =
        string.format("https://github.com/textwire/lsp/blob/master/bin/textwire_lsp_%s%s", platform, extension)

    return lsp_dir .. "textwire_lsp" .. extension, lsp_dir, binURL
end

function lsp.load()
    local lsp_bin, lsp_dir, binURL = lspPath()

    -- Ensure the directory exists
    vim.fn.mkdir(lsp_dir, "p")

    -- Download the binary
    print("Downloading Textwire LSP binary...")
    local download_command = { "curl", "-L", "-o", binURL, lsp_bin }
    local success = os.execute(table.concat(download_command, " ") .. " > /dev/null 2>&1")

    if success ~= 0 then
        error("Failed to download the Textwire LSP binary")
    end

    -- Set executable permissions
    print("Setting executable permissions...")
    success = os.execute("chmod +x " .. lsp_bin)

    if success ~= 0 then
        error("Failed to set executable permissions on the Textwire LSP binary")
    end

    print("Textwire LSP binary downloaded and installed successfully")
end

-- Function to attach the LSP to the current buffer.
--- @return nil
function lsp.attach()
    vim.api.nvim_create_autocmd("FileType", {
        pattern = "textwire",
        callback = function()
            -- Force continuous completion
            vim.bo.completeopt = "menu,menuone,noselect,noinsert"
            vim.bo.completefunc = "v:lua.vim.lsp.omnifunc"

            -- Keymap to manually trigger if needed
            vim.keymap.set("i", "<C-Space>", "<C-x><C-o>", { buffer = true })

            vim.lsp.start({
                name = "textwire",
                cmd = { "/Users/serhiichornenkyi/www/open/textwire/lsp/main" },
                root_dir = vim.fs.root(0, { "go.mod", ".git" }),
            })
        end,
    })
end

return lsp
