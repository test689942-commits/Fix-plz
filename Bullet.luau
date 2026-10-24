-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local t1 = {}

game:GetService("RunService")
game:GetService("Players")

local GameMgr, New = _G.GameMgr, _G.New

function t1.new(p1, p2, p3, p4, p5) -- line: 7
    -- upvalues: GameMgr (copy), New (copy)
    p1.settings = p5
    p1.entity = p2
    p1.onHit = New("CS.Action")()

    local Position, lookVector = p3.Position, p3.lookVector

    CFrame.new(Position, Position + lookVector)

    local v6 = CFrame.Angles(math.rad((math.random() * 2 - 1) * p4 / 20), math.rad((math.random() * 2 - 1) * p4 / 20), (math.rad((math.random() * 2 - 1) * p4 / 20))) * lookVector

    p1.effect = GameMgr:BroadcastEffect("BullectEffect", p3.Position, v6, p5.vel, p5.bulletColor, p5.distance, {
        workspace.FX,
        workspace.EItem,
        p1.entity.Character
    })
    p1.bullet = p1.effect.obj
end

function t1.Destroy(p6) -- line: 34
    p6.bullet:Destroy()
end

return t1
