-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local _, DataMgr = _G.New, _G.DataMgr

return {
    new = function(_, p2) -- new | line: 11
        -- upvalues: TweenService (copy), RunService (copy), DataMgr (copy)
        local v2 = math.max(os.time() - p2:GetAttribute("StartTime") - 1, 0) + tick()
        local v3 = p2:GetAttribute("StayTime") or 20
        local t2 = {}

        local function LoadFish(p3) -- line: 18
            -- upvalues: v3 (copy), t2 (copy), DataMgr (copy)
            if p3:IsA("Model") then
                task.spawn(function() -- line: 22
                    -- upvalues: p3 (copy), v3 (copy), t2 (copy), DataMgr (copy)
                    while p3.PrimaryPart == nil do
                        if p3.Parent == nil then
                            return
                        end

                        task.wait()
                    end

                    local t3 = {
                        model = p3,
                        id = p3:GetAttribute("Id"),
                        mass = p3:GetAttribute("Mass")
                    }

                    t3.massMul = t3.mass ^ 0.4
                    t3.wave = math.max(math.floor(v3 / (3 * t3.massMul * 2)), 1)
                    t3.config = DataMgr:GetConfig("EntityData", t3.id)

                    if p3.Parent == nil then
                        return
                    end

                    t3.pos = p3.PrimaryPart.CFrame * CFrame.Angles(0, math.random() * 3.141592653589793, 0)
                    t3.jumpHight = 35 * (0.7 + math.random() * 0.3)
                    table.insert(t2, t3)
                end)
            end
        end

        for _, child in p2:GetChildren() do
            if child:IsA("Model") then
                task.spawn(function() -- line: 22
                    -- upvalues: v3 (copy), t2 (copy), child (copy), DataMgr (copy)
                    while child.PrimaryPart == nil do
                        if child.Parent == nil then
                            return
                        end

                        task.wait()
                    end

                    local t4 = {
                        model = child,
                        id = child:GetAttribute("Id"),
                        mass = child:GetAttribute("Mass")
                    }

                    t4.massMul = t4.mass ^ 0.4
                    t4.wave = math.max(math.floor(v3 / (3 * t4.massMul * 2)), 1)
                    t4.config = DataMgr:GetConfig("EntityData", t4.id)

                    if child.Parent == nil then
                        return
                    end

                    t4.pos = child.PrimaryPart.CFrame * CFrame.Angles(0, math.random() * 3.141592653589793, 0)
                    t4.jumpHight = 35 * (0.7 + math.random() * 0.3)
                    table.insert(t2, t4)
                end)
            end
        end

        p2.ChildAdded:Connect(function(p4) -- line: 48
            -- upvalues: v3 (copy), t2 (copy), DataMgr (copy)
            if p4:IsA("Model") then
                task.spawn(function() -- line: 22
                    -- upvalues: p4 (copy), v3 (copy), t2 (copy), DataMgr (copy)
                    while p4.PrimaryPart == nil do
                        if p4.Parent == nil then
                            return
                        end

                        task.wait()
                    end

                    local t5 = {
                        model = p4,
                        id = p4:GetAttribute("Id"),
                        mass = p4:GetAttribute("Mass")
                    }

                    t5.massMul = t5.mass ^ 0.4
                    t5.wave = math.max(math.floor(v3 / (3 * t5.massMul * 2)), 1)
                    t5.config = DataMgr:GetConfig("EntityData", t5.id)

                    if p4.Parent == nil then
                        return
                    end

                    t5.pos = p4.PrimaryPart.CFrame * CFrame.Angles(0, math.random() * 3.141592653589793, 0)
                    t5.jumpHight = 35 * (0.7 + math.random() * 0.3)
                    table.insert(t2, t5)
                end)
            end
        end)

        local connection

        connection = RunService.RenderStepped:Connect(function(p5) -- line: 52
            -- upvalues: p2 (copy), v2 (copy), t2 (copy), connection (ref), TweenService (copy)
            local v10 = p5 * 30

            if p2 == nil or p2.Parent == nil then
                connection:Disconnect()
            else
                local v11 = tick() - v2

                if not (v11 < 0) then
                    for i = #t2, 1, -1 do
                        local v12 = t2[i]
                        local v14 = math.floor(v11 / (3 * v12.massMul))

                        if v12.model ~= nil and v12.model.Parent ~= nil and v12.model.PrimaryPart ~= nil then
                            if v12.wave * 2 <= v14 then
                                v12.model:Destroy()
                                table.remove(t2, i)
                            elseif v12.model:GetAttribute("isDie") then
                                table.remove(t2, i)
                            else
                                local v15 = v11 % (3 * v12.massMul)

                                if bit32.band(v14, 1) == 0 then
                                    if v15 <= 1 * v12.massMul then
                                        local v16 = v15 / (1 * v12.massMul)

                                        v12.model.PrimaryPart.CFrame = v12.model.PrimaryPart.CFrame:Lerp(v12.pos * CFrame.Angles(0, 0, (1 - TweenService:GetValue(v16, Enum.EasingStyle.Linear, Enum.EasingDirection.In)) * 3.141592653589793 / 2) + Vector3.new(0, v12.jumpHight * TweenService:GetValue(v16, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), 0), v10)
                                    else
                                        v12.model.PrimaryPart.CFrame = v12.model.PrimaryPart.CFrame:Lerp(v12.pos + Vector3.new(0, v12.jumpHight, 0), v10)
                                    end
                                elseif v15 <= 1 * v12.massMul then
                                    local v19 = v15 / (1 * v12.massMul)

                                    v12.model.PrimaryPart.CFrame = v12.model.PrimaryPart.CFrame:Lerp(v12.pos * CFrame.Angles(0, 0, -TweenService:GetValue(v19, Enum.EasingStyle.Quad, Enum.EasingDirection.Out) * 3.141592653589793 / 2) + Vector3.new(0, v12.jumpHight * (1 - TweenService:GetValue(v19, Enum.EasingStyle.Quint, Enum.EasingDirection.In)), 0), v10)
                                elseif v14 < v12.wave * 2 - 1 then
                                    v12.model.PrimaryPart.CFrame = v12.model.PrimaryPart.CFrame:Lerp(v12.pos, v10)
                                else
                                    v12.model:Destroy()
                                    table.remove(t2, i)
                                end
                            end
                        else
                            table.remove(t2, i)
                        end
                    end
                end
            end
        end)
        p2.AncestryChanged:Connect(function() -- line: 102
            -- upvalues: connection (ref)
            connection:Disconnect()
        end)
    end
}
