local M = {}

--- Install proper highlights for Textwire and update treesitter
--- @return nil
function M.build()
    -- Safely update query files for syntax highlight
    pcall(function()
        require("textwire.highlights").refresh_files()
    end)

    -- Safely update treesitter parser
    pcall(function()
        require("nvim-treesitter.install").update({ "textwire" })
    end)
end

return M
