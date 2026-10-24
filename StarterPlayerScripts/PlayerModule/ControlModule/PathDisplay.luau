-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local t1 = {
    spacing = 8,
    image = "rbxasset://textures/Cursors/Gamepad/Pointer.png",
    imageSize = Vector2.new(2, 2)
}
local v1 = {}
local t2 = {}
local Model = Instance.new("Model")

Model.Name = "PathDisplayPoints"

local Part = Instance.new("Part")

Part.Anchored = true
Part.CanCollide = false
Part.Transparency = 1
Part.Name = "PathDisplayAdornee"
Part.CFrame = CFrame.new(0, 0, 0)
Part.Parent = Model

local t3 = {}
local n1 = 30

for i = 1, 30 do
    local ImageHandleAdornment = Instance.new("ImageHandleAdornment")

    ImageHandleAdornment.Archivable = false
    ImageHandleAdornment.Adornee = Part
    ImageHandleAdornment.Image = t1.image
    ImageHandleAdornment.Size = t1.imageSize
    t3[i] = ImageHandleAdornment
end

local function retrieveFromPool() -- line: 34
    -- upvalues: t3 (copy), n1 (ref)
    local v2 = t3[1]

    if not v2 then
        return nil
    end

    local v3 = n1

    t3[1] = t3[n1]
    t3[v3] = nil
    n1 -= 1

    return v2
end

local function returnToPool(p1) -- line: 45
    -- upvalues: t3 (copy), n1 (ref)
    n1 += 1
    t3[n1] = p1
end

local function renderPoint(p2, _) -- line: 50
    -- upvalues: Model (copy), t3 (copy), n1 (ref)
    if n1 == 0 then
        return nil
    end

    local v4 = Ray.new(p2 + Vector3.new(0, 2, 0), (Vector3.new(0, -8, 0)))
    local v5, v6, v7 = workspace:FindPartOnRayWithIgnoreList(v4, {
        game.Players.LocalPlayer.Character,
        workspace.CurrentCamera
    })

    if not v5 then
        return nil
    end

    local v8 = CFrame.new(v6, v6 + v7)
    local v9 = t3[1]

    if v9 then
        local v10 = n1

        t3[1] = t3[n1]
        t3[v10] = nil
        n1 -= 1
    else
        v9 = nil
    end

    v9.CFrame = v8
    v9.Parent = Model

    return v9
end

function t1.setCurrentPoints(p4) -- line: 69
    -- upvalues: v1 (ref)
    if typeof(p4) == "table" then
        v1 = p4
    else
        v1 = {}
    end
end

function t1.clearRenderedPath() -- line: 77
    -- upvalues: t2 (ref), Model (copy), t3 (copy), n1 (ref)
    for _, v11 in ipairs(t2) do
        v11.Parent = nil
        n1 += 1
        t3[n1] = v11
    end

    t2 = {}
    Model.Parent = nil
end

function t1.renderPath() -- line: 86
    -- upvalues: t1 (copy), v1 (ref), t2 (ref), Model (copy), renderPoint (copy)
    t1.clearRenderedPath()

    if not v1 or #v1 == 0 then
        return
    end

    local v13 = #v1
    local v14 = v1[v13]

    t2[1] = renderPoint(v14, true)

    if t2[1] then
        local n2 = 0

        while true do
            local v15 = v1[v13]
            local v16 = v1[v13 - 1]

            if v13 < 2 then
                break
            end

            local v18 = v16 - v15
            local magnitude = v18.magnitude

            if magnitude < n2 then
                n2 -= magnitude
                v13 -= 1
            else
                local v20 = renderPoint(v15 + v18.unit * n2, false)

                if v20 then
                    t2[#t2 + 1] = v20
                end

                n2 += t1.spacing
            end
        end

        Model.Parent = workspace.CurrentCamera
    end
end

return t1
