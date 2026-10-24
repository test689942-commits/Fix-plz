-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local TweenService = game:GetService("TweenService")

require(script.Parent.TargetSelector)

local AimAssistEnum = require(script.Parent.AimAssistEnum)
local t1 = {}

t1.__index = t1

function t1.new() -- line: 18
    -- upvalues: AimAssistEnum (copy), t1 (copy)
    local t2 = {
        lastTargetInstance = nil,
        subjectVelocity = Vector3.new(0, 0, 0),
        type = AimAssistEnum.AimAssistType.Rotational,
        lastTargetPositions = {}
    }

    t2.strengthTable = {
        [AimAssistEnum.AimAssistMethod.Friction] = 0,
        [AimAssistEnum.AimAssistMethod.Tracking] = 0,
        [AimAssistEnum.AimAssistMethod.Centering] = 0
    }
    setmetatable(t2, t1)

    return t2
end

function t1.setType(p1, p2) -- line: 39
    p1.type = p2
end

function t1.setMethodStrength(p3, p4, p5) -- line: 44
    local v1 = math.clamp(p5, 0, 1)

    p3.strengthTable[p4] = v1
end

function t1.adjustAimFriction(p6, p7) -- line: 50
    -- upvalues: AimAssistEnum (copy)
    local v3 = math.clamp(p6.strengthTable[AimAssistEnum.AimAssistMethod.Friction] * p7.adjustmentStrength, 0, 1)

    if p7.targetResult and not (v3 <= 0) then
        local subjectCFrame = p7.subjectCFrame

        if p7.startingCFrame then
            local v4 = if p6.type == AimAssistEnum.AimAssistType.Rotational then p7.startingCFrame.Rotation + p7.subjectCFrame.Position elseif p6.type == AimAssistEnum.AimAssistType.Translational then p7.subjectCFrame.Rotation + p7.startingCFrame.Position else nil

            subjectCFrame = p7.subjectCFrame:Lerp(v4, v3)
        end

        return subjectCFrame
    end

    return p7.subjectCFrame
end

function t1.adjustAimTracking(p8, p9) -- line: 75
    -- upvalues: AimAssistEnum (copy)
    local v6 = math.clamp(p8.strengthTable[AimAssistEnum.AimAssistMethod.Tracking] * p9.adjustmentStrength, 0, 1)

    if not p9.targetResult or v6 <= 0 then
        return p9.subjectCFrame
    end

    local positions, weights = p9.targetResult.positions, p9.targetResult.weights
    local v7 = p9.subjectCFrame

    for i = 1, #positions do
        local v8 = positions[i]
        local v9 = weights[i]
        local v10 = p8.lastTargetPositions[i]

        if not (v9 <= 0) then
            if p8.type == AimAssistEnum.AimAssistType.Rotational then
                local v11 = p9.startingCFrame.Rotation + p9.subjectCFrame.Position
                local Unit = p9.startingCFrame:PointToObjectSpace(v10).Unit
                local Unit2 = v11:PointToObjectSpace(v8).Unit
                local v12 = CFrame.fromRotationBetweenVectors(Unit, Unit2)

                v7 *= CFrame.identity:Lerp(v12, v6 * v9)
            elseif p8.type == AimAssistEnum.AimAssistType.Translational then
                local v13 = p9.subjectCFrame.Rotation + p9.startingCFrame.Position
                local v14 = v10 - p9.startingCFrame.Position
                local v15 = v8 - v13.Position - v14

                v7 += Vector3.new():Lerp(v15, v6 * v9)
            end
        end
    end

    p8.lastTargetPositions = positions

    return v7
end

function t1.adjustAimCentering(p10, p11) -- line: 126
    -- upvalues: TweenService (copy), AimAssistEnum (copy)
    local v17 = math.clamp(p10.strengthTable[AimAssistEnum.AimAssistMethod.Centering] * p11.adjustmentStrength, 0, 1)
    local subjectCFrame

    if not p11.targetResult or v17 <= 0 then
        return p11.subjectCFrame
    else
        local bestPosition = p11.targetResult.bestPosition

        subjectCFrame = p11.subjectCFrame

        if p10.type == AimAssistEnum.AimAssistType.Rotational then
            subjectCFrame = CFrame.lookAt(p11.subjectCFrame.Position, bestPosition)
        elseif p10.type == AimAssistEnum.AimAssistType.Translational then
            subjectCFrame = p11.subjectCFrame.Rotation + bestPosition
        end
    end

    if not p11.deltaTime then
        return (p11.subjectCFrame:Lerp(subjectCFrame, v17))
    end

    local v19 = 1 - v17
    local v20, v21 = TweenService:SmoothDamp(p11.subjectCFrame, subjectCFrame, p10.subjectVelocity, v19, 1e999, p11.deltaTime)

    p10.subjectVelocity = v21

    return v20
end

function t1.adjustAim(p12, p13) -- line: 171
    local instance = if p13.targetResult then p13.targetResult.instance else nil

    if instance ~= p12.lastTargetInstance then
        p12.lastTargetInstance = instance

        if p13.targetResult then
            p12.lastTargetPositions = p13.targetResult.positions
        else
            p12.lastTargetPositions = {}
        end

        p12.subjectVelocity = Vector3.new(0, 0, 0)
    end

    p13.subjectCFrame = p12:adjustAimFriction(p13)
    p13.subjectCFrame = p12:adjustAimTracking(p13)
    p13.subjectCFrame = p12:adjustAimCentering(p13)

    return p13.subjectCFrame
end

return t1
