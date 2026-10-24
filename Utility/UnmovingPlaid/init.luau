-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local RunService = game:GetService("RunService")
local CollectionService = game:GetService("CollectionService")
local AssetService = game:GetService("AssetService")
local Workspace = game:GetService("Workspace")

require(script.Definitions)

local Core = require(script.Core)
local t1 = {
    Texture = "",
    Scale = 4,
    Transparency = 0,
    Enabled = true,
    Resolution = 256,
    Color = Color3.new(1, 1, 1)
}
local t2 = {}
local connection, connection2
local v1 = false

local function ensureDefaults(p1) -- line: 23
    -- upvalues: t1 (copy)
    for v2, v3 in pairs(t1) do
        if p1:GetAttribute(v2) == nil then
            p1:SetAttribute(v2, v3)
        end
    end
end

local function readConfig(p2) -- line: 29
    -- upvalues: t1 (copy)
    local t3 = {}

    for v4, v5 in pairs(t1) do
        local Attribute = p2:GetAttribute(v4)

        if Attribute ~= nil then
            t3[v4] = Attribute
        else
            t3[v4] = v5
        end
    end

    return t3
end

local v6

local function onTagged(p3) -- line: 40
    -- upvalues: AssetService (copy), Core (copy), t2 (copy), ensureDefaults (copy), readConfig (copy), v6 (ref)
    if p3:IsA("BasePart") and not t2[p3] then
        ensureDefaults(p3)

        local v8 = math.clamp(readConfig(p3).Resolution or 256, 16, 1024)
        local t4 = {
            proxy = nil,
            editableMesh = nil,
            canvas = nil,
            sourceImage = nil,
            currentTextureId = "",
            loading = false,
            ready = false,
            uvData = nil,
            normalIds = nil,
            part = p3,
            connections = {}
        }

        t2[p3] = t4
        task.spawn(function() -- line: 54
            -- upvalues: p3 (copy), v8 (copy), t4 (copy), AssetService (copy), Core (copy), t2 (copy), readConfig (copy), v6 (ref)
            if t2[p3] then
                local result

                if p3:IsA("MeshPart") then
                    local function v9() -- line: 59
                        -- upvalues: p3 (copy), AssetService (copy)
                        return AssetService:CreateEditableMeshAsync(p3.MeshContent)
                    end

                    local ok

                    ok, result = pcall(v9)

                    if not ok or not result then
                        warn("[UnmovingPlaid] Mesh clone failed: " .. tostring(result))

                        return
                    end
                else
                    result = Core.createBoxMesh()
                end

                local function v10() -- line: 71
                    -- upvalues: result (ref), AssetService (copy)
                    return AssetService:CreateMeshPartAsync(Content.fromObject(result))
                end

                local ok, result2 = pcall(v10)

                if not ok or not result2 then
                    warn("[UnmovingPlaid] Proxy failed: " .. tostring(result2))
                    result:Destroy()
                elseif t2[p3] then
                    result2.CFrame = p3.CFrame
                    result2.Size = p3.Size
                    result2.CanCollide = false
                    result2.CastShadow = false
                    result2.Name = p3.Name .. "_PlaidProxy"
                    result2.Parent = p3
                    result2.Anchored = p3.Anchored
                    result2.Massless = true

                    local WeldConstraint = Instance.new("WeldConstraint")

                    WeldConstraint.Part0 = p3
                    WeldConstraint.Part1 = result2
                    WeldConstraint.Parent = result2

                    local Enabled = readConfig(p3).Enabled

                    p3.Transparency = Enabled and 1 or 0

                    if not Enabled then
                        result2.Transparency = 1
                    end

                    t4.proxy = result2
                    t4.editableMesh = result

                    local v11, v12 = Core.cacheUVData(result)

                    t4.uvData = v11
                    t4.normalIds = v12
                    t4.canvas = AssetService:CreateEditableImage({
                        Size = Vector2.new(v8, v8)
                    })
                    result2.TextureContent = Content.fromObject(t4.canvas)

                    local function refreshSource() -- line: 110
                        -- upvalues: p3 (copy), t4 (copy), Core (copy), t2 (copy), readConfig (copy)
                        if t4.canvas then
                            local v13 = readConfig(p3)
                            local Texture = v13.Texture

                            if Texture ~= "" and Texture ~= t4.currentTextureId then
                                if t4.sourceImage then
                                    t4.sourceImage:Destroy()
                                    t4.sourceImage = nil
                                end

                                t4.currentTextureId = Texture
                                t4.ready = false
                                t4.loading = true
                                task.spawn(function() -- line: 118
                                    -- upvalues: Texture (copy), p3 (copy), t4 (copy), Core (copy), t2 (copy)
                                    local v14 = Core.loadSourceImage(Texture)

                                    if not t2[p3] or t4.currentTextureId ~= Texture then
                                        if v14 then
                                            v14:Destroy()
                                        end
                                    else
                                        t4.sourceImage = v14
                                        t4.loading = false

                                        if v14 and t4.canvas then
                                            Core.blitToCanvas(t4.canvas, v14)

                                            local v15 = p3:GetAttribute("Color") or Color3.new(1, 1, 1)

                                            if typeof(v15) == "Color3" and v15 ~= Color3.new(1, 1, 1) then
                                                Core.tintCanvas(t4.canvas, v15)
                                            end

                                            t4.ready = true
                                        end
                                    end
                                end)
                            elseif Texture ~= "" and t4.sourceImage and t4.canvas then
                                Core.blitToCanvas(t4.canvas, t4.sourceImage)

                                local Color = v13.Color

                                if typeof(Color) == "Color3" and Color ~= Color3.new(1, 1, 1) then
                                    Core.tintCanvas(t4.canvas, Color)
                                end
                            end
                        end
                    end

                    refreshSource()
                    table.insert(t4.connections, p3.AttributeChanged:Connect(function(p4) -- line: 139
                        -- upvalues: refreshSource (copy), p3 (copy), t4 (copy), readConfig (copy)
                        if p4 == "Texture" or p4 == "Color" then
                            refreshSource()
                        end

                        if p4 == "Enabled" then
                            if not readConfig(p3).Enabled then
                                if t4.proxy then
                                    t4.proxy.Transparency = 1
                                end

                                p3.Transparency = 0
                            else
                                p3.Transparency = 1
                            end
                        end
                    end))
                    table.insert(t4.connections, p3:GetPropertyChangedSignal("Size"):Connect(function() -- line: 151
                        -- upvalues: p3 (copy), t4 (copy)
                        if t4.proxy and t4.proxy.Parent then
                            t4.proxy.Size = p3.Size
                        end
                    end))
                    table.insert(t4.connections, p3.Destroying:Connect(function() -- line: 154
                        -- upvalues: p3 (copy), v6 (ref)
                        v6(p3)
                    end))
                else
                    result:Destroy()
                    result2:Destroy()
                end
            end
        end)
    end
end

v6 = function(p5) -- line: 158
    -- upvalues: t2 (copy)
    local v19 = t2[p5]

    if not v19 then
        return
    end

    t2[p5] = nil

    for _, v20 in pairs(v19.connections) do
        v20:Disconnect()
    end

    if v19.canvas then
        v19.canvas:Destroy()
    end

    if v19.sourceImage then
        v19.sourceImage:Destroy()
    end

    if v19.editableMesh then
        v19.editableMesh:Destroy()
    end

    if v19.proxy then
        if v19.part and v19.part.Parent then
            v19.part.Transparency = 0
        end

        v19.proxy:Destroy()
    end
end

local function renderFrame() -- line: 172
    -- upvalues: Workspace (copy), t2 (copy), readConfig (copy)
    local CurrentCamera = Workspace.CurrentCamera

    if CurrentCamera then
        local CFrame = CurrentCamera.CFrame

        for _, v21 in pairs(t2) do
            if not v21.loading and v21.ready then
                local v22 = readConfig(v21.part)

                if v22.Enabled then
                    local editableMesh = v21.editableMesh

                    if editableMesh and v21.proxy then
                        local uvData = v21.uvData

                        if uvData then
                            local v23 = CFrame:Inverse() * v21.proxy.CFrame
                            local v24 = 1 / math.max(0.1, v22.Scale)

                            for _, v25 in pairs(uvData) do
                                local v26 = v23:PointToWorldSpace(v25.pos)

                                editableMesh:SetUV(v25.uvId, Vector2.new(v26.X * v24, -v26.Y * v24))
                            end

                            local v27 = math.clamp(v22.Transparency, 0, 1)

                            v21.proxy.Transparency = v27
                            v21.proxy.Color = v22.Color
                        end
                    end
                end
            end
        end
    end
end

local t5 = {}

function t5.new(_) -- line: 206
    -- upvalues: t5 (copy)
    return t5
end

function t5.Start(_) -- line: 210
    -- upvalues: RunService (copy), CollectionService (copy), connection (ref), connection2 (ref), v1 (ref), v6 (ref), onTagged (copy), renderFrame (copy)
    if v1 then
        return
    end

    v1 = true

    for _, v28 in pairs(CollectionService:GetTagged("UnmovingPlaid")) do
        task.spawn(onTagged, v28)
    end

    connection = CollectionService:GetInstanceAddedSignal("UnmovingPlaid"):Connect(onTagged)
    connection2 = CollectionService:GetInstanceRemovedSignal("UnmovingPlaid"):Connect(function(p8) -- line: 215
        -- upvalues: v6 (ref)
        if p8:IsA("BasePart") then
            v6(p8)
        end
    end)
    RunService:BindToRenderStep("UnmovingPlaidRender", Enum.RenderPriority.Camera.Value + 1, renderFrame)
end

function t5.Stop(_) -- line: 221
    -- upvalues: RunService (copy), t2 (copy), connection (ref), connection2 (ref), v1 (ref), v6 (ref)
    if not v1 then
        return
    end

    v1 = false
    RunService:UnbindFromRenderStep("UnmovingPlaidRender")

    if connection then
        connection:Disconnect()
        connection = nil
    end

    if connection2 then
        connection2:Disconnect()
        connection2 = nil
    end

    for v30, _ in pairs(t2) do
        v6(v30)
    end
end

return t5
