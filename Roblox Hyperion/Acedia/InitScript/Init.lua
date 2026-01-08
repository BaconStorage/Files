
spawn(function()
    repeat task.wait() until game:IsLoaded()

    -- Wait for Players service to exist
    repeat task.wait() until game:FindFirstChild("Players") ~= nil
    repeat task.wait() until game:FindFirstChild("Workspace") ~= nil
    repeat task.wait() until game:GetService("Players").LocalPlayer ~= nil
    repeat task.wait() until game:GetService("Players").LocalPlayer.UserId >= 0
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

print("loaded")
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


















