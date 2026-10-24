-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local PoolMgr = _G.PoolMgr

return {
    Show = function(p1, p2, p3) -- Show | line: 4
        -- upvalues: PoolMgr (copy)
        if p3 ~= nil and #p3 ~= 0 then
            local v1 = PoolMgr:Get("Effect_闪电打击", script.Effect)

            v1.Parent = workspace.FX

            local n1 = 1

            while p3[n1].PrimaryPart == nil do
                n1 += 1

                if p3[n1] == nil then
                    return
                end
            end

            local v2 = p3[n1].PrimaryPart.CFrame.Position - p2

            v1.CFrame = CFrame.lookAlong(p2 + v2 / 2, v2.Unit)
            v1.Size = Vector3.new(0.25, 0.25, v2.Magnitude / 2)
            p1:Emit(v1)
            task.delay(1.5, function() -- line: 22
                -- upvalues: v1 (copy), PoolMgr (copy)
                PoolMgr:Push("Effect_闪电打击", v1)
            end)

            local v4 = n1 + 1

            while p3[v4] ~= nil do
                if p3[v4].PrimaryPart ~= nil then
                    local v5 = PoolMgr:Get("Effect_闪电打击_line", script.Line)

                    v5.Parent = workspace.FX

                    local v6 = p3[v4].PrimaryPart.CFrame.Position - p3[n1].PrimaryPart.CFrame.Position

                    v5.CFrame = CFrame.lookAlong(p3[n1].PrimaryPart.CFrame.Position, v6.Unit)
                    v5.Bottom.CFrame = CFrame.new(0, 0, v6.Magnitude / 2)
                    task.delay(0.5, function() -- line: 37
                        -- upvalues: v5 (copy), PoolMgr (copy)
                        PoolMgr:Push("Effect_闪电打击_line", v5)
                    end)
                    n1 = v4
                end

                v4 += 1
            end
        end
    end,
    Hide = function(_) -- Hide | line: 45
    end
}
