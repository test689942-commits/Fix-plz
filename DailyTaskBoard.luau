-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local t1 = {}
local PlayerGui = game:GetService("Players").LocalPlayer.PlayerGui
local DataMgr, NetMgr, EventMgr = _G.DataMgr, _G.NetMgr, _G.EventMgr
local v1 = _G.New("Utility.Tool")()
local v2

local function GetTask(p1) -- line: 10
    -- upvalues: DataMgr (copy), NetMgr (copy), EventMgr (copy), v2 (ref)
    local v3 = tostring(p1)

    if v2 == nil then
        v2 = DataMgr:GetPlayerCacheData("DailyTaskReward") or {
            task = {}
        }
        EventMgr:AddEvent("GetRewardResult", function(p2, p3, _, p5, p6) -- line: 14
            -- upvalues: v2 (ref)
            if p2 ~= "DailyTaskReward" or not p3 then
                return
            end

            local v4 = v2.task[p5][p6]

            v4[2] = true

            if v4[3] then
                v4[3]:SetAttribute("IfFinish", true)
            end

            if v4[4] then
                v4[4].Finish.Visible = true
            end
        end)
    end

    if v2.task[v3] == nil then
        v2.task[v3] = NetMgr:InvokeServer("GetDailyTask", v3)
    end

    return v2.task[v3]
end

function t1.new(_, p8) -- line: 33
    -- upvalues: PlayerGui (copy), DataMgr (copy), v1 (copy), GetTask (copy)
    local Value = p8.Id.Value

    for v5, v6 in (GetTask(Value)) do
        DataMgr:GetConfig("EntityData", v6[1])

        local v7 = p8:FindFirstChild(v5)
        local clone = script.SurfaceGui:Clone()

        clone.Parent = PlayerGui
        clone.Adornee = v7
        clone.Finish.Visible = v6[2]

        local ItemModel = v1:GetItemModel({
            id = v6[1]
        }, nil, true)

        ItemModel.Parent = clone.ViewportFrame
        ItemModel:PivotTo(CFrame.new(0, 0.2, -5) * CFrame.Angles(0.20943951023931956, -0.5235987755982988, -0.12217304763960307))

        local ProximityPrompt = Instance.new("ProximityPrompt")

        ProximityPrompt.Parent = v7
        ProximityPrompt.ActionText = "Submit"
        ProximityPrompt.ObjectText = "Quests"
        ProximityPrompt.RequiresLineOfSight = false
        ProximityPrompt.Style = Enum.ProximityPromptStyle.Custom
        ProximityPrompt:SetAttribute("TouchType", "Npc")
        ProximityPrompt:SetAttribute("DialogueType", "DailyTask")
        ProximityPrompt:SetAttribute("taskId", v6[1])
        ProximityPrompt:SetAttribute("IfFinish", v6[2])
        ProximityPrompt:SetAttribute("PoolId", Value)
        ProximityPrompt:SetAttribute("PoolIndex", v5)
        v6[3] = ProximityPrompt
        v6[4] = clone
    end
end

return t1
