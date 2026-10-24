-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local t1 = {}

t1.__index = t1

local LocalPlayer = game:GetService("Players").LocalPlayer
local GameMgr, DataMgr = _G.GameMgr, _G.DataMgr

function t1.Load(p1, p2, _) -- line: 7
    -- upvalues: LocalPlayer (copy), GameMgr (copy), DataMgr (copy)
    p1.model = p2
    p1.Syringe = GameMgr:ShowEffect("SkillEffect", p2.PrimaryPart.CFrame, "Syringe", -1).effect
    p1.Syringe.Parent = nil

    if p2 == LocalPlayer.Character then
        for _, descendant in p1.Syringe:GetDescendants() do
            if descendant:IsA("BasePart") then
                descendant.LocalTransparencyModifier = 0
                descendant:GetPropertyChangedSignal("LocalTransparencyModifier"):Connect(function() -- line: 15
                    -- upvalues: descendant (copy)
                    if descendant.LocalTransparencyModifier ~= 0 then
                        descendant.LocalTransparencyModifier = 0
                    end
                end)
            end
        end

        p1.player = DataMgr:GetClientPlayer()
    end
end

function t1.Play(p4) -- line: 26
    p4.Syringe.Parent = p4.model

    local Motor = p4.Syringe.Motor
    local v1, v2

    if p4.player and p4.player.isFPS then
        local v3 = p4.player.vm["Right Arm"]

        if v3 then
            v1 = v3
            v2 = true
        else
            v2 = false
        end
    else
        v2 = false
    end

    Motor.Part0 = if not v2 then p4.model["Right Arm"] else v1
end

function t1.Stop(p5) -- line: 31
    p5.Syringe.Parent = nil
end

function t1.Destroy(p6) -- line: 35
    p6.Syringe:Destroy()
end

return t1
