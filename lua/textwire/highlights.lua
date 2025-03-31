local M = {}

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