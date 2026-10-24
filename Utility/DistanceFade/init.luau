-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local t1 = {}
local LocalPlayer = game:GetService("Players").LocalPlayer
local DistanceFade = require(script.DistanceFade)

game:GetService("TweenService")
game:GetService("RunService")

local t2 = {
    EdgeDistanceCalculations = true,
    Texture = "rbxassetid://18852900044",
    TextureTransparency = 0.25,
    BackgroundTransparency = 0.95,
    TextureColor = Color3.fromRGB(115, 248, 255),
    BackgroundColor = Color3.fromRGB(0, 153, 255),
    TextureSize = Vector2.new(3, 2.5),
    TextureOffset = Vector2.new(0, 0.5),
    Brightness = 3
}

function t1.new(_, p2, p3) -- line: 18
    -- upvalues: LocalPlayer (copy), DistanceFade (copy), t2 (copy)
    local v1 = DistanceFade.new()

    v1:UpdateSettings(p3 or t2)

    local t3 = {}

    for _, child in p2:GetChildren() do
        if child:IsA("Part") then
            table.insert(t3, child)
            v1:AddFace(child, Enum.NormalId.Right)
        end
    end

    p2.ChildAdded:Connect(function(p4) -- line: 32
        -- upvalues: v1 (copy), t3 (copy)
        if p4:IsA("Part") then
            table.insert(t3, p4)
            v1:AddFace(p4, Enum.NormalId.Right)
        end
    end)

    local Vector3Value = Instance.new("Vector3Value")

    Vector3Value.Parent = script

    local v2 = game:GetService("TweenService"):Create(Vector3Value, TweenInfo.new(6, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1, false), {
        Value = Vector3.new(-6, 5.5, 0)
    })

    v2:Play()

    local connection = game:GetService("RunService").Heartbeat:Connect(function() -- line: 43
        -- upvalues: v1 (copy), t3 (copy), Vector3Value (copy), LocalPlayer (copy)
        if LocalPlayer.Character ~= nil and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") ~= nil then
            for v3, v4 in t3 do
                local Y = Vector3Value.Value.Y

                v1:UpdateFaceSettings(v4, Enum.NormalId.Right, {
                    TextureOffset = Vector2.new(v3, Y)
                })
            end

            v1:Step()
        end
    end)

    return {
        Destroy = function() -- Destroy | line: 57
            -- upvalues: v2 (copy), connection (copy)
            v2:Destroy()
            connection:Disconnect()
        end
    }
end

return t1
