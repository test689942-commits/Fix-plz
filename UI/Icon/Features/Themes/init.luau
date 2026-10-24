-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local t1 = {}
local Utility = require(script.Parent.Parent.Utility)
local Default = require(script.Default)

function t1.getThemeValue(p1, p2, p3, _) -- line: 16
    if not p1 then
        return
    end

    for _, v1 in pairs(p1) do
        local v2, v3, v4 = unpack(v1)

        if p2 == v2 and p3 == v3 then
            return v4
        end
    end
end

function t1.getInstanceValue(p5, p6) -- line: 27
    local function v5() -- line: 28
        -- upvalues: p5 (copy), p6 (copy)
        return p5[p6]
    end

    local ok, result = pcall(v5)

    if not ok then
        result = p5:GetAttribute(p6)
    end

    return result
end

function t1.getRealInstance(p7) -- line: 37
    if p7:GetAttribute("IsAClippedClone") then
        local OriginalInstance = p7:FindFirstChild("OriginalInstance")

        if OriginalInstance then
            return OriginalInstance.Value
        end
    end
end

function t1.getClippedClone(p8) -- line: 48
    if p8:GetAttribute("HasAClippedClone") then
        local ClippedClone = p8:FindFirstChild("ClippedClone")

        if ClippedClone then
            return ClippedClone.Value
        end
    end
end

function t1.refresh(p9, p10, p11) -- line: 59
    -- upvalues: t1 (copy)
    if p11 then
        local v6 = p9:getStateGroup()
        local v7 = t1.getThemeValue(v6, p10.Name, p11) or t1.getInstanceValue(p10, p11)

        t1.apply(p9, p10, p11, v7, true)
    else
        local v8 = p9:getStateGroup()

        if v8 then
            local t2 = {
                [p10.Name] = p10
            }

            for _, descendant in pairs(p10:GetDescendants()) do
                local Collective = descendant:GetAttribute("Collective")

                if Collective then
                    t2[Collective] = descendant
                end

                t2[descendant.Name] = descendant
            end

            for _, v9 in pairs(v8) do
                local v10, v11, v12 = unpack(v9)
                local v13 = t2[v10]

                if v13 then
                    t1.apply(p9, v13.Name, v11, v12, true)
                end
            end
        end
    end
end

function t1.apply(p12, p13, p14, p15, p16) -- line: 92
    -- upvalues: t1 (copy)
    if p12.isDestroyed then
        return
    end

    local v15, v16

    if typeof(p13) == "Instance" then
        v16 = { p13 }
        v15 = p13.Name
    else
        v16 = p12:getInstanceOrCollective(p13)
        v15 = p13
    end

    local v17 = v15 .. "-" .. p14
    local v18 = p12.customBehaviours[v17]

    for _, v19 in pairs(v16) do
        local v20 = t1.getClippedClone(v19)

        if v20 then
            table.insert(v16, v20)
        end
    end

    for _, v21 in pairs(v16) do
        if p14 ~= "Position" or not t1.getClippedClone(v21) then
            if p14 == "Size" then
                if not t1.getRealInstance(v21) then
                    local v22 = t1.getInstanceValue(v21, p14)

                    if p16 then
                        if v18 then
                            local v23 = v18(p15, v21, p14)

                            if v23 ~= nil then
                                p15 = v23
                            end
                        end

                        local function v24() -- line: 138
                            -- upvalues: p14 (copy), p15 (ref), v21 (copy)
                            v21[p14] = p15
                        end

                        if not pcall(v24) then
                            v21:SetAttribute(p14, p15)
                        end
                    else
                        local v26 = p15

                        if v26 ~= v22 then
                            if v18 then
                                local v27 = v18(p15, v21, p14)

                                if v27 ~= nil then
                                    p15 = v27
                                end
                            end

                            local function v28() -- line: 138
                                -- upvalues: p14 (copy), p15 (ref), v21 (copy)
                                v21[p14] = p15
                            end

                            if not pcall(v28) then
                                v21:SetAttribute(p14, p15)
                            end
                        end
                    end
                end
            else
                local v30 = t1.getInstanceValue(v21, p14)

                if p16 then
                    if v18 then
                        local v31 = v18(p15, v21, p14)

                        if v31 ~= nil then
                            p15 = v31
                        end
                    end

                    local function v32() -- line: 138
                        -- upvalues: p14 (copy), p15 (ref), v21 (copy)
                        v21[p14] = p15
                    end

                    if not pcall(v32) then
                        v21:SetAttribute(p14, p15)
                    end
                else
                    local v34 = p15

                    if v34 ~= v30 then
                        if v18 then
                            local v35 = v18(p15, v21, p14)

                            if v35 ~= nil then
                                p15 = v35
                            end
                        end

                        local function v36() -- line: 138
                            -- upvalues: p14 (copy), p15 (ref), v21 (copy)
                            v21[p14] = p15
                        end

                        if not pcall(v36) then
                            v21:SetAttribute(p14, p15)
                        end
                    end
                end
            end
        end
    end
end

function t1.getModifications(p17) -- line: 152
    if typeof(p17[1]) == "table" then
        return p17
    end

    return { p17 }
end

function t1.merge(p18, p19, p20) -- line: 161
    -- upvalues: t1 (copy)
    local v39, v40, v41, v42 = table.unpack(p19)
    local v43, v44, _, v45 = table.unpack(p18)

    if v39 ~= v43 or v40 ~= v44 or not t1.statesMatch(v42, v45) then
        local v46 = true

        return not v46
    end

    p18[3] = v41

    if p20 then
        p20(p18)
    end

    return not false
end

function t1.modify(p21, p22, p23) -- line: 174
    -- upvalues: t1 (copy), Utility (copy)
    task.spawn(function() -- line: 182
        -- upvalues: p21 (copy), p22 (ref), p23 (ref), t1 (copy), Utility (copy)
        p23 = p23 or Utility.generateUID()
        p22 = t1.getModifications(p22)

        for _, v47 in pairs(p22) do
            local v48, v49, v50, v51 = table.unpack(v47)

            if v51 == nil then
                t1.modify(p21, { v48, v49, v50, "Selected" }, p23)
                t1.modify(p21, { v48, v49, v50, "Viewing" }, p23)
            end

            local v52 = Utility.formatStateName(v51 or "Deselected")
            local v53 = p21:getStateGroup(v52)

            local function updateRecord() -- line: 199
                -- upvalues: v47 (copy), v48 (copy), v49 (copy), v50 (copy), v52 (copy), v53 (copy), p21 (copy), p23 (ref), t1 (copy)
                for _, v54 in pairs(v53) do
                    if t1.merge(v54, v47, function(p24) -- line: 201
                        -- upvalues: v48 (copy), v49 (copy), v50 (copy), v52 (copy), p21 (copy), p23 (ref), t1 (copy)
                        p24[5] = p23

                        if v52 == p21.activeState then
                            t1.apply(p21, v48, v49, v50)
                        end
                    end) then
                        return
                    end
                end

                table.insert(v53, {
                    v48,
                    v49,
                    v50,
                    v52,
                    p23
                })

                if v52 == p21.activeState then
                    t1.apply(p21, v48, v49, v50)
                end
            end

            updateRecord()
        end
    end)

    return p23
end

function t1.remove(p25, p26) -- line: 219
    -- upvalues: t1 (copy)
    for _, v55 in pairs(p25.appearance) do
        for i = #v55, 1, -1 do
            if v55[i][5] == p26 then
                table.remove(v55, i)
            end
        end
    end

    t1.rebuild(p25)
end

function t1.removeWith(p27, p28, p29, p30) -- line: 232
    -- upvalues: t1 (copy)
    for v56, v57 in pairs(p27.appearance) do
        if p30 == v56 or not p30 then
            for i = #v57, 1, -1 do
                local v58 = v57[i]
                local v59 = v58[1]
                local v60 = v58[2]

                if v59 == p28 and v60 == p29 then
                    table.remove(v57, i)
                end
            end
        end
    end

    t1.rebuild(p27)
end

function t1.change(p31) -- line: 248
    -- upvalues: t1 (copy)
    local v61 = p31:getStateGroup()

    for _, v62 in pairs(v61) do
        local v63, v64, v65 = unpack(v62)

        t1.apply(p31, v63, v64, v65)
    end
end

function t1.set(p32, p33) -- line: 258
    -- upvalues: t1 (copy)
    local themesJanitor = p32.themesJanitor

    themesJanitor:clean()
    themesJanitor:add(p32.stateChanged:Connect(function() -- line: 264
        -- upvalues: p32 (copy), t1 (copy)
        t1.change(p32)
    end))
    p32.appliedTheme = if typeof(p33) == "Instance" and p33:IsA("ModuleScript") then require(p33) else p33
    t1.rebuild(p32)
end

function t1.statesMatch(p34, p35) -- line: 274
    if (p34 and string.lower(p34)) == (p35 and string.lower(p35)) then
        return true
    end

    return not p34 or not p35
end

function t1.rebuild(p36) -- line: 281
    -- upvalues: t1 (copy), Utility (copy), Default (copy)
    local appliedTheme = p36.appliedTheme
    local t4 = { "Deselected", "Selected", "Viewing" }

    local function generateTheme() -- line: 288
        -- upvalues: p36 (copy), appliedTheme (copy), t4 (copy), t1 (copy), Utility (copy), Default (copy)
        for _, v67 in pairs(t4) do
            local t5 = {}

            local function updateDetails(p37, p38) -- line: 294
                -- upvalues: t5 (copy), t1 (copy), Utility (copy)
                if not p37 then
                    return
                end

                for _, v68 in pairs(p37) do
                    local v69 = v68[5]
                    local v70 = v68[4]

                    if t1.statesMatch(p38, v70) then
                        local v71 = v68[1] .. "-" .. v68[2]
                        local v72 = Utility.copyTable(v68)

                        v72[5] = v69
                        t5[v71] = v72
                    end
                end
            end

            if v67 == "Selected" then
                updateDetails(Default, "Deselected")
            end

            updateDetails(Default, "Empty")
            updateDetails(Default, v67)

            if appliedTheme ~= Default then
                if v67 == "Selected" then
                    updateDetails(appliedTheme, "Deselected")
                end

                updateDetails(Default, "Empty")
                updateDetails(appliedTheme, v67)
            end

            local t6 = {}
            local v73 = p36.appearance[v67]

            if v73 then
                for _, v74 in pairs(v73) do
                    local v75 = v74[5]

                    if v75 ~= nil then
                        table.insert(t6, {
                            v74[1],
                            v74[2],
                            v74[3],
                            v67,
                            v75
                        })
                    end
                end
            end

            updateDetails(t6, v67)

            local t8 = {}

            for _, v76 in pairs(t5) do
                table.insert(t8, v76)
            end

            p36.appearance[v67] = t8
        end

        t1.change(p36)
    end

    generateTheme()
end

return t1
