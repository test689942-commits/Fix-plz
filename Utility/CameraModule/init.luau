-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local RunService = game:GetService("RunService")
local PhysicsModule = require(script.PhysicsModule)
local t1 = {}
local t2 = {}

local function update(p1, p2) -- line: 7
    if p1.current.CameraType == Enum.CameraType.Scriptable then
        return
    end

    local v1 = p2 * 100
    local v2 = p1.recoil.x.p()
    local v3 = p1.recoil.y.p()
    local v4 = p1.recoil.z.p()
    local v5 = v2 * v1
    local v6 = v3 * v1

    p1.current.CFrame = p1.current.CFrame * CFrame.Angles(v5, v6, v4)
end

function t1.new(p3, p4) -- line: 17
    -- upvalues: PhysicsModule (copy), t2 (copy)
    p3.current = workspace.CurrentCamera
    p3.recoil = {}
    p3.recoil.x = PhysicsModule.spring.new({
        d = p4.RecoilDamper,
        s = p4.RecoilSpeed
    })
    p3.recoil.y = PhysicsModule.spring.new({
        d = p4.RecoilDamper,
        s = p4.RecoilSpeed
    })
    p3.recoil.z = PhysicsModule.spring.new({
        d = p4.RecoilDamper,
        s = p4.RecoilSpeed
    })
    table.insert(t2, p3)
end

function t1.accelerate(p5, p6, p7, p8) -- line: 26
    p5.recoil.x.impulse(p6)
    p5.recoil.y.impulse(p7)
    p5.recoil.z.impulse(p8)
end

function t1.accelerateXY(p9, p10, p11) -- line: 32
    p9.recoil.x.impulse(p10)
    p9.recoil.y.impulse(p11)
end

function t1.disconnect(p12) -- line: 37
    -- upvalues: t2 (copy)
    for v7, v8 in pairs(t2) do
        if v8 == p12 then
            table.remove(t2, v7)

            return
        end
    end
end

RunService:BindToRenderStep("RecoilCam", 2000, function(p13) -- line: 48
    -- upvalues: t2 (copy), update (copy)
    for _, v9 in pairs(t2) do
        update(v9, p13)
    end
end)

return t1
