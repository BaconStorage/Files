if not checkcaller() then
    return
end

task.spawn(function()
    repeat
        task.wait()
    until game:IsLoaded() and workspace:FindFirstChild("Players")

    -- Create a proxy object that mimics 'game'
    local RealGame = game
    local GameProxy = newproxy(true)
    local ProxyMetatable = getmetatable(GameProxy)

    local HttpGetOverride = getgenv().HttpGet
    local GetObjectsOverride = getgenv().GetObjects

    ProxyMetatable.__index = function(self, key)
        if key == "HttpGet" or key == "HttpGetAsync" then
            return HttpGetOverride
        elseif key == "GetObjects" then
            return GetObjectsOverride
        else
            return RealGame[key]
        end
    end

    ProxyMetatable.__namecall = function(self, ...)
        local method = getnamecallmethod()
        if method == "HttpGet" or method == "HttpGetAsync" then
            return HttpGetOverride(...)
        elseif method == "GetObjects" then
            return GetObjectsOverride(...)
        else
            return RealGame[method](RealGame, ...)
        end
    end

    -- Replace global 'game' with proxy
    getgenv().game = GameProxy

    -- Optional: Also update _G if needed
    if rawget(_G, "game") == RealGame then
        _G.game = GameProxy
    end
end)
