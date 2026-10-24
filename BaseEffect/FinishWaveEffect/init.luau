-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local EventMgr, _, New = _G.EventMgr, _G.UIManager, _G.New
local CarEnd, v1, v2

return {
    Show = function(_, p2, _) -- Show | line: 9
        -- upvalues: EventMgr (copy), New (copy), CarEnd (ref), v1 (ref), v2 (ref)
        if CarEnd == nil then
            CarEnd = script.CarEnd

            local CarEnd2 = CarEnd

            CarEnd2.Parent = workspace
            v1 = New("Utility.MoonanimatorTool")(script:FindFirstChild("Animation"))
            v1.loop = false
            v1.complete:Add(function() -- line: 15
                -- upvalues: v2 (ref)
                v2()
            end)
        end

        EventMgr:Triger("HideUI", true)
        v2 = p2

        local CarEnd2 = CarEnd

        CarEnd2.Parent = workspace
        workspace.CurrentCamera.CameraType = Enum.CameraType.Scriptable
        v1:Play()
    end,
    Hide = function(_) -- Hide | line: 27
    end
}
