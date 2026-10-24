-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local t1 = {
    objectName = "TopbarPlusReference"
}

function t1.addToReplicatedStorage() -- line: 10
    -- upvalues: ReplicatedStorage (copy), t1 (copy)
    if ReplicatedStorage:FindFirstChild(t1.objectName) then
        return false
    end

    local ObjectValue = Instance.new("ObjectValue")

    ObjectValue.Name = t1.objectName
    ObjectValue.Value = script.Parent
    ObjectValue.Parent = ReplicatedStorage

    return ObjectValue
end

function t1.getObject() -- line: 22
    -- upvalues: ReplicatedStorage (copy), t1 (copy)
    return ReplicatedStorage:FindFirstChild(t1.objectName) or false
end

return t1
