local M = {}

M.load_highlights = require("textwire.load-highlights")

M.setup = function(opts)
    opts = opts or require("textwire.default-config").default_config

    if opts.lsp and opts.lsp.enabled then
        require("textwire.lsp").load_lsp()
    end
end

return M
