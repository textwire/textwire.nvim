local M = {}

local has_query_files = false
local query_files = {
    "highlights.scm",
    "injections.scm",
}

local function is_dir(dir)
    return vim.fn.isdirectory(dir) ~= 0
end

local function create_query_file(filename, queries_dir)
    local full_filepath = queries_dir .. "/" .. filename

    -- Create target file locally
    local file = io.open(full_filepath, "w")

    if not file then
        print("Can't create a file: " .. full_filepath)
        return
    end

    file:close()

    local url = "https://raw.githubusercontent.com/textwire/tree-sitter-textwire/refs/heads/master/queries/" .. filename

    vim.fn.system("wget " .. url .. " -O " .. full_filepath)
end

M.setup = function(opts)
    opts = opts or {}

    if opts.highlights and opts.highlights.enabled then
        require("textwire.highlights").load_highlights()
    end

    if opts.lsp and opts.lsp.enabled then
        require("textwire.lsp").load_lsp()
    end
end

return M
