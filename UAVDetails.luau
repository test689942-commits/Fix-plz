-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local HttpService = game:GetService("HttpService")
local Type, New = _G.Type, _G.New
local t1 = {
    uid = "123",
    id = 1001,
    exp = 0,
    lock = false,
    star = 0,
    mod = Type("CS.List")("ItemDetails")
}

function t1.new(p1, p2, p3) -- line: 13
    -- upvalues: t1 (copy), HttpService (copy), New (copy)
    p1.uid = HttpService:GenerateGUID(false)
    p1.id = p2
    p1.star = p3
    p1.mod = New(t1.mod)()
end

function t1.AutoChange(p4, p5, p6, p7) -- line: 20
    local v1 = p5 == "mod"
    local v2

    if v1 then
        if p7 ~= nil then
            p4.mod.Type:Instance(p7)

            while p4.mod.count < p6 do
                p4.mod:Add()
            end

            p4.mod[p6] = p7

            return
        end

        if p6 < p4.mod.count then
            p4.mod[p6] = p4.mod[p4.mod.count]
            p4.mod:RemoveAt(p4.mod.count)

            return
        end

        v2 = p6 == p4.mod.count
    else
        p4[p5] = p6
    end

    if (not v1 or v2) and v1 then
        p4.mod:RemoveAt(p6)
    end
end

return t1
