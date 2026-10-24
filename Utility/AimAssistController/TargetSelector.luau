-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local Workspace = game:GetService("Workspace")
local CollectionService = game:GetService("CollectionService")
local Players = game:GetService("Players")
local AimAssistEnum = require(script.Parent.AimAssistEnum)
local LocalPlayer = Players.LocalPlayer
local t1 = {}

t1.__index = t1

local function onSameTeam(p1, p2) -- line: 35
    if p1.Team and p2.Team then
        if p1.Team ~= p2.Team then
            return false
        end

        return not (p1.Neutral or p2.Neutral)
    end

    return false
end

local function getCenterPoint(p3) -- line: 52
    if p3:IsA("Model") then
        return p3:GetBoundingBox().Position
    end

    if p3:IsA("BasePart") then
        return p3.ExtentsCFrame.Position
    end

    warn((("Instance %* is not a Model or BasePart"):format(p3.Name)))

    return p3:GetPivot().Position
end

function t1._checkLineOfSight(_, p5, p6, p7) -- line: 64
    -- upvalues: Workspace (copy), LocalPlayer (copy)
    local v1 = RaycastParams.new()

    v1.FilterType = Enum.RaycastFilterType.Exclude
    v1.FilterDescendantsInstances = { p5, p6 }

    if LocalPlayer and LocalPlayer.Character then
        v1:AddToFilter({
            LocalPlayer.Character
        })
    end

    return Workspace:Raycast(p5:GetPivot().Position, p7, v1) == nil
end

function t1._checkPointHit(p8, p9, p10, p11) -- line: 79
    local Pivot = p9:GetPivot()
    local PivotPosition, LookVector = Pivot.Position, Pivot.LookVector
    local v2 = p11 - PivotPosition
    local Magnitude = v2.Magnitude
    local v6 = math.deg((math.acos((math.clamp(LookVector:Dot(v2.Unit), -1, 1)))))
    local v7 = Magnitude <= p8.range and v6 <= p8.fieldOfView / 2

    if v7 and not p8.ignoreLineOfSight then
        v7 = p8:_checkLineOfSight(p9, p10, v2)
    end

    return {
        hit = v7,
        angle = v6,
        distance = Magnitude
    }
end

function t1._getTargetPoints(_, p13, p14) -- line: 107
    -- upvalues: CollectionService (copy), getCenterPoint (copy)
    if not p14 then
        return { (getCenterPoint(p13)) }
    end

    local t2 = {}

    for _, v8 in p14 do
        for _, descendant in p13:GetDescendants() do
            if descendant:IsA("PVInstance") and CollectionService:HasTag(descendant, v8) then
                table.insert(t2, (getCenterPoint(descendant)))
            end
        end
    end

    return t2
end

function t1.setRange(p15, p16) -- line: 130
    p15.range = p16
end

function t1.setFieldOfView(p17, p18) -- line: 134
    p17.fieldOfView = p18
end

function t1.setSortingBehavior(p19, p20) -- line: 138
    p19.sortingBehavior = p20
end

function t1.setIgnoreLineOfSight(p21, p22) -- line: 142
    p21.ignoreLineOfSight = p22
end

function t1.addTargetTag(p23, p24, p25) -- line: 146
    p23.tags[p24] = true
    p23.tagBones[p24] = p25
end

function t1.removeTargetTag(p26, p27) -- line: 151
    p26.tags[p27] = nil
    p26.tagBones[p27] = nil
end

function t1.addPlayerTargets(p28, p29, p30, p31) -- line: 156
    p28.targetPlayers = true

    if p29 ~= nil then
        p28.ignoreLocalPlayer = p29
    else
        p28.ignoreLocalPlayer = true
    end

    if p30 ~= nil then
        p28.ignoreTeammates = p30
    else
        p28.ignoreTeammates = false
    end

    p28.playerBones = p31
end

function t1.removePlayerTargets(p32) -- line: 163
    p32.targetPlayers = false
end

function t1.getAllTargetPoints(p33) -- line: 168
    -- upvalues: CollectionService (copy), Players (copy), LocalPlayer (copy)
    local t3 = {}

    for v10, _ in p33.tags do
        local Tagged = CollectionService:GetTagged(v10)
        local v11 = p33.tagBones[v10]

        for _, v12 in Tagged do
            if v12 and v12:IsA("PVInstance") then
                table.insert(t3, {
                    instance = v12,
                    points = p33:_getTargetPoints(v12, v11)
                })
            end
        end
    end

    if LocalPlayer and p33.targetPlayers then
        local playerBones = p33.playerBones

        for _, player in Players:GetPlayers() do
            if (not p33.ignoreLocalPlayer or player ~= LocalPlayer) and (not p33.ignoreTeammates
                or not player.Team
                or not LocalPlayer.Team
                or player.Team ~= LocalPlayer.Team
                or player.Neutral
                or LocalPlayer.Neutral) and player.Character then
                local v16 = p33:_getTargetPoints(player.Character, playerBones)

                table.insert(t3, {
                    instance = player.Character,
                    points = v16
                })
            end
        end
    end

    return t3
end

function t1.selectTarget(p34, p35) -- line: 212
    -- upvalues: AimAssistEnum (copy)
    local t9 = {
        instance = nil,
        bestPosition = Vector3.new(0, 0, 0),
        distance = 0,
        normalizedDistance = 0,
        angle = 0,
        normalizedAngle = 0,
        positions = {},
        weights = {}
    }
    local n1 = 1e999

    for _, v17 in (p34:getAllTargetPoints()) do
        local instance, points = v17.instance, v17.points

        for _, v19 in points do
            local v20 = p34:_checkPointHit(p35, instance, v19)

            if v20.hit then
                local v21 = if p34.sortingBehavior == AimAssistEnum.AimAssistSortingBehavior.Angle then v20.angle elseif p34.sortingBehavior == AimAssistEnum.AimAssistSortingBehavior.Distance then v20.distance else nil

                if v21 and v21 < n1 then
                    n1 = v21
                    t9.distance = v20.distance
                    t9.angle = v20.angle
                    t9.instance = instance
                    t9.bestPosition = v19
                    t9.positions = points
                end
            end
        end
    end

    if not t9.instance then
        return nil
    end

    local t10 = {}
    local n2 = 0

    for v22, v23 in t9.positions do
        local v24 = p34:_checkPointHit(p35, t9.instance, v23)
        local v25 = if not v24.hit then 0
            elseif p34.sortingBehavior == AimAssistEnum.AimAssistSortingBehavior.Angle then 1 / (v24.angle + 0.001)
            elseif p34.sortingBehavior == AimAssistEnum.AimAssistSortingBehavior.Distance then 1 / (v24.distance + 0.001)
            else 0

        n2 += v25
        t10[v22] = v25
    end

    if n2 > 0 then
        for i = 1, #t10 do
            t10[i] /= n2
        end
    end

    t9.weights = t10
    t9.normalizedDistance = t9.distance / p34.range
    t9.normalizedAngle = t9.angle / p34.fieldOfView * 2

    return t9
end

function t1.new() -- line: 295
    -- upvalues: AimAssistEnum (copy), t1 (copy)
    local t11 = {
        range = 100,
        fieldOfView = 20,
        targetPlayers = false,
        ignoreLineOfSight = false,
        ignoreLocalPlayer = true,
        ignoreTeammates = false,
        sortingBehavior = AimAssistEnum.AimAssistSortingBehavior.Angle,
        playerBones = {},
        tags = {},
        tagBones = {}
    }

    setmetatable(t11, t1)

    return t11
end

return t1
