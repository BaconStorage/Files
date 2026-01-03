-- Wait until Workspace is available
spawn(function()
local Workspace = game:GetService("Workspace")

-- Now run your metatable hook
local mt = getrawmetatable(game)
local old_index = mt.__index
local old_namecall = mt.__namecall
setreadonly(mt, false)
mt.__namecall = function(self, ...)
    local method = getnamecallmethod()
    if method == "HttpGet" then
        return getgenv().HttpGet(...)
    end
    return old_namecall(self, ...)
end
setreadonly(mt, true)
    end)
