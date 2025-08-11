local textwire = {}

--- Install proper highlights for Textwire
--- @return nil
function textwire.build()
    require("textwire.highlights").refresh_files()
end

return textwire
