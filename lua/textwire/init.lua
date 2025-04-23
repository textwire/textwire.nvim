local textwire = {}

--- Load the highlights (syntax highlighting) for Textwire.
--- @return nil
function textwire.load_highlights()
    require("textwire.highlights").load()
end

--- Load and install LSP server for Textwire.
--- @return nil
function textwire.load_lsp()
    require("textwire.lsp").load()
end

return textwire
