-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local t1 = {}

t1.__index = t1

local TweenService = game:GetService("TweenService")

game:GetService("RunService")

local _ = game:GetService("Players").LocalPlayer
local GameMgr, DataMgr, _ = _G.GameMgr, _G.DataMgr, _G.EventMgr
local v1 = _G.New("Utility.Tool")()

function t1.Load(p1, p2, p3) -- line: 12
    -- upvalues: TweenService (copy), GameMgr (copy)
    p3:GetMarkerReachedSignal("Atk"):Connect(function(_) -- line: 13
        -- upvalues: p1 (copy), p2 (copy), TweenService (copy), GameMgr (copy)
        if p1.wing and p1.wing.Parent then
            for _, child in p1.wing:GetChildren() do
                if child:IsA("BasePart") and child.Transparency ~= 1 then
                    TweenService:Create(child, TweenInfo.new(1), {
                        Transparency = 1
                    }):Play()
                end
            end
        end

        GameMgr:ShowEffect("RocksEffect", (p2.PrimaryPart.CFrame * CFrame.new(0, -4, -10)).Position, Vector3.new(0, 1, 0), 8, Vector3.new(1.5, 1.5, 1.5), 8)
    end)
    p3:GetMarkerReachedSignal("Jump"):Connect(function() -- line: 25
        -- upvalues: p2 (copy), GameMgr (copy)
        GameMgr:ShowEffect("RocksEffect", (p2.PrimaryPart.CFrame * CFrame.new(0, -4, 0)).Position, Vector3.new(0, 1, 0), 3, Vector3.new(1, 1, 1), 6)
    end)
end

function t1.Play(p5, p6) -- line: 32
    -- upvalues: TweenService (copy), DataMgr (copy), v1 (copy)
    local Torso = p6:FindFirstChild("Torso")

    if Torso == nil then
        return
    end

    p5.wing = script:FindFirstChild("翅膀"):Clone()
    p5.wing.Parent = workspace.FX
    p5.wing:PivotTo(Torso.CFrame)
    v1:WeldInstance(p5.wing.Root, Torso)

    local Animation = Instance.new("Animation")

    Animation.AnimationId = DataMgr:GetConfig("AnimationData", 2008).asset
    p5.wing.AnimationController.Animator:LoadAnimation(Animation):Play()

    for _, child in p5.wing:GetChildren() do
        if child:IsA("BasePart") and child.Transparency ~= 1 then
            local Transparency = child.Transparency

            child:SetAttribute("Transparency", Transparency)
            child.Transparency = 1
            TweenService:Create(child, TweenInfo.new(0.1), {
                Transparency = Transparency
            }):Play()
        end
    end
end

function t1.Stop(p7) -- line: 55
    if p7.wing and p7.wing.Parent then
        p7.wing:Destroy()
    end
end

function t1.Destroy(_) -- line: 61
end

return t1
