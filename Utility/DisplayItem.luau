-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local New = _G.New

return {
    new = function(p1, p2, p3) -- new | line: 6
        -- upvalues: UserInputService (copy), New (copy)
        p1.item = p2
        p1.isModel = p2:IsA("Model")
        p1.trove = New("Utility.Trove")()
        p1.isDragging = false
        p1.lastMousePos = nil
        p1.rotationSpeed = p3 or Vector2.new(0.005, 0.005)
        p1.currentRotationX = 0
        p1.currentRotationY = 181
        p1.rotationDamping = 0.98
        p1.velocityX = 0
        p1.velocityY = 0
        p1.maxVelocity = 0.5
        p1.isTouchDevice = UserInputService.TouchEnabled
        p1.touchInputObject = nil
    end,
    Enable = function(p4) -- Enable | line: 25
        -- upvalues: UserInputService (copy), RunService (copy)
        if p4.isEnable then
            return
        end

        p4.isEnable = true
        p4.trove:Add(UserInputService.InputBegan:Connect(function(p5, p6) -- line: 30
            -- upvalues: p4 (copy)
            if p5.UserInputType ~= Enum.UserInputType.MouseButton1 and (not p4.isTouchDevice or p5.UserInputType ~= Enum.UserInputType.Touch) and p6 then
                return
            end

            p4.isDragging = true
            p4.lastMousePos = p5.Position
            p4.velocityX = 0
            p4.velocityY = 0

            if p4.isTouchDevice then
                p4.touchInputObject = p5
            end
        end))
        p4.trove:Add(UserInputService.InputEnded:Connect(function(p7, _) -- line: 43
            -- upvalues: p4 (copy)
            if p7.UserInputType == Enum.UserInputType.MouseButton1 or p4.isTouchDevice and p7.UserInputType == Enum.UserInputType.Touch and p7 == p4.touchInputObject then
                p4.isDragging = false
                p4.touchInputObject = nil
            end
        end))
        p4.trove:Add(UserInputService.InputChanged:Connect(function(p9) -- line: 50
            -- upvalues: p4 (copy)
            if not p4.isDragging or p9.UserInputType ~= Enum.UserInputType.MouseMovement and (not p4.isTouchDevice or p9.UserInputType ~= Enum.UserInputType.Touch or p9 ~= p4.touchInputObject) then
                return
            end

            local Position = p9.Position
            local v1 = Position - p4.lastMousePos

            p4.velocityX = -v1.Y * p4.rotationSpeed.X * 0.5625 / workspace.CurrentCamera.ViewportSize.Y
            p4.velocityY = v1.X * p4.rotationSpeed.Y * 0.5625 / workspace.CurrentCamera.ViewportSize.Y
            p4.velocityX = math.clamp(p4.velocityX, -p4.maxVelocity, p4.maxVelocity)
            p4.velocityY = math.clamp(p4.velocityY, -p4.maxVelocity, p4.maxVelocity)
            p4.currentRotationX += p4.velocityX
            p4.currentRotationY += p4.velocityY
            p4.lastMousePos = Position
        end))
        p4.trove:Add(RunService.RenderStepped:Connect(function(_) -- line: 70
            -- upvalues: p4 (copy)
            if not p4.isDragging and (math.abs(p4.velocityX) > 0.01 or math.abs(p4.velocityY) > 0.01) then
                p4.currentRotationX += p4.velocityX
                p4.currentRotationY += p4.velocityY
                p4.velocityX *= p4.rotationDamping
                p4.velocityY *= p4.rotationDamping
            end

            if p4.isModel then
                p4.item:PivotTo(CFrame.new(p4.item:GetPivot().Position) * CFrame.Angles(0, p4.currentRotationY, 0) * CFrame.Angles(p4.currentRotationX, 0, 0))
            else
                p4.item.CFrame = CFrame.new(p4.item.Position) * CFrame.Angles(0, p4.currentRotationY, 0) * CFrame.Angles(p4.currentRotationX, 0, 0)
            end
        end))
    end,
    DisEnable = function(p11) -- DisEnable | line: 93
        if p11.isEnable then
            p11.isEnable = false
            p11.trove:Clean()
        end
    end,
    Destroy = function(p12) -- Destroy | line: 101
        if p12.isEnable then
            p12:DisEnable()
        end

        p12.item:Destroy()
    end
}
