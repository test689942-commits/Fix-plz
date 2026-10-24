-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local NetContext = game:GetService("MemoryStoreService"):GetHashMap("NetContext")
local v1 = _G.New("Utility.Context")()

return {
    new = function(_) -- new | line: 7
        -- upvalues: NetContext (copy), v1 (copy)
        game:BindToClose(function() -- line: 8
            -- upvalues: NetContext (copy), v1 (copy)
            for v2, v3 in v1.context do
                if v3 then
                    local function v4() -- line: 11
                        -- upvalues: v2 (copy), NetContext (copy)
                        return NetContext:RemoveAsync((tostring(v2)))
                    end

                    pcall(v4)
                end
            end
        end)
    end,
    Start = function(_, p3, p4) -- Start | line: 19
        -- upvalues: NetContext (copy), v1 (copy)
        local v5 = p4 or 60
        local v6 = false

        v1:Wait(p3)

        local n1 = 0.5

        while not v6 do
            local function v7() -- line: 25
                -- upvalues: v5 (copy), p3 (copy), v6 (ref), NetContext (copy)
                return NetContext:UpdateAsync(tostring(p3), function(p5) -- line: 26
                    -- upvalues: v6 (ref)
                    if p5 == nil then
                        v6 = true

                        return 1
                    end
                end, v5)
            end

            if not pcall(v7) then
                print(p3)
                n1 *= 2
            end

            if not v6 then
                task.wait(n1)
            end
        end

        v1:Start(p3)
        print("start", p3)
    end,
    Destroy = function(_, p7) -- Destroy | line: 46
        -- upvalues: NetContext (copy), v1 (copy)
        local v8 = false
        local n2 = 0.5

        task.spawn(function() -- line: 49
            -- upvalues: p7 (copy), v8 (ref), n2 (ref), NetContext (copy)
            while not v8 do
                local function v9() -- line: 51
                    -- upvalues: p7 (copy), NetContext (copy)
                    return NetContext:RemoveAsync((tostring(p7)))
                end

                v8 = pcall(v9)

                if not v8 then
                    n2 *= 2
                    task.wait(n2)
                end
            end
        end)
        v1:Destroy(p7)
        print("end", p7)
    end,
    WaitLocal = function(_, p9) -- WaitLocal | line: 64
        -- upvalues: v1 (copy)
        v1:Wait(p9)
    end
}
