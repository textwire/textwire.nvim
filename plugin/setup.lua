-- Add file type detection for .tw and .tw.html
vim.filetype.add({
	extension = {
		tw = "textwire",
		["tw.html"] = "textwire",
	},
})

-- vim.api.nvim_create_autocmd("VimEnter", {
-- 	callback = function()
-- 		require("textwire.lsp")
-- 	end,
-- })
