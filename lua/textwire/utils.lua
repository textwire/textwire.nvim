local utils = {}

function utils.is_dir(dir)
    return vim.fn.isdirectory(dir) ~= 0
end

function utils.plugin_path()
    -- Get the current script's path
    local current_file = debug.getinfo(1, "S").source:sub(2)

    -- Get the directory of the current script
    local script_dir = vim.fn.fnamemodify(current_file, ":h")

    -- Traverse up to the plugin root
    return vim.fn.fnamemodify(script_dir, ":h:h")
end

return utils
