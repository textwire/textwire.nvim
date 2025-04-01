--- Whether Textwire is currently enabled.
local enabled = false

local events = {}

--- Start listening and responding to various editor events
--- @return nil
function events.enable()
    enabled = true
    print("Textwire enabled")
end

--- Stop listening and responding to various editor events
--- @return nil
events.disable = vim.schedule_wrap(function()
    print("Textwire disabled")
end)

return events