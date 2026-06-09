-- [[ سكريبت أيهم الأسطوري - النسخة V36 النهائية والمكتملة ]]
local Player = game.Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")
local Lighting = game:GetService("Lighting")

if PlayerGui:FindFirstChild("AihamScript_Main") then PlayerGui.AihamScript_Main:Destroy() end

local ScreenGui = Instance.new("ScreenGui", PlayerGui)
ScreenGui.Name = "AihamScript_Main"
ScreenGui.ResetOnSpawn = false
ScreenGui.DisplayOrder = 2147483647 

-- [1] زر التحكم (الأيقونة المربعة)
local ToggleBtn = Instance.new("TextButton", ScreenGui)
ToggleBtn.Size = UDim2.new(0, 50, 0, 50)
ToggleBtn.Position = UDim2.new(0.9, -60, 0.1, 0)
ToggleBtn.Text = "⚫" 
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 0)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
ToggleBtn.TextSize = 30
ToggleBtn.Draggable = true
ToggleBtn.ZIndex = 100
Instance.new("UICorner", ToggleBtn)

-- [2] الإطار الرئيسي
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 400, 0, 350)
MainFrame.Position = UDim2.new(0.5, -200, 0.5, -175)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.Active = true 
MainFrame.Draggable = true
Instance.new("UICorner", MainFrame)

local MenuConfig = {"اعدادات الماب", "اللاعب", "الاستهداف", "التأثيرات", "المحفوظات", "العسكرية 🎖️"}
local SideMenu = Instance.new("ScrollingFrame", MainFrame)
SideMenu.Size = UDim2.new(0, 120, 1, 0)
SideMenu.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Instance.new("UICorner", SideMenu)

local ContentArea = Instance.new("Frame", MainFrame)
ContentArea.Size = UDim2.new(1, -120, 1, 0)
ContentArea.Position = UDim2.new(0, 120, 0, 0)
ContentArea.BackgroundTransparency = 1

local AllPages = {}
for i, name in ipairs(MenuConfig) do
    local btn = Instance.new("TextButton", SideMenu)
    btn.Size = UDim2.new(0.9, 0, 0, 40)
    btn.Position = UDim2.new(0.05, 0, 0, (i-1) * 45 + 5)
    btn.Text = name
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    btn.TextColor3 = Color3.new(1, 1, 1)
    Instance.new("UICorner", btn)
    local page = Instance.new("ScrollingFrame", ContentArea)
    page.Size = UDim2.new(1, 0, 1, 0)
    page.BackgroundTransparency = 1
    page.Visible = (i == 1)
    AllPages[name] = page
    btn.MouseButton1Click:Connect(function()
        for _, p in pairs(AllPages) do p.Visible = false end
        page.Visible = true
    end)
end

-- [3] إعدادات الماب
local MapPage = AllPages["اعدادات الماب"]

-- أ. زر تغيير اللون
local ColorBtn = Instance.new("TextButton", MapPage)
ColorBtn.Size = UDim2.new(0.9, 0, 0, 40)
ColorBtn.Position = UDim2.new(0.05, 0, 0, 10)
ColorBtn.Text = "تغيير لون القائمة"
ColorBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
Instance.new("UICorner", ColorBtn)
local colors = {Color3.fromRGB(20, 20, 20), Color3.fromRGB(255, 255, 255), Color3.fromRGB(0, 100, 255), Color3.fromRGB(255, 200, 0)}
local cIdx = 1
ColorBtn.MouseButton1Click:Connect(function()
    cIdx = (cIdx % #colors) + 1
    MainFrame.BackgroundColor3 = colors[cIdx]
end)

-- ب. زر السطوع (On/Off)
local FBEnabled = false
local FBButton = Instance.new("TextButton", MapPage)
FBButton.Size = UDim2.new(0.9, 0, 0, 40)
FBButton.Position = UDim2.new(0.05, 0, 0, 60)
FBButton.Text = "السطوع: مطفأ"
FBButton.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
Instance.new("UICorner", FBButton)
FBButton.MouseButton1Click:Connect(function()
    FBEnabled = not FBEnabled
    Lighting.Ambient = FBEnabled and Color3.new(1, 1, 1) or Color3.new(0, 0, 0)
    FBButton.Text = FBEnabled and "السطوع: شغال" or "السطوع: مطفأ"
    FBButton.BackgroundColor3 = FBEnabled and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(150, 0, 0)
end)

-- ج. زر الشادر (On/Off)
local ShaderEnabled = false
local ShaderBtn = Instance.new("TextButton", MapPage)
ShaderBtn.Size = UDim2.new(0.9, 0, 0, 40)
ShaderBtn.Position = UDim2.new(0.05, 0, 0, 110)
ShaderBtn.Text = "الشادر: مطفأ"
ShaderBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
Instance.new("UICorner", ShaderBtn)
ShaderBtn.MouseButton1Click:Connect(function()
    ShaderEnabled = not ShaderEnabled
    Lighting.Brightness = ShaderEnabled and 3 or 2
    Lighting.ClockTime = ShaderEnabled and 12 or 14
    ShaderBtn.Text = ShaderEnabled and "الشادر: شغال" or "الشادر: مطفأ"
    ShaderBtn.BackgroundColor3 = ShaderEnabled and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(150, 0, 0)
end)

-- د. مربع الحقوق
local InfoBox = Instance.new("TextLabel", MapPage)
InfoBox.Size = UDim2.new(0.9, 0, 0, 80)
InfoBox.Position = UDim2.new(0.05, 0, 0, 160)
InfoBox.Text = "تم صناعة هذا السكربت بواسطة anxam\nرابط الديسكورد: https://discord.gg/7rRwEm3bjx"
InfoBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
InfoBox.TextColor3 = Color3.new(1, 1, 1)
InfoBox.TextWrapped = true
Instance.new("UICorner", InfoBox)

ToggleBtn.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)
