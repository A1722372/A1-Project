-- [[ سكريبت أيهم الأسطوري - النسخة النهائية الموحدة V32 ]]
local Player = game.Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")
local Lighting = game:GetService("Lighting")

-- تنظيف أي نسخة قديمة
if PlayerGui:FindFirstChild("AihamScript_Main") then
    PlayerGui.AihamScript_Main:Destroy()
end

-- [1] إنشاء الحاوية
local ScreenGui = Instance.new("ScreenGui", PlayerGui)
ScreenGui.Name = "AihamScript_Main"
ScreenGui.ResetOnSpawn = false
ScreenGui.DisplayOrder = 999999

-- [2] زر التصغير (الصورة المربعة الصفراء بالنقطة)
local ToggleBtn = Instance.new("ImageButton", ScreenGui)
ToggleBtn.Size = UDim2.new(0, 50, 0, 50)
ToggleBtn.Position = UDim2.new(0.9, -60, 0.1, 0)
ToggleBtn.BackgroundTransparency = 1
ToggleBtn.Image = "rbxassetid://18563336718"
ToggleBtn.Draggable = true

-- [3] الإطار الرئيسي
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 400, 0, 300)
MainFrame.Position = UDim2.new(0.5, -200, 0.5, -150)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true 
MainFrame.Draggable = true
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)

-- [4] التبويبات والمحتوى
local MenuConfig = {"اعدادات الماب", "اللاعب", "الاستهداف", "التأثيرات", "المحفوظات", "العسكرية 🎖️"}
local SideMenu = Instance.new("ScrollingFrame", MainFrame)
SideMenu.Size = UDim2.new(0, 120, 1, 0)
SideMenu.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
SideMenu.ScrollBarThickness = 2
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

-- [5] إضافة الميزات للشريحة الأولى
local MapPage = AllPages["اعدادات الماب"]

-- أ. تغيير اللون
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

-- ب. السطوع (On/Off)
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

-- [6] زر الإخفاء
ToggleBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)
