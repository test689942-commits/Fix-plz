-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local New = _G.New

return {
    new = function(p1, p2, p3, p4) -- new | line: 6
        -- upvalues: UserInputService (copy), New (copy)
        p1.camera = workspace.CurrentCamera
        p1.pos = p2
        p1.size = p3
        p1.trove = New("Utility.Trove")()
        p1.isDragging = false
        p1.lastMousePos = nil
        p1.speed = p4
        p1.currentX = 0
        p1.currentY = 181
        p1.moveDamping = 0.98
        p1.velocityX = 0
        p1.velocityY = 0
        p1.maxVelocity = 50
        p1.isTouchDevice = UserInputService.TouchEnabled
        p1.touchInputObject = nil
    end,
    Enable = function(p5) -- Enable | line: 26
        -- upvalues: UserInputService (copy), RunService (copy)
        if p5.isEnable then
            return
        end

        p5.isEnable = true
        p5.trove:Add(UserInputService.InputBegan:Connect(function(p6, p7) -- line: 31
            -- upvalues: p5 (copy)
            if p6.UserInputType ~= Enum.UserInputType.MouseButton1 and (not p5.isTouchDevice or p6.UserInputType ~= Enum.UserInputType.Touch) and p7 then
                return
            end

            p5.isDragging = true
            p5.lastMousePos = p6.Position
            p5.velocityX = 0
            p5.velocityY = 0

            if p5.isTouchDevice then
                p5.touchInputObject = p6
            end
        end))
        p5.trove:Add(UserInputService.InputEnded:Connect(function(p8, _) -- line: 44
            -- upvalues: p5 (copy)
            if p8.UserInputType == Enum.UserInputType.MouseButton1 or p5.isTouchDevice and p8.UserInputType == Enum.UserInputType.Touch and p8 == p5.touchInputObject then
                p5.isDragging = false
                p5.touchInputObject = nil
            end
        end))
        p5.trove:Add(UserInputService.InputChanged:Connect(function(p10) -- line: 51
            -- upvalues: p5 (copy)
            if not p5.isDragging or p10.UserInputType ~= Enum.UserInputType.MouseMovement and (not p5.isTouchDevice or p10.UserInputType ~= Enum.UserInputType.Touch or p10 ~= p5.touchInputObject) then
                return
            end

            local Position = p10.Position
            local v1 = Position - p5.lastMousePos

            p5.velocityX = -v1.Y * p5.speed * 0.5
            p5.velocityY = v1.X * p5.speed * 0.5
            p5.velocityX = math.clamp(p5.velocityX, -p5.maxVelocity, p5.maxVelocity)
            p5.velocityY = math.clamp(p5.velocityY, -p5.maxVelocity, p5.maxVelocity)
            p5.currentX += p5.velocityX
            p5.currentY += p5.velocityY
            p5.lastMousePos = Position
        end))
        p5.trove:Add(RunService.RenderStepped:Connect(function(_) -- line: 71
            -- upvalues: p5 (copy)
            if not p5.isDragging and (math.abs(p5.velocityX) > 0.01 or math.abs(p5.velocityY) > 0.01) then
                p5.currentX += p5.velocityX
                p5.currentY += p5.velocityY
                p5.velocityX *= p5.moveDamping
                p5.velocityY *= p5.moveDamping
            end

            if p5.isModel then
                p5.item:PivotTo(CFrame.new(p5.item:GetPivot().Position) * CFrame.Angles(0, p5.currentY, 0) * CFrame.Angles(p5.currentX, 0, 0))
            else
                p5.item.CFrame = CFrame.new(p5.item.Position) * CFrame.Angles(0, p5.currentY, 0) * CFrame.Angles(p5.currentX, 0, 0)
            end
        end))
    end,
    DisEnable = function(p12) -- DisEnable | line: 95
        if p12.isEnable then
            p12.isEnable = false
            p12.trove:Clean()
        end
    end,
    Destroy = function(p13) -- Destroy | line: 103
        if p13.isEnable then
            p13:DisEnable()
        end

        p13.item:Destroy()
    end
}
