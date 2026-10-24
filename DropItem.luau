-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = game:GetService("Players").LocalPlayer
local New, DataMgr, NetMgr, GameMgr = _G.New, _G.DataMgr, _G.NetMgr, _G.GameMgr
local _ = _G.EventMgr
local v1 = New("Utility.Tool")()
local t2 = {
    common = 1300,
    elite = 1301,
    epic = 1302,
    legend = 1303,
    devil = 1304
}
local t1 = {}

function t1.new(p1, p2, p3) -- line: 19
    -- upvalues: RunService (copy), New (copy), DataMgr (copy), GameMgr (copy), v1 (copy)
    p1.cd = p3 or 1
    p1.item = p2
    p1.data = DataMgr:GetConfig("ItemData", p2.id)
    p1.trove = New("Utility.Trove")()

    local ItemModel = v1:GetItemModel(p1.item)

    if ItemModel == nil then
        return
    end

    p1.trove:Add(ItemModel)
    p1.model = ItemModel

    local clone = script.ItemEff:Clone()

    clone.Parent = ItemModel
    clone.CFrame = ItemModel.PrimaryPart.CFrame

    local Weld = Instance.new("Weld", clone)

    Weld.Part0 = ItemModel.PrimaryPart
    Weld.Part1 = clone

    local v2 = GameMgr:ShowEffect("SkillEffect", ItemModel.PrimaryPart.CFrame, "光柱", -1)

    p1.trove:Add(RunService.RenderStepped:Connect(function() -- line: 40
        -- upvalues: p1 (copy), ItemModel (copy), v2 (copy)
        if v2 == nil or v2.effect == nil then
            p1:Destroy()
        elseif ItemModel.PrimaryPart ~= nil then
            v2.effect.CFrame = CFrame.new(ItemModel.PrimaryPart.CFrame.Position)
        end
    end))
    v2.effect.BillboardGui.Main.ItemName.Text = p1.data.name

    local Color = DataMgr:GetAsset(DataMgr:GetConfig("QualityData", p2.quality or p1.data.quality).color).Color

    v2.effect.BillboardGui.Main.UIGradient.Color = Color
    clone.A1.Trail.Color = Color

    for _, child in v2.effect.Line:GetChildren() do
        if child:IsA("Beam") then
            child.Color = Color
        end
    end

    v2.effect.Line.Exotic2.Eff.Color = Color
    p1.trove:Add(v2)
    Instance.new("Highlight", ItemModel).FillTransparency = 1
    p1:Drop()
end

local t3 = {
    common = 2,
    elite = 3,
    epic = 4,
    legend = 5
}

function t1.Drop(p4) -- line: 69
    -- upvalues: TweenService (copy), LocalPlayer (copy), DataMgr (copy), t3 (copy)
    for _, descendant in p4.model:GetDescendants() do
        if descendant:IsA("BasePart") then
            descendant.CanCollide = true
            descendant.CanTouch = false
            descendant.CanQuery = false
            descendant.Anchored = false
            descendant.CollisionGroup = "NoCollisions"
            descendant.AssemblyLinearVelocity = Vector3.new(math.random() - 0.5, 1, math.random() - 0.5).Unit * 40
        end
    end

    p4.model.PrimaryPart.Anchored = false
    task.delay(p4.cd, function() -- line: 81
        -- upvalues: p4 (copy), TweenService (copy), LocalPlayer (copy), DataMgr (copy), t3 (copy)
        if p4.model ~= nil and p4.model.PrimaryPart ~= nil then
            local Part = Instance.new("Part", p4.model)

            Part.CFrame = p4.model.PrimaryPart.CFrame

            local Weld = Instance.new("Weld", Part)

            Weld.Part0 = p4.model.PrimaryPart
            Weld.Part1 = Part
            p4.trove:Add(Part)
            Part.CanCollide = false
            Part.Shape = Enum.PartType.Ball
            Part.Size = Vector3.new(15, 15, 15)
            Part.Transparency = 1

            local v5 = false

            Part.Touched:Connect(function(p5) -- line: 96
                -- upvalues: Part (copy), v5 (ref), p4 (copy), TweenService (copy), LocalPlayer (copy), DataMgr (copy), t3 (copy)
                if v5 then
                    return
                end

                local Model = p5:FindFirstAncestorWhichIsA("Model")

                if Model ~= nil and Model == LocalPlayer.Character then
                    v5 = true

                    local v6 = DataMgr:GetSetting("PickFilter") or 1

                    if v6 ~= 1 and p4.item and p4.item.quality and t3[p4.item.quality] <= v6 then
                        task.delay(2, function() -- line: 109
                            -- upvalues: v5 (ref)
                            v5 = false
                        end)
                    elseif DataMgr:ChackBagCapacity({
                        {
                            "Item",
                            p4.item
                        }
                    }) then
                        p4.trove:Remove(Part)
                        Part:Destroy()
                        p4.model.PrimaryPart.Anchored = true

                        for _, descendant in p4.model:GetDescendants() do
                            if descendant:IsA("BasePart") then
                                descendant.CanCollide = false
                                descendant.CanTouch = false
                                descendant.CanQuery = false
                            end
                        end

                        TweenService:Create(p4.model.PrimaryPart, TweenInfo.new(0.8, Enum.EasingStyle.Cubic), {
                            CFrame = LocalPlayer.Character.PrimaryPart.CFrame
                        }):Play()
                        task.delay(0.8, function() -- line: 133
                            -- upvalues: p4 (copy)
                            p4:PickUp()
                        end)
                    else
                        task.delay(2, function() -- line: 117
                            -- upvalues: v5 (ref)
                            v5 = false
                        end)
                    end
                end
            end)
        end
    end)
end

function t1.PickUp(p6) -- line: 140
    -- upvalues: DataMgr (copy), NetMgr (copy), GameMgr (copy), t2 (copy)
    if not DataMgr:ChackBagCapacity({
        {
            "Item",
            p6.item
        }
    }) then
        p6:Drop()

        return
    end

    NetMgr:FireServer("PickItem", p6.item.uid, p6.model.PrimaryPart.CFrame)
    p6:Destroy()

    if t2[p6.data.quality] then
        GameMgr:PlaySound(t2[p6.data.quality])
    end
end

function t1.Destroy(p7) -- line: 153
    p7.trove:Clean()
end

return t1
