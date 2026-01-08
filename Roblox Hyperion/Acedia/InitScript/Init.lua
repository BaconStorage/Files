
spawn(function()
    local real_HttpGet = getgenv().HttpGet


    local real_GetObjects = getgenv().GetObjects


    -- Hook functions
    local function hookHttpGet(self, url, ...)
        print("[Acedia] HttpGet intercepted:", url)
        return real_HttpGet(url, ...)
    end

    local function hookGetObjects(self, assetId)
        print("[Acedia] GetObjects intercepted:", assetId)
        return real_GetObjects(assetId)
    end

    -- Get the metatable of game
    local mt = getrawmetatable(getgenv().game)
    if not mt then
        warn("Could not get metatable of game")
        return
    end

    -- Backup original __namecall if needed
    local old_namecall = mt.__namecall

    -- Make metatable writable
    if make_writeable then
        make_writeable(mt)  -- Some exploits have this
    elseif setreadonly then
        setreadonly(mt, false)
    end

    -- Hook __namecall to intercept method calls like game:HttpGet()
    mt.__namecall = newcclosure(function(self, ...)
        local method = getnamecallmethod()
        local args = {...}

        if self == game then
            if method == "HttpGet" or method == "HttpGetAsync" then
                return real_HttpGet(args[1], unpack(args, 2))
            elseif method == "GetObjects" then
                return real_GetObjects(args[1])
            end
        end

        -- Fall back to original behavior
        if old_namecall then
            return old_namecall(self, ...)
        end
    end

    end))
if setreadonly then
        setreadonly(mt, true)
    end


