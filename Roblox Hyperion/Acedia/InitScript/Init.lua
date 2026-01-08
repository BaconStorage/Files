-- Wait until Workspace is available

spawn(function()



local mt = getrawmetatable(getgenv().game)
local old_index = mt.__index
local old_namecall = mt.__namecall

setreadonly(mt, false)

mt.__index = newcclosure(function(self, key)
    if key == "HttpGet" or key == "HttpGetAsync" then
        return getgenv().HttpGet
    elseif key == "GetObjects" then
        return getgenv().GetObjects
    end
    return old_index(self, key)
end)

mt.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod()

    if method == "HttpGet" or method == "HttpGetAsync" then
        return getgenv().HttpGet(...)
    elseif method == "GetObjects" then
        return getgenv().GetObjects(...)
    end
    return old_namecall(self, ...)
end)

setreadonly(mt, true)
    end)





