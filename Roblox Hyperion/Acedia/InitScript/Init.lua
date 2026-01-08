-- Wait until Workspace is available AND game is fully loaded
spawn(function()
    repeat
        task.wait()
    until game:IsLoaded() and game:GetService("Workspace")

    -- Only proceed if we're in an executor environment
    if not checkcaller() then
        return  -- Skip if running in normal Roblox context
    end

    local mt = getrawmetatable(game)
    if not mt then
        return  -- Fallback if metatable is inaccessible
    end

    local old_index = mt.__index
    local old_namecall = mt.__namecall

    setreadonly(mt, false)

    mt.__index = newcclosure(function(self, key)
        if key == "HttpGet" or key == "HttpGetAsync" then
                    if not checkcaller() then
            return getgenv().HttpGet
                    end
        elseif key == "GetObjects" then
                    if not checkcaller() then
            return getgenv().GetObjects
                    end
        end
        return old_index(self, key)
    end)

    mt.__namecall = newcclosure(function(self, ...)
        local method = getnamecallmethod()
        if method == "HttpGet" or method == "HttpGetAsync" then
                    if not checkcaller() then
            return getgenv().HttpGet(...)
                    end
        elseif method == "GetObjects" then
                    if not checkcaller() then
            return getgenv().GetObjects(...)
                    end
        end
        return old_namecall(self, ...)
    end)

    setreadonly(mt, true)
end)
