-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local New = _G.New
local t1 = {}

t1.last = nil
t1.ifSort = false

local t2 = {
    value = 0,
    changed = nil,
    remove = nil,
    index = 1,
    up = nil,
    down = nil,
    AutoSort = nil
}

t2.__index = t2

function t2.Updata(p1, p2) -- line: 19
    if p1.AutoSort ~= nil then
        p1.AutoSort:Updata(p1, p2)
    end
end

function t2.Destroy(p3) -- line: 25
    if p3.AutoSort ~= nil then
        p3.AutoSort:Remove(p3)
    end
end

function t1.__iter(p4) -- line: 33
    local v1
    local v2 = p4.last

    return function() -- line: 36
        -- upvalues: v1 (ref), v2 (ref)
        v1 = v2

        if v1 == nil then
            return
        end

        v2 = v1.up

        return v1.index, v1
    end
end

function t1.new(p5) -- line: 45
    -- upvalues: New (copy)
    p5.last = nil
    p5.ifSort = false
    p5.onAdd = New("CS.Action")()
    p5.onRemove = New("CS.Action")()
end

function t1.Updata(p6, p7, p8) -- line: 53
    if p7.AutoSort == nil then
        return
    end

    while p6.ifSort do
        task.wait()
    end

    p6.ifSort = true
    p7.value = p8

    local t3 = {}

    if p7.up == nil or not (p7.up.value < p7.value) then
        if p7.down ~= nil and p7.down.value > p7.value then
            local v3 = p7

            while v3.down ~= nil and v3.down.value > p7.value do
                p7.index += 1
                v3.down.index -= 1
                table.insert(t3, v3.down)
                v3 = v3.down
            end

            if p7.up then
                p7.up.down = p7.down
                p7.down.up = p7.up
            else
                p7.down.up = nil
            end

            p7.up = v3

            if v3.down then
                v3.down.up = p7
                p7.down = v3.down
            else
                p7.down = nil
                p6.last = p7
            end

            v3.down = p7
        end
    else
        local v4 = p7

        while v4.up ~= nil and v4.up.value < p7.value do
            p7.index -= 1
            v4.up.index += 1
            table.insert(t3, v4.up)
            v4 = v4.up
        end

        if p7.down then
            p7.down.up = p7.up
            p7.up.down = p7.down
        else
            p7.up.down = nil
            p6.last = p7.up
        end

        p7.down = v4

        if v4.up then
            v4.up.down = p7
            p7.up = v4.up
        else
            p7.up = nil
        end

        v4.up = p7
    end

    p7:changed()

    if #t3 ~= 0 then
        for _, v5 in ipairs(t3) do
            v5:changed()
        end
    end

    p6.ifSort = false

    return p7
end

function t1.Add(p9, p10, p11, p12) -- line: 121
    -- upvalues: New (copy), t2 (copy)
    local self = setmetatable({}, t2)

    self.value = p10
    self.changed = New("CS.Action")()

    if p11 then
        self.changed:Add(p11)
    end

    self.remove = New("CS.Action")()

    if p12 then
        self.remove:Add(p12)
    end

    self.index = 1
    self.AutoSort = p9

    if p9.last ~= nil then
        p9.last.down = self
        self.up = p9.last
        self.index = p9.last.index + 1
    end

    p9.last = self
    p9:Updata(self, p10)
    p9.onAdd(self)

    return self
end

function t1.Remove(p13, p14) -- line: 146
    if p13.last == p14 then
        if p14.up then
            p14.up.down = nil
            p13.last = p14.up
        else
            p13.last = nil
        end
    else
        if p14.up then
            p14.up.down = p14.down
        end

        if p14.down then
            p14.down.up = p14.up
        end

        local down = p14.down

        while down ~= nil do
            down.index -= 1
            down:changed()
            down = down.down
        end
    end

    p14.AutoSort = nil
    p14:remove()
    p13.onRemove(p14)
end

function t1.Clear(p15) -- line: 173
    p15.last = nil
    p15.ifSort = false
end

return t1
