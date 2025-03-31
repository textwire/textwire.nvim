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

M.load_highlights = function()
    local queries_dir = vim.fn.stdpath("config") .. "/queries/textwire"

    if is_dir(queries_dir) then
        has_query_files = true
    else
        vim.fn.mkdir(queries_dir, "p")
    end

    for _, file in ipairs(query_files) do
        create_query_file(file, queries_dir)
    end

    if has_query_files then
        print("Highlighting files have been updated in", queries_dir)
        return
    end

    print("Highlighting files have been installed into", queries_dir)
end

return M