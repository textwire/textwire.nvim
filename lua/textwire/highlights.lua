local highlights = {}

local utils = require("textwire.utils")

--- Move highlight files from the plugin directory to the user's config.
--- @return nil
function highlights.refresh_files()
	local queries_dir = utils.plugin_path() .. "/queries"
	local dest_dir = vim.fn.stdpath("config") .. "/queries/textwire"

	if not utils.is_dir(dest_dir) then
		vim.fn.mkdir(dest_dir, "p")
	end

	local files = vim.fn.globpath(queries_dir, "*", 0, 1)

	-- Copy files from queries_dir to dest_dir
	for _, file in ipairs(files) do
		local file_name = vim.fn.fnamemodify(file, ":t")
		local dest_file = dest_dir .. "/" .. file_name

		-- Delete the file if it already exists
		if vim.fn.filereadable(dest_file) then
			vim.fn.delete(dest_file)
		end

		vim.fn.system({ "cp", file, dest_file })
	end
end

return highlights
