-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local CameraUtils = require(script.Parent:WaitForChild("CameraUtils"))
local t1 = {}

t1.__index = t1

function t1.new() -- line: 14
    -- upvalues: t1 (copy)
    local self = setmetatable({}, t1)

    self.transparencyDirty = false
    self.enabled = false
    self.lastTransparency = nil
    self.descendantAddedConn = nil
    self.descendantRemovingConn = nil
    self.toolDescendantAddedConns = {}
    self.toolDescendantRemovingConns = {}
    self.cachedParts = {}

    return self
end

function t1:HasToolAncestor(p2) -- line: 30
    if p2.Parent == nil then
        return false
    end

    assert(p2.Parent, "")

    local Tool = p2.Parent:IsA("Tool")

    if not Tool then
        Tool = p2.Parent.Name == "Tool" or self:HasToolAncestor(p2.Parent)
    end

    return Tool
end

function t1:IsValidPartToModify(p4) -- line: 36
    if not p4:IsA("BasePart") and not p4:IsA("ParticleEmitter") and not p4:IsA("Beam") and not p4:IsA("Decal") then
        return false
    end

    return not self:HasToolAncestor(p4)
end

function t1:CachePartsRecursive(p6) -- line: 43
    if not p6 then
        return
    end

    if self:IsValidPartToModify(p6) then
        self.cachedParts[p6] = true
        self.transparencyDirty = true
    end

    for _, child in pairs(p6:GetChildren()) do
        self:CachePartsRecursive(child)
    end
end

function t1:TeardownTransparency() -- line: 55
    for v2, _ in pairs(self.cachedParts) do
        v2.LocalTransparencyModifier = 0
    end

    self.cachedParts = {}
    self.transparencyDirty = true
    self.lastTransparency = nil

    if self.descendantAddedConn then
        self.descendantAddedConn:disconnect()
        self.descendantAddedConn = nil
    end

    if self.descendantRemovingConn then
        self.descendantRemovingConn:disconnect()
        self.descendantRemovingConn = nil
    end

    for v3, v4 in pairs(self.toolDescendantAddedConns) do
        v4:Disconnect()
        self.toolDescendantAddedConns[v3] = nil
    end

    for v5, v6 in pairs(self.toolDescendantRemovingConns) do
        v6:Disconnect()
        self.toolDescendantRemovingConns[v5] = nil
    end
end

function t1:SetupTransparency(p9) -- line: 81
    self:TeardownTransparency()

    if self.descendantAddedConn then
        self.descendantAddedConn:disconnect()
    end

    self.descendantAddedConn = p9.DescendantAdded:Connect(function(p10) -- line: 85
        -- upvalues: self (copy), p9 (copy)
        if not p10:IsA("Tool") and p10.Name ~= "Tool" then
            if self:IsValidPartToModify(p10) then
                self.cachedParts[p10] = true
                self.transparencyDirty = true
            end
        else
            if self.toolDescendantAddedConns[p10] then
                self.toolDescendantAddedConns[p10]:Disconnect()
            end

            self.toolDescendantAddedConns[p10] = p10.DescendantAdded:Connect(function(p11) -- line: 89
                -- upvalues: self (copy)
                self.cachedParts[p11] = nil

                if p11:IsA("BasePart") or p11:IsA("Decal") then
                    p11.LocalTransparencyModifier = 0
                end
            end)

            if self.toolDescendantRemovingConns[p10] then
                self.toolDescendantRemovingConns[p10]:disconnect()
            end

            self.toolDescendantRemovingConns[p10] = p10.DescendantRemoving:Connect(function(p12) -- line: 97
                -- upvalues: self (copy), p9 (copy)
                wait()

                if p9 and p12 and p12:IsDescendantOf(p9) and self:IsValidPartToModify(p12) then
                    self.cachedParts[p12] = true
                    self.transparencyDirty = true
                end
            end)
        end
    end)

    if self.descendantRemovingConn then
        self.descendantRemovingConn:disconnect()
    end

    self.descendantRemovingConn = p9.DescendantRemoving:connect(function(p13) -- line: 112
        -- upvalues: self (copy)
        if self.cachedParts[p13] then
            self.cachedParts[p13] = nil
            p13.LocalTransparencyModifier = 0
        end
    end)
    self:CachePartsRecursive(p9)
end

function t1:Enable(p15) -- line: 123
    if self.enabled ~= p15 then
        self.enabled = p15
    end
end

function t1.SetSubject(p16, p17) -- line: 129
    local Parent

    if p17 then
        if p17:IsA("Humanoid") then
            Parent = p17.Parent
        end

        if p17:IsA("VehicleSeat") and p17.Occupant then
            Parent = p17.Occupant.Parent
        end
    end

    if Parent then
        p16:SetupTransparency(Parent)
    else
        p16:TeardownTransparency()
    end
end

function t1:Update(p19) -- line: 144
    -- upvalues: CameraUtils (copy)
    local CurrentCamera = workspace.CurrentCamera

    if not (CurrentCamera and self.enabled) then
        return
    end

    local magnitude = (CurrentCamera.Focus.p - CurrentCamera.CoordinateFrame.p).magnitude
    local v7 = magnitude < 2 and 1 - (magnitude - 0.5) / 1.5 or 0

    if v7 < 0.5 then
        v7 = 0
    end

    if self.lastTransparency and v7 < 1 and self.lastTransparency < 0.95 then
        local v8 = v7 - self.lastTransparency
        local v9 = 100 * p19
        local v11 = math.clamp(v8, -v9, v9)

        v7 = self.lastTransparency + v11
    else
        self.transparencyDirty = true
    end

    local v13 = math.clamp(CameraUtils.Round(v7, 2), 0, 1)

    if self.transparencyDirty or self.lastTransparency ~= v13 then
        for v14, _ in pairs(self.cachedParts) do
            v14.LocalTransparencyModifier = v13
        end

        self.transparencyDirty = false
        self.lastTransparency = v13
    end
end

return t1
