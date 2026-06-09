-- [[ سكريبت أيهم الأسطوري V12.1 - نسخة محسنة للأداء ]]
local Player = game.Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")
local RunService = game:GetService("RunService")
local PlayersService = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")

-- تنظيف النسخ القديمة
if PlayerGui:FindFirstChild("AihamSuperMenu") then PlayerGui.AihamSuperMenu:Destroy() end

local ScreenGui = Instance.new("ScreenGui", PlayerGui)
ScreenGui.Name = "AihamSuperMenu"
ScreenGui.ResetOnSpawn = false

-- (باقي كود الإطارات والأزرار كما هو، قمت بتطوير الوظائف الحيوية بالداخل)

-- تطوير نظام الطيران (Fly) ليكون أكثر سلاسة
local flying = false
local flyConnection
local bodyVelocity, bodyGyro

local function toggleFly()
    flying = not flying
    local char = Player.Character
    local root = char and (char:FindFirstChild("HumanoidRootPart"))
    
    if flying and root then
        bodyVelocity = Instance.new("BodyVelocity", root)
        bodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        bodyVelocity.Velocity = Vector3.zero
        
        bodyGyro = Instance.new("BodyGyro", root)
        bodyGyro.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
        bodyGyro.CFrame = root.CFrame
        
        flyConnection = RunService.RenderStepped:Connect(function()
            if root and char:FindFirstChild("Humanoid") then
                bodyGyro.CFrame = workspace.CurrentCamera.CFrame
                local moveDir = char.Humanoid.MoveDirection
                local velocity = moveDir * 70
                
                if UserInputService:IsKeyDown(Enum.KeyCode.Space) then velocity = velocity + Vector3.new(0, 50, 0) end
                if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then velocity = velocity + Vector3.new(0, -50, 0) end
                bodyVelocity.Velocity = velocity
            end
        end)
    else
        if flyConnection then flyConnection:Disconnect() end
        if bodyVelocity then bodyVelocity:Destroy() end
        if bodyGyro then bodyGyro:Destroy() end
    end
end

-- تطوير نظام اختراق الجدران (Noclip)
local noclipActive = false
local noclipConnection
noclipConnection = RunService.Stepped:Connect(function()
    if noclipActive and Player.Character then
        for _, part in ipairs(Player.Character:GetChildren()) do
            if part:IsA("BasePart") then part.CanCollide = false end
        end
    end
end)

-- (قم بلصق باقي أجزاء السكريبت هنا، فهي ممتازة)
