-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local PoolMgr = _G.PoolMgr
local RunService = game:GetService("RunService")
local New, GameMgr = _G.New, _G.GameMgr

return {
    Show = function(_, p2, p3, p4) -- Show | line: 7
        -- upvalues: PoolMgr (copy), RunService (copy), New (copy), GameMgr (copy)
        local v1 = New("Utility.Trove")()
        local t2 = {}

        for _ = 1, p3 do
            local v2 = PoolMgr:Get("Effect_ExpGetEffect", script.EXP)

            v2.Anchored = true
            v2.Parent = workspace.FX
            v2.CFrame = CFrame.new(p2)
            table.insert(t2, {
                v2,
                Vector3.new(math.random() - 0.5, math.random() - 0.2, math.random() - 0.5).Unit * 32
            })
        end

        local n1 = 0.5

        RunService.RenderStepped:Connect(function(p5) -- line: 19
            -- upvalues: p4 (copy), v1 (copy), t2 (copy), n1 (ref), PoolMgr (copy), GameMgr (copy)
            if p4 == nil or p4.Parent == nil then
                v1:Clean()
            end

            n1 -= p5

            for i = #t2, 1, -1 do
                local v6 = t2[i]
                local v7 = p4.CFrame.Position - v6[1].CFrame.Position

                if not (n1 < 0 and v7.Magnitude < 2) then
                    v6[2] -= v6[2] * p5 * 1.5
                    v6[1].CFrame += (v6[2] + v7.Unit * 16) * p5 * 1.5
                else
                    PoolMgr:Push("Effect_ExpGetEffect", v6[1])
                    table.remove(t2, i)
                    task.spawn(function() -- line: 30
                        -- upvalues: p4 (copy), GameMgr (copy)
                        GameMgr:ShowEffect("ExpGet", p4.CFrame)
                        GameMgr:PlaySound(1903)
                    end)
                end
            end
        end)
        v1:Add(function() -- line: 40
            -- upvalues: t2 (copy), PoolMgr (copy)
            for _, v8 in t2 do
                PoolMgr:Push("Effect_ExpGetEffect", v8[1])
            end
        end)
    end
}
