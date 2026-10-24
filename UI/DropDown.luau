-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local t1 = {}
local New = _G.New

local function AddSelection(p1, p2, p3) -- line: 4
    local clone = p1.item:Clone()

    clone.Visible = true
    clone:FindFirstChildWhichIsA("TextLabel").Text = p3
    clone.Parent = p1.list
    clone.MouseButton1Click:Connect(function() -- line: 9
        -- upvalues: p1 (copy), p2 (copy)
        p1:Hide()
        p1:Select(p2)
    end)

    return clone
end

function t1.new(p4, p5, p6, p7) -- line: 16
    -- upvalues: New (copy)
    p4.button = p5
    p4.list = p6
    p4.item = p7
    p4.isShow = false
    p4.selectList = {}
    p4.index = 1
    p4.onValueChange = New("CS.Action")()
    p5.MouseButton1Click:Connect(function() -- line: 24
        -- upvalues: p4 (copy)
        if p4.isShow then
            p4:Hide()
        else
            p4:Show()
        end
    end)
    p7.Visible = false
    p4:Hide()
end

function t1.Select(p8, p9) -- line: 35
    if p8.index ~= p9 then
        p8.index = p9
        p8.onValueChange(p9)
    end
end

function t1.AddSelection(p10, p11) -- line: 43
    if type(p11) == "string" then
        table.insert(p10.selectList, p11)
    elseif type(p11) == "table" then
        for _, v1 in p11 do
            table.insert(p10.selectList, v1)
        end
    end
end

function t1.Show(p12) -- line: 53
    -- upvalues: AddSelection (copy)
    p12.isShow = true
    p12.list.Visible = true
    p12.frCache = {}

    for v2, v3 in p12.selectList do
        table.insert(p12.frCache, (AddSelection(p12, v2, v3)))
    end
end

function t1.Hide(p13) -- line: 62
    p13.isShow = false
    p13.list.Visible = false

    if p13.frCache then
        for _, v5 in p13.frCache do
            v5:Destroy()
        end
    end
end

return t1
