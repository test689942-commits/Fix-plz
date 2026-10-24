-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local DataMgr, _, _ = _G.DataMgr, _G.GameMgr, _G.New
local _ = {
    common = 1,
    epic = 2,
    legend = 3,
    devil = 4
}
local t1 = {}

local function GetItemModel(p1, p2, p3) -- line: 8
    -- upvalues: DataMgr (copy), t1 (copy)
    if p2 then
        local Config = DataMgr:GetConfig("SkinData", p2)
        local GetAsset = DataMgr.GetAsset
        local model = Config.model
        local ok, result = pcall(GetAsset, DataMgr, model)

        if ok then
            return (result:Clone())
        end

        error(p1.id .. "skin 不存在")

        return result
    end

    local Config = DataMgr:GetConfig("ItemData", p1.id)
    local GetAsset = DataMgr.GetAsset
    local model = Config.model
    local ok, result = pcall(GetAsset, DataMgr, model)

    if not ok then
        error(p1.id .. "model 不存在")
    end

    local clone

    if Config.type == "Weapon" then
        if result == nil then
            print(p1.id .. "model 不存在")

            return
        end

        local v1 = result:FindFirstChild(p2 or "Default")

        if not v1 then
            print(p1.id .. "skin 不存在")

            return
        end

        clone = v1:Clone()
    else
        clone = result and result:Clone()
    end

    if p3 then
        if t1[Config.type] then
            t1[Config.type](clone)

            return clone
        end

        t1.Normal(clone)
    end

    return clone
end

t1.Normal = function(p4) -- line: 50
    local _, BoundingBox = p4:GetBoundingBox()
    local v2 = 2 / BoundingBox.X < 10 and 2 / BoundingBox.X or 10

    v2 = 2 / BoundingBox.Y < v2 and 2 / BoundingBox.Y or v2
    v2 = 2 / BoundingBox.Z < v2 and 2 / BoundingBox.Z or v2
    p4:ScaleTo(v2)
    p4:PivotTo(CFrame.new(0, 0, -2) * CFrame.Angles(0, 1.5707963267948966, 0) * CFrame.Angles(-1.0471975511965976, 0, 0))
end

t1.Weapon = function(p5) -- line: 60
    local _, BoundingBox = p5:GetBoundingBox()
    local v3 = 2 / BoundingBox.X < 10 and 2 / BoundingBox.X or 10

    v3 = 2 / BoundingBox.Y < v3 and 2 / BoundingBox.Y or v3
    v3 = 2 / BoundingBox.Z < v3 and 2 / BoundingBox.Z or v3
    p5:ScaleTo(v3)
    p5:PivotTo(CFrame.new(0, 0, -0.8))
end

return GetItemModel
