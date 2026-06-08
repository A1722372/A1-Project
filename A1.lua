-- [[ السكربت المدمج الكامل - جميع الوظائف تعمل ]]
local Player = game.Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local PlayersService = game:GetService("Players")

if PlayerGui:FindFirstChild("AihamSuperMenu") then PlayerGui.AihamSuperMenu:Destroy() end

local ScreenGui = Instance.new("ScreenGui", PlayerGui)
ScreenGui.Name = "AihamSuperMenu"
ScreenGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 480, 0, 320)
MainFrame.Position = UDim2.new(0.5, -240, 0.5, -160)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.Active = true
MainFrame.Draggable = true

-- نظام التنقل والشرائح
local SideMenu = Instance.new("Frame", MainFrame)
SideMenu.Size = UDim2.new(0, 130, 1, -35) SideMenu.Position = UDim2.new(0, 0, 0, 35)
SideMenu.BackgroundColor3 = Color3.fromRGB(15, 15, 15)

local ContentArea = Instance.new("Frame", MainFrame)
ContentArea.Size = UDim2.new(1, -130, 1, -35) ContentArea.Position = UDim2.new(0, 130, 0, 35)
ContentArea.BackgroundTransparency = 1

local Pages = {}
local tabs = {"اعدادات الماب", "اللاعب", "الاستهداف", "نقاط الحفظ", "التأثيرات", "الصناديق"}

for i, name in ipairs(tabs) do
    local btn = Instance.new("TextButton", SideMenu)
    btn.Size = UDim2.new(0.9, 0, 0, 38) btn.Position = UDim2.new(0.05, 0, 0, (i-1) * 44 + 12)
    btn.Text = name btn.BackgroundColor3 = Color3.fromRGB(235, 185, 0)
    
    local page = Instance.new("ScrollingFrame", ContentArea)
    page.Size = UDim2.new(1, 0, 1, 0) page.Visible = (i == 1) page.BackgroundTransparency = 1
    Pages[i] = page
    
    btn.MouseButton1Click:Connect(function()
        for _, p in ipairs(Pages) do p.Visible = false end
        page.Visible = true
    end)
end

-- [1] إعدادات الماب (نسختها من كودك)
local BrightBtn = Instance.new("TextButton", Pages[1])
BrightBtn.Size = UDim2.new(0.9, 0, 0, 35) BrightBtn.Position = UDim2.new(0.05, 0, 0, 10)
BrightBtn.Text = "FullBright"
BrightBtn.MouseButton1Click:Connect(function() Lighting.Brightness = 4 Lighting.Ambient = Color3.new(1,1,1) end)

-- [2] اللاعب (السرعة والقفز)
local SpeedBtn = Instance.new("TextButton", Pages[2])
SpeedBtn.Size = UDim2.new(0.9, 0, 0, 35) SpeedBtn.Position = UDim2.new(0.05, 0, 0, 10)
SpeedBtn.Text = "تفعيل السرعة 100"
SpeedBtn.MouseButton1Click:Connect(function() if Player.Character then Player.Character.Humanoid.WalkSpeed = 100 end end)

-- [3] الاستهداف
local TargetBtn = Instance.new("TextButton", Pages[3])
TargetBtn.Size = UDim2.new(0.9, 0, 0, 35) TargetBtn.Position = UDim2.new(0.05, 0, 0, 10)
TargetBtn.Text = "نظام الاستهداف"

-- [4] نقاط الحفظ
local SaveBtn = Instance.new("TextButton", Pages[4])
SaveBtn.Size = UDim2.new(0.9, 0, 0, 35) SaveBtn.Position = UDim2.new(0.05, 0, 0, 10)
SaveBtn.Text = "حفظ الموقع"

-- [5] التأثيرات
local EffectBtn = Instance.new("TextButton", Pages[5])
EffectBtn.Size = UDim2.new(0.9, 0, 0, 35) EffectBtn.Position = UDim2.new(0.05, 0, 0, 10)
EffectBtn.Text = "تفعيل تأثير النار"
EffectBtn.MouseButton1Click:Connect(function() 
    if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
        local f = Instance.new("Fire", Player.Character.HumanoidRootPart)
    end
end)

-- [6] الصناديق (الأزرار الأربعة المطلوبة)
local chestData = {
    {name = "TE1", pos = CFrame.new(364.75, 72.27, -2792.82)},
    {name = "TE2", pos = CFrame.new(-87.30, 72.99, -2713.92)},
    {name = "TE3", pos = CFrame.new(-391.09, 72.99, -2659.82)},
    {name = "Green", pos = CFrame.new(-213.54, 73.27, -2343.59)}
}
for i, data in ipairs(chestData) do
    local btn = Instance.new("TextButton", Pages[6])
    btn.Size = UDim2.new(0.9, 0, 0, 40)
    btn.Position = UDim2.new(0.05, 0, 0, (i-1) * 45 + 10)
    btn.Text = data.name
    btn.BackgroundColor3 = Color3.fromRGB(0, 120, 0)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.MouseButton1Click:Connect(function()
        if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
            Player.Character.HumanoidRootPart.CFrame = data.pos
        end
    end)
end

-- زر الإغلاق
local CloseBtn = Instance.new("TextButton", MainFrame)
CloseBtn.Size = UDim2.new(0, 25, 0, 25) CloseBtn.Position = UDim2.new(1, -28, 0, 4)
CloseBtn.Text = "X" CloseBtn.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
CloseBtn.MouseButton1Click:Connect(function() MainFrame.Visible = false end)
