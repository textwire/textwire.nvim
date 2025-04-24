local textwire = {}

--- Load the highlights (syntax highlighting) for Textwire.
--- @return nil
--- @deprecated This function is deprecated. Use `textwire.build()` instead.
function textwire.load_highlights()
	require("textwire.highlights").load()
	require("textwire.lsp").load()
end

--- Load and install LSP server for Textwire.
--- @return nil
function textwire.build()
	require("textwire.highlights").load()
	require("textwire.lsp").load()
end

return textwire
