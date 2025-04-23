-- Add file type detection for .tw and .tw.html
vim.filetype.add({
	extension = {
		tw = "textwire",
		["tw.html"] = "textwire",
	},
})

local parser_config = require("nvim-treesitter.parsers").get_parser_configs()

parser_config.textwire = {
	install_info = {
		url = "https://github.com/textwire/tree-sitter-textwire",
		files = { "src/parser.c", "src/scanner.c" },
		branch = "master",
		-- if stand-alone parser without npm dependencies
		generate_requires_npm = false,
		-- if directory contains pre-generated src/parser.c
		requires_generate_from_grammar = true,
	},
}

require("textwire.lsp").attach()
