local M = {}

local ICON = "󰬞"
local COLOR = "#f5cb23"

-- Try nvim-web-devicons
---@return boolean
local try_devicons = function()
    local ok, devicons = pcall(require, "nvim-web-devicons")

    if not ok then
        return false
    end

    local success, err = pcall(function()
        devicons.set_icon({
            tw = { icon = ICON, color = COLOR, name = "Textwire" },
        })
        devicons.refresh()
    end)

    return success and err ~= false
end

-- Try mini.icons
---@return boolean
local try_mini_icons = function()
    local ok, mini_icons = pcall(require, "mini.icons")

    if not ok then
        return false
    end

    local success = pcall(function()
        mini_icons.setup({
            ['.tw'] = { icon = ICON, color = COLOR },
        })
    end)

    return success
end

-- Set the icon automatically when plugin loads
function M.set_icon()
    local applied = try_devicons()

    if applied then
        return
    end

    try_mini_icons()
end

return M
