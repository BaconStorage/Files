-- Wait until Workspace is available
spawn(function()
local Workspace = game:GetService("Workspace")




local mt = getrawmetatable(game)
local old_index = mt.__index
local old_namecall = mt.__namecall

setreadonly(mt, false)

mt.__index = function(self, key)
    if key == "HttpGet" then
        return getgenv().HttpGet
    end
    return old_index(self, key)
end

mt.__namecall = function(self, ...)
    local method = getnamecallmethod()
    if method == "HttpGet" then
        return getgenv().HttpGet(...)
    end
    return old_namecall(self, ...)
end

setreadonly(mt, true)
    end)
