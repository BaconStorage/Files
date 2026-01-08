-- Wait until Workspace is available

spawn(function()
    repeat task.wait() until game:IsLoaded()

    -- Wait for Players service to exist
    repeat task.wait() until workspace:FindFirstChild("Players")

    -- 🔒 Anti-Cheat Signal/Check System
    -- Wait for anti-cheat to finish initial scans by monitoring:
    -- 1. No more rapid script loads in first few seconds
    -- 2. Player count stabilizes (usually 1-2 seconds after join)
    -- 3. No anti-cheat-related services being created rapidly

    local startTime = tick()
    local lastScriptCount = #getscripts()

    repeat
        task.wait(0.5)

        -- If more than 5 seconds have passed, assume safe
        if tick() - startTime > 5 then
            break
        end

        -- If script count is stable (no new scripts loading rapidly), likely safe
        local currentScriptCount = #getscripts()
        if currentScriptCount == lastScriptCount then
            break
        end
        lastScriptCount = currentScriptCount

    until false


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






