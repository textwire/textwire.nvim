local textwire = {}

--- Load the highlights (syntax highlighting) for Textwire.
--- @return nil
function textwire.load_highlights()
    require("textwire.highlights").load()
end

return textwire