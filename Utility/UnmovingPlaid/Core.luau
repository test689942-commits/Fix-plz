-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local AssetService = game:GetService("AssetService")

require(script.Parent.Definitions)

return {
    createBoxMesh = function() -- createBoxMesh | line: 7
        -- upvalues: AssetService (copy)
        local v1 = AssetService:CreateEditableMesh()

        for _, v2 in {
                { Vector3.new(-0.5, -0.5, 0.5), Vector3.new(0.5, -0.5, 0.5), Vector3.new(0.5, 0.5, 0.5), Vector3.new(-0.5, 0.5, 0.5), (Vector3.new(0, 0, 1)) },
                { Vector3.new(0.5, -0.5, -0.5), Vector3.new(-0.5, -0.5, -0.5), Vector3.new(-0.5, 0.5, -0.5), Vector3.new(0.5, 0.5, -0.5), (Vector3.new(-0, -0, -1)) },
                { Vector3.new(-0.5, 0.5, -0.5), Vector3.new(-0.5, 0.5, 0.5), Vector3.new(0.5, 0.5, 0.5), Vector3.new(0.5, 0.5, -0.5), (Vector3.new(0, 1, 0)) },
                { Vector3.new(-0.5, -0.5, 0.5), Vector3.new(-0.5, -0.5, -0.5), Vector3.new(0.5, -0.5, -0.5), Vector3.new(0.5, -0.5, 0.5), (Vector3.new(-0, -1, -0)) },
                { Vector3.new(0.5, -0.5, 0.5), Vector3.new(0.5, -0.5, -0.5), Vector3.new(0.5, 0.5, -0.5), Vector3.new(0.5, 0.5, 0.5), (Vector3.new(1, 0, 0)) },
                { Vector3.new(-0.5, -0.5, -0.5), Vector3.new(-0.5, -0.5, 0.5), Vector3.new(-0.5, 0.5, 0.5), Vector3.new(-0.5, 0.5, -0.5), (Vector3.new(-1, -0, -0)) }
            } do
            local v3 = v2[1]
            local v4 = v2[2]
            local v5 = v2[3]
            local v6 = v2[4]
            local v7 = v2[5]
            local t2 = {}

            for i = 0, 12 do
                t2[i] = {}

                local v8 = i / 12
                local v9 = v3:Lerp(v6, v8)
                local v10 = v4:Lerp(v5, v8)

                for j = 0, 12 do
                    local v11 = j / 12
                    local v12 = v1:AddVertex((v9:Lerp(v10, v11)))
                    local v13 = v1:AddNormal(v7)
                    local v14 = v1:AddUV(Vector2.new(v11, 1 - v8))

                    t2[i][j] = {
                        v = v12,
                        n = v13,
                        uv = v14
                    }
                end
            end

            for k = 0, 11 do
                for n = 0, 11 do
                    local v15 = t2[k][n]
                    local v16 = t2[k][n + 1]
                    local v17 = t2[k + 1][n]
                    local v18 = t2[k + 1][n + 1]
                    local v19 = v1:AddTriangle(v15.v, v16.v, v18.v)

                    v1:SetFaceNormals(v19, {
                        v15.n,
                        v16.n,
                        v18.n
                    })
                    v1:SetFaceUVs(v19, {
                        v15.uv,
                        v16.uv,
                        v18.uv
                    })

                    local v20 = v1:AddTriangle(v15.v, v18.v, v17.v)

                    v1:SetFaceNormals(v20, {
                        v15.n,
                        v18.n,
                        v17.n
                    })
                    v1:SetFaceUVs(v20, {
                        v15.uv,
                        v18.uv,
                        v17.uv
                    })
                end
            end
        end

        return v1
    end,
    cacheUVData = function(p1) -- cacheUVData | line: 60
        local t3 = {}
        local t4 = {}
        local t5 = {}
        local t6 = {}

        for _, v21 in p1:GetFaces() do
            local FaceVertices = p1:GetFaceVertices(v21)
            local FaceUVs = p1:GetFaceUVs(v21)
            local FaceNormals = p1:GetFaceNormals(v21)

            for v22, v23 in FaceVertices do
                local v24 = FaceUVs[v22]

                if v24 and not t3[v24] then
                    t3[v24] = true
                    table.insert(t5, {
                        uvId = v24,
                        pos = p1:GetPosition(v23)
                    })
                end

                local v25 = FaceNormals[v22]

                if v25 and not t4[v25] then
                    t4[v25] = true
                    table.insert(t6, v25)
                end
            end
        end

        return t5, t6
    end,
    loadSourceImage = function(p2) -- loadSourceImage | line: 85
        -- upvalues: AssetService (copy)
        if p2 == "" then
            return nil
        end

        local function v26() -- line: 87
            -- upvalues: p2 (copy), AssetService (copy)
            return AssetService:CreateEditableImageAsync(Content.fromUri(p2))
        end

        local ok, result = pcall(v26)

        if ok then
            return result
        end

        warn("[UnmovingPlaid] Load failed: " .. p2 .. " — " .. tostring(result))

        return nil
    end,
    blitToCanvas = function(p3, p4) -- blitToCanvas | line: 95
        local Size = p3.Size
        local Size2 = p4.Size

        p3:DrawRectangle(Vector2.zero, Size, Color3.new(1, 1, 1), 1, Enum.ImageCombineType.Overwrite)
        p3:DrawImageTransformed(Size / 2, Vector2.new(Size.X / Size2.X, Size.Y / Size2.Y), 0, p4, {
            CombineType = Enum.ImageCombineType.Overwrite,
            SamplingMode = Enum.ResamplerMode.Default,
            PivotPoint = Size2 / 2
        })
    end,
    tintCanvas = function(p5, p6) -- tintCanvas | line: 104
        local Size = p5.Size
        local v27 = p5:ReadPixelsBuffer(Vector2.zero, Size)
        local v28 = Size.X * Size.Y * 4
        local R, G, B = p6.R, p6.G, p6.B

        for i = 0, v28 - 1, 4 do
            buffer.writeu8(v27, i, (math.floor(buffer.readu8(v27, i) * R)))

            local v32 = math.floor(buffer.readu8(v27, i + 1) * G)

            buffer.writeu8(v27, i + 1, v32)

            local v34 = math.floor(buffer.readu8(v27, i + 2) * B)

            buffer.writeu8(v27, i + 2, v34)
        end

        p5:WritePixelsBuffer(Vector2.zero, Size, v27)
    end
}
