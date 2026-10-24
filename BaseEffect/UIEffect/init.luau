-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local PoolMgr = _G.PoolMgr
local t2 = {}

return {
    Show = function(p1, p2, p3, p4) -- Show | line: 5
        -- upvalues: PoolMgr (copy), t2 (copy)
        if not t2[p3] then
            t2[p3] = script:FindFirstChild(p3)
        end

        local v1 = PoolMgr:Get("Effect_UI" .. p3, t2[p3])

        v1.Parent = p2
        p1.obj = v1
        p1.value = p3

        if p4 ~= -1 then
            p1:Emit(v1)
            task.delay(p4 or 1.5, function() -- line: 18
                -- upvalues: p3 (copy), v1 (copy), PoolMgr (copy)
                if v1.Parent then
                    PoolMgr:Push("Effect_UI" .. p3, v1)
                end
            end)
        end

        return p1
    end,
    Hide = function(p5) -- Hide | line: 27
        -- upvalues: PoolMgr (copy)
        if p5.effect.Parent then
            PoolMgr:Push("Effect_UI" .. p5.value, p5.obj)
        end
    end
}
