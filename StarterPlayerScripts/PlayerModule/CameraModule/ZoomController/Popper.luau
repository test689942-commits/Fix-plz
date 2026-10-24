-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local Players = game:GetService("Players")
local CurrentCamera = game.Workspace.CurrentCamera
local min, tan, rad, new = math.min, math.tan, math.rad, Ray.new

local function getTotalTransparency(p1) -- line: 17
    return 1 - (1 - p1.Transparency) * (1 - p1.LocalTransparencyModifier)
end

local function eraseFromEnd(p2, p3) -- line: 21
    for i = #p2, p3 + 1, -1 do
        p2[i] = nil
    end
end

local v1, v2

local function updateProjection() -- line: 28
    -- upvalues: CurrentCamera (copy), tan (copy), rad (copy), v1 (ref), v2 (ref)
    local v3 = rad(CurrentCamera.FieldOfView)
    local ViewportSize = CurrentCamera.ViewportSize
    local v4 = ViewportSize.X / ViewportSize.Y

    v2 = tan(v3 / 2) * 2
    v1 = v4 * v2
end

CurrentCamera:GetPropertyChangedSignal("FieldOfView"):Connect(updateProjection)
CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(updateProjection)

local v6 = rad(CurrentCamera.FieldOfView)
local ViewportSize = CurrentCamera.ViewportSize
local v7 = ViewportSize.X / ViewportSize.Y

v2 = tan(v6 / 2) * 2
v1 = v7 * v2

local NearPlaneZ = CurrentCamera.NearPlaneZ

CurrentCamera:GetPropertyChangedSignal("NearPlaneZ"):Connect(function() -- line: 43
    -- upvalues: CurrentCamera (copy), NearPlaneZ (ref)
    NearPlaneZ = CurrentCamera.NearPlaneZ
end)

local t1 = {}
local t2 = {}

local function refreshIgnoreList() -- line: 51
    -- upvalues: t1 (ref), t2 (copy)
    t1 = {}

    local n1 = 1

    for _, v8 in pairs(t2) do
        local t3 = t1

        t3[n1] = v8
        n1 += 1
    end
end

local function playerAdded(p4) -- line: 60
    -- upvalues: t1 (ref), t2 (copy)
    local function characterAdded(p5) -- line: 61
        -- upvalues: p4 (copy), t1 (ref), t2 (copy)
        t2[p4] = p5
        t1 = {}

        local n2 = 1

        for _, v9 in pairs(t2) do
            t1[n2] = v9
            n2 += 1
        end
    end

    local function characterRemoving() -- line: 65
        -- upvalues: p4 (copy), t1 (ref), t2 (copy)
        t2[p4] = nil
        t1 = {}

        local n3 = 1

        for _, v10 in pairs(t2) do
            t1[n3] = v10
            n3 += 1
        end
    end

    p4.CharacterAdded:Connect(characterAdded)
    p4.CharacterRemoving:Connect(characterRemoving)

    if p4.Character then
        t2[p4] = p4.Character
        t1 = {}

        local n4 = 1

        for _, v11 in pairs(t2) do
            local t6 = t1

            t6[n4] = v11
            n4 += 1
        end
    end
end

local function playerRemoving(p6) -- line: 77
    -- upvalues: t1 (ref), t2 (copy)
    t2[p6] = nil
    t1 = {}

    local n5 = 1

    for _, v12 in pairs(t2) do
        t1[n5] = v12
        n5 += 1
    end
end

Players.PlayerAdded:Connect(playerAdded)
Players.PlayerRemoving:Connect(playerRemoving)

for _, player in ipairs(Players:GetPlayers()) do
    playerAdded(player)
end

t1 = {}

local n6 = 1

for _, v13 in pairs(t2) do
    local t8 = t1

    t8[n6] = v13
    n6 += 1
end

local v14 = nil
local v15

CurrentCamera:GetPropertyChangedSignal("CameraSubject"):Connect(function() -- line: 111
    -- upvalues: CurrentCamera (copy), v15 (ref)
    local CameraSubject = CurrentCamera.CameraSubject

    v15 = if CameraSubject:IsA("Humanoid") then CameraSubject.RootPart elseif CameraSubject:IsA("BasePart") then CameraSubject else nil
end)

local t9 = {
    Vector2.new(0.4, 0),
    Vector2.new(-0.4, 0),
    Vector2.new(0, -0.4),
    Vector2.new(0, 0.4),
    Vector2.new(0, 0.2)
}

local function getCollisionPoint(p7, p8) -- line: 150
    -- upvalues: new (copy), t1 (ref)
    local v16 = #t1
    local v17

    while true do
        local v18

        v18, v17 = workspace:FindPartOnRayWithIgnoreList(new(p7, p8), t1, false, true)

        if v18 then
            if not v18.CanCollide then
                local t10 = t1

                t10[#t1 + 1] = v18
                continue
            end

            local t11 = t1

            for i = #t11, v16 + 1, -1 do
                t11[i] = nil
            end

            break
        end

        local t12 = t1

        for i = #t12, v16 + 1, -1 do
            t12[i] = nil
        end

        return p7 + p8, false
    end

    return v17, true
end

local function queryPoint(p9, p10, p11, p12) -- line: 172
    -- upvalues: new (copy), NearPlaneZ (ref), t1 (ref), v14 (ref)
    debug.profilebegin("queryPoint")

    local v19 = #t1
    local v20 = p11 + NearPlaneZ
    local v21 = p9 + p10 * v20
    local n7 = 1e999
    local n8 = 1e999
    local v22 = p9
    local n9 = 0
    local Magnitude, v23

    while true do
        local v24, v25 = workspace:FindPartOnRayWithIgnoreList(new(v22, v21 - v22), t1, false, true)

        n9 += 1
        Magnitude = n8
        v23 = n7

        if v24 then
            local v26 = n9 >= 64
            local CanCollide

            if 1 - (1 - v24.Transparency) * (1 - v24.LocalTransparencyModifier) < 0.25 then
                CanCollide = v24.CanCollide

                if CanCollide then
                    local v27 = v14

                    CanCollide = v27 ~= (v24:GetRootPart() or v24) and not v24:IsA("TrussPart")
                end
            else
                CanCollide = false
            end

            if CanCollide or v26 then
                local t13 = {
                    v24
                }
                local v28 = workspace:FindPartOnRayWithWhitelist(new(v21, v25 - v21), t13, true)

                Magnitude = (v25 - p9).Magnitude

                local v29, v30

                if not v28 or v26 then
                    v30 = true
                else
                    v29 = if p12 then workspace:FindPartOnRayWithWhitelist(new(p12, v21 - p12), t13, true) or workspace:FindPartOnRayWithWhitelist(new(v21, p12 - v21), t13, true) else false
                    v30 = false
                end

                if not v30 and not v29 then
                    if v20 < n7 then
                        v23 = Magnitude
                    end

                    Magnitude = n8
                end
            end

            local t14 = t1

            t14[#t1 + 1] = v24
            v22 = v25 - p10 * 0.001
        end

        if not (Magnitude < 1e999) and v24 then
            n7 = v23
            n8 = Magnitude
            continue
        end

        break
    end

    local t15 = t1

    for i = #t15, v19 + 1, -1 do
        t15[i] = nil
    end

    debug.profileend()

    return v23 - NearPlaneZ, Magnitude - NearPlaneZ
end

local function queryViewport(p13, p14) -- line: 232
    -- upvalues: CurrentCamera (copy), v1 (ref), v2 (ref), NearPlaneZ (ref), queryPoint (copy)
    debug.profilebegin("queryViewport")

    local p, rightVector, upVector = p13.p, p13.rightVector, p13.upVector
    local v31 = -p13.lookVector
    local ViewportSize = CurrentCamera.ViewportSize
    local n10 = 1e999
    local n11 = 1e999

    for i = 0, 1 do
        local v32 = rightVector * ((i - 0.5) * v1)

        for j = 0, 1 do
            local v33 = upVector * ((j - 0.5) * v2)
            local NearPlaneZ2 = NearPlaneZ
            local v35, v36 = queryPoint(p + NearPlaneZ2 * (v32 + v33), v31, p14, CurrentCamera:ViewportPointToRay(ViewportSize.x * i, ViewportSize.y * j).Origin)

            if v36 < n10 then
                n10 = v36
            end

            if v35 < n11 then
                n11 = v35
            end
        end
    end

    debug.profileend()

    return n11, n10
end

local function testPromotion(p15, p16, p17) -- line: 273
    -- upvalues: min (copy), t9 (copy), getCollisionPoint (copy), queryPoint (copy)
    debug.profilebegin("testPromotion")

    local p, rightVector, upVector = p15.p, p15.rightVector, p15.upVector
    local v37 = -p15.lookVector

    debug.profilebegin("extrapolate")

    local Magnitude = (getCollisionPoint(p, p17.posVelocity * 1.25) - p).Magnitude
    local magnitude = p17.posVelocity.magnitude

    for i = 0, min(1.25, p17.rotVelocity.magnitude + Magnitude / magnitude), 0.0625 do
        local v39 = p17.extrapolate(i)

        if p16 <= queryPoint(v39.p, -v39.lookVector, p16) then
            return false
        end
    end

    debug.profileend()
    debug.profilebegin("testOffsets")

    for _, v40 in ipairs(t9) do
        local v41 = getCollisionPoint(p, rightVector * v40.x + upVector * v40.y)

        if queryPoint(v41, (p + v37 * p16 - v41).Unit, p16) == 1e999 then
            return false
        end
    end

    debug.profileend()
    debug.profileend()

    return true
end

return function(p18, p19, p20) -- Popper | line: 322
    -- upvalues: v14 (ref), v15 (ref), queryViewport (copy), testPromotion (copy)
    debug.profilebegin("popper")
    v14 = v15 and v15:GetRootPart() or v15

    local v42, v43 = queryViewport(p18, p19)

    if not (v43 < p19) then
        v43 = p19
    end

    if not (v42 < v43 and testPromotion(p18, p19, p20)) then
        v42 = v43
    end

    v14 = nil
    debug.profileend()

    return v42
end
