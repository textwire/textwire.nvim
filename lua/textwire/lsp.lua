local lsp = {}

vim.api.nvim_create_user_command("TextwireInstallLsp", function()
    lsp.load()
end, {})

-- Function to get the file path for the LSP binary, directory and
-- destination URL.
--
--- @return string LSP binary path
--- @return string LSP directory path
--- @return string Destination URL
local function lsp_path()
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
    local bin_url = string.format(
        "https://raw.githubusercontent.com/textwire/lsp/master/bin/textwire_lsp_%s%s",
        platform,
        extension
    )

    return lsp_dir .. "textwire_lsp" .. extension, lsp_dir, bin_url
end

function lsp.load()
    local lsp_bin, lsp_dir, bin_url = lsp_path()

    -- Ensure the directory exists
    vim.fn.mkdir(lsp_dir, "p")

    -- Download the binary
    print("1. Downloading Textwire LSP binary...")

    local download_command = table.concat({
        "curl -o",
        lsp_bin,
        bin_url,
        "> /dev/null 2>&1",
    }, " ")

    local success = os.execute(download_command)

    if success ~= 0 then
        error("Failed to download the Textwire LSP binary")
    end

    -- Set executable permissions
    print("2. Setting executable permissions...")
    success = os.execute("chmod +x " .. lsp_bin)

    if success ~= 0 then
        error("Failed to set executable permissions on the Textwire LSP binary")
    end

    print("3. Textwire LSP installed!")
    print("Reload Neovim to use LSP features")
end

-- Function to attach the LSP to the current buffer.
--- @return nil
function lsp.attach()
    vim.api.nvim_create_autocmd("FileType", {
        pattern = "textwire",
        callback = function()
            local lsp_bin = lsp_path()

            if vim.fn.filereadable(lsp_bin) == 0 then
                vim.schedule(function()
                    print("Textwire LSP binary not found. Please run :TextwireInstallLsp to install it")
                end)
                return
            end

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
