-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local t1 = {}
local DataMgr, New = _G.DataMgr, _G.New

New("Utility.Tool")()

local v1 = New("UI.Tool")()
local t2 = {}

for _, child in script:GetChildren() do
    if child:IsA("ModuleScript") then
        t2[child.Name] = require(child)
    end
end

t2.Helmet = t2.Equipment
t2.Cuirass = t2.Equipment
t2.Glove = t2.Equipment
t2.Boots = t2.Equipment
t2.Accessory = t2.Equipment

function t1.new(p1, p2, p3, p4, p5) -- line: 19
    -- upvalues: DataMgr (copy), t2 (copy)
    if p2 == nil then
        return
    end

    local Config = DataMgr:GetConfig("ItemData", p2.id)

    p1.index = p3
    p1.config = Config
    p1.data = p2
    p1.type = p4
    p1.handle = t2[Config.type] or t2.Normal
    p1.panel = p5
    p1.handle.Init(p1)
end

function t1.Destroy(p6) -- line: 33
    if p6.data then
        p6.ui:Destroy()
        p6.data = nil
        p6.ui = nil
    end
end

function t1.Change(p7, p8, _) -- line: 41
    if p7.handle[p8] then
        p7.handle[p8](p7)
    end
end

function t1.AddButton(p10, p11, p12, p13) -- line: 47
    -- upvalues: v1 (copy)
    local clone = script.Button:Clone()

    clone.Parent = p10.ui.Button
    clone.TextLabel.Text = p11
    clone.Show.BackgroundColor3 = p12
    v1:SetButtonAnimation(clone).MouseButton1Click:Connect(p13)
end

return t1
