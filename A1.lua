-- [[ سكريبت أيهم الأسطوري - النسخة المستقرة V4.3 ]]
local Player = game.Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")
local RunService = game:GetService("RunService")
local PlayersService = game:GetService("Players")

if PlayerGui:FindFirstChild("AihamSuperMenu") then 
    PlayerGui.AihamSuperMenu:Destroy() 
end

local ScreenGui = Instance.new("ScreenGui", PlayerGui)
ScreenGui.Name = "AihamSuperMenu"

-- واجهة مستطيلة بسيطة بدون تبويبات معقدة
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 340, 0, 220)
MainFrame.Position = UDim2.new(0.5, -170, 0.5, -110)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.BorderSizePixel = 2
MainFrame.BorderColor3 = Color3.fromRGB(255, 215, 0)
MainFrame.Active = true
MainFrame.Draggable = true

local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, 0, 0, 35)
Title.Text = "صنع من قبل المطور الأسطوري أيهم V4.3"
Title.TextColor3 = Color3.fromRGB(255, 215, 0)
Title.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 14

-- دالة مبسطة لإنشاء الأزرار المباشرة للنسخة 4.3
local function createDirectBtn(text, posy, callback)
    local btn = Instance.new("TextButton", MainFrame)
    btn.Size = UDim2.new(0.9, 0, 0, 35)
    btn.Position = UDim2.new(0.05, 0, 0, posy)
    btn.Text = text
    btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 14
    
    local active = false
    btn.MouseButton1Click:Connect(function()
        active = not active
        btn.BackgroundColor3 = active and Color3.fromRGB(0, 180, 0) or Color3.fromRGB(45, 45, 45)
        btn.TextColor3 = active and Color3.fromRGB(0, 0, 0) or Color3.fromRGB(255, 255, 255)
        callback(active)
    end)
    return btn
end

-- ميزات النسخة 4.3 الأساسية
createDirectBtn("تفعيل السرعة العالية (WalkSpeed)", 50, function(active)
    local char = Player.Character
    if char and char:FindFirstChild("Humanoid") then
        char.Humanoid.WalkSpeed = active and 60 or 16
    end
end)

createDirectBtn("تفعيل القفز العالي (JumpPower)", 95, function(active)
    local char = Player.Character
    if char and char:FindFirstChild("Humanoid") then
        char.Humanoid.JumpPower = active and 120 or 50
    end
end)

createDirectBtn("إضاءة ساطعة للماب (FullBright)", 140, function(active)
    game.Lighting.Ambient = active and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(128, 128, 128)
end)

-- زر صغير لإخفاء القائمة في الزاوية
local CloseBtn = Instance.new("TextButton", MainFrame)
CloseBtn.Size = UDim2.new(0, 25, 0, 25)
CloseBtn.Position = UDim2.new(1, -28, 0, 5)
CloseBtn.Text = "X"
CloseBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.MouseButton1Click:Connect(function() 
    MainFrame.Visible = false 
end)
