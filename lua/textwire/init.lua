local events = require('textwire.events')

local textwire = {}

--- Load the highlights (syntax highlighting) for Textwire.
--- @return nil
function textwire.load_highlights()
    require("textwire.load-highlights")()
end

--- Setup Textwire plugin.
--- @param opts? table
--- @return nil
function textwire.setup(opts)
    opts = opts or require("textwire.default-config")

    vim.api.nvim_create_user_command("TextwireDisable", events.disable, {
        desc = "Disable Textwire plugin",
    })

    vim.api.nvim_create_user_command("TextwireEnable", events.enable, {
        desc = "Enable Textwire plugin",
    })

    if opts.lsp and opts.lsp.enabled then
        require("textwire.lsp").load_lsp()
    end

    events.enable()
end

return textwire
