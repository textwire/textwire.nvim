local textwire = {}

local deprecation_msg = [[
textwire.load_highlights() is deprecated and will be removed in the next major
version update. Use textwire.nuild() instead.

Go into your plugins/textwire.lua config file and rename load_highlights()
to build() to hide this warning message.
]]

--- Load the highlights (syntax highlighting) for Textwire.
--- @return nil
--- @deprecated This function is deprecated. Use `textwire.build()` instead.
function textwire.load_highlights()
    require("textwire.highlights").move()

    vim.notify(deprecation_msg, vim.log.levels.WARN, {
        title = "Deprecation Warning",
        timeout = 10000,
    })
end

--- Install proper highlights for Textwire
--- @return nil
function textwire.build()
    require("textwire.highlights").refresh_files()
end

return textwire
