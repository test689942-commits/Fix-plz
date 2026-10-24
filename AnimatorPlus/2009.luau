-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local t1 = {}

t1.__index = t1

local TweenService = game:GetService("TweenService")
local _ = game:GetService("Players").LocalPlayer
local GameMgr, _, _, New = _G.GameMgr, _G.DataMgr, _G.EventMgr, _G.New
local v1 = New("Utility.Tool")()

function t1.Load(p1, p2, p3) -- line: 11
    -- upvalues: GameMgr (copy), New (copy)
    p3:GetMarkerReachedSignal("Show"):Connect(function(p4) -- line: 12
        -- upvalues: p1 (copy), p2 (copy), GameMgr (copy), New (copy)
        if p4 then
            if p1.showEffect then
                p1.showEffect:Destroy()
            end

            p1.showEffect = script["咖喱棒2"]:Clone()
            p1.showEffect.Parent = workspace.FX
            p1.showEffect.CFrame = p2.PrimaryPart.CFrame
            New("Utility.Weld")(p2.PrimaryPart, p1.showEffect)

            for _, descendant in p1.showEffect:GetDescendants() do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true
                end
            end

            GameMgr:ShowEffect("RocksEffect", (p2.PrimaryPart.CFrame * CFrame.new(0, -4, 0)).Position, Vector3.new(0, 1, 0), 6, Vector3.new(1.5, 1.5, 1.5), 6)
        elseif p1.showEffect then
            local showEffect = p1.showEffect

            for _, descendant in showEffect:GetDescendants() do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false
                end
            end

            p1.showEffect = nil
            task.delay(1, function() -- line: 38
                -- upvalues: showEffect (copy)
                showEffect:Destroy()
            end)
        end
    end)
    p3:GetMarkerReachedSignal("Trail"):Connect(function(_) -- line: 44
        -- upvalues: p1 (copy)
        for _, child in p1.sward.Root.StartPos:GetChildren() do
            if child:IsA("Trail") then
                child.Enabled = true
            end
        end
    end)
end

function t1.Play(p6, p7) -- line: 53
    -- upvalues: TweenService (copy), v1 (copy)
    local Tool = p7:FindFirstChild("Tool")

    if Tool ~= nil then
        local lenght = p7:GetAttribute("lenght")

        if lenght ~= nil then
            p6.sward = script["咖喱棒"]:Clone()
            p6.sward.Parent = workspace.FX

            local v3 = Tool:FindFirstChild("Handle") or Tool.PrimaryPart

            if v3:IsA("Motor6D") then
                v3 = v3.Part1
            end

            v1:WeldInstance(p6.sward.PrimaryPart, v3)
            TweenService:Create(p6.sward.SowrdNeon, TweenInfo.new(1), {
                Size = p6.sward.SowrdNeon.Size + Vector3.new(0, lenght, 0)
            }):Play()
            TweenService:Create(p6.sward.SowrdNeon.Weld, TweenInfo.new(1), {
                C1 = CFrame.new(0, -lenght / 2, 0)
            }):Play()
            p6.sward.Root.EndPos.CFrame = CFrame.new(0, 9 + lenght, 0)
        end
    end
end

function t1.Stop(p8) -- line: 74
    if p8.sward and p8.sward.Parent then
        p8.sward:Destroy()
        p8.sward = nil
    end

    if p8.showEffect then
        p8.showEffect:Destroy()
        p8.showEffect = nil
    end
end

function t1.Destroy(_) -- line: 85
end

return t1
