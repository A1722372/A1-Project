-- [[ سكريبت أيهم الأسطوري - النسخة V29 - التعديلات الشاملة ]]
local Player = game.Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")
local Lighting = game:GetService("Lighting")

-- [1] الحاوية الأساسية
local ScreenGui = Instance.new("ScreenGui", PlayerGui)
ScreenGui.Name = "AihamScript_Main"
ScreenGui.ResetOnSpawn = false
ScreenGui.DisplayOrder = 999 

-- [2] زر التصغير (الصورة المربعة الصفراء بالنقطة)
local ToggleBtn = Instance.new("ImageButton", ScreenGui)
ToggleBtn.Size = UDim2.new(0, 50, 0, 50)
ToggleBtn.Position = UDim2.new(0.9, -60, 0.1, 0)
ToggleBtn.BackgroundTransparency = 1
ToggleBtn.Image = "rbxassetid://18563336718" -- ضع الـ ID الصحيح لصورتك هنا
ToggleBtn.Draggable = true

-- [3] الإطار الرئيسي
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 500, 0, 350)
MainFrame.Position = UDim2.new(0.5, -250, 0.5, -175)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true 
MainFrame.Draggable = true
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)

-- [4] التبويبات
local MenuConfig = {"اعدادات الماب", "اللاعب", "الاستهداف", "التأثيرات", "المحفوظات", "العسكرية 🎖️"}
local SideMenu = Instance.new("ScrollingFrame", MainFrame)
SideMenu.Size = UDim2.new(0, 150, 1, 0)
SideMenu.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
SideMenu.CanvasSize = UDim2.new(0, 0, 0, #MenuConfig * 50)
SideMenu.ScrollBarThickness = 2
Instance.new("UICorner", SideMenu)

local ContentArea = Instance.new("Frame", MainFrame)
ContentArea.Size = UDim2.new(1, -150, 1, 0)
ContentArea.Position = UDim2.new(0, 150, 0, 0)
ContentArea.BackgroundTransparency = 1

local AllPages = {}
for i, name in ipairs(MenuConfig) do
    local btn = Instance.new("TextButton", SideMenu)
    btn.Size = UDim2.new(0.9, 0, 0, 40)
    btn.Position = UDim2.new(0.05, 0, 0, (i-1) * 45 + 5)
    btn.Text = name
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    Instance.new("UICorner", btn)
    
    local page = Instance.new("ScrollingFrame", ContentArea)
    page.Size = UDim2.new(1, 0, 1, 0)
    page.Visible = (i == 1)
    AllPages[name] = page
    
    btn.MouseButton1Click:Connect(function()
        for _, p in pairs(AllPages) do p.Visible = false end
        page.Visible = true
    end)
end

-- [5] الشريحة الأولى (اعدادات الماب) المحدثة بالكامل
local MapPage = AllPages["اعدادات الماب"]

-- أ. نظام تغيير ألوان السكريبت
local ColorBtn = Instance.new("TextButton", MapPage)
ColorBtn.Size = UDim2.new(0.9, 0, 0, 40)
ColorBtn.Position = UDim2.new(0.05, 0, 0, 10)
ColorBtn.Text = "تغيير لون السكريبت"
ColorBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
Instance.new("UICorner", ColorBtn)
local modes = {Color3.fromRGB(20, 20, 20), Color3.fromRGB(255, 255, 255), Color3.fromRGB(0, 100, 255), Color3.fromRGB(255, 200, 0)}
local currentMode = 1
ColorBtn.MouseButton1Click:Connect(function()
    currentMode = (currentMode % #modes) + 1
    MainFrame.BackgroundColor3 = modes[currentMode]
end)

-- ب. زر السطوع (نظام On/Off)
local FBEnabled = false
local FBButton = Instance.new("TextButton", MapPage)
FBButton.Size = UDim2.new(0.9, 0, 0, 40)
FBButton.Position = UDim2.new(0.05, 0, 0, 60)
FBButton.Text = "السطوع: مطفأ"
FBButton.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
Instance.new("UICorner", FBButton)

FBButton.MouseButton1Click:Connect(function()
    FBEnabled = not FBEnabled
    if FBEnabled then
        Lighting.Ambient = Color3.new(1, 1, 1)
        FBButton.Text = "السطوع: شغال"
        FBButton.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
    else
        Lighting.Ambient = Color3.new(0, 0, 0)
        FBButton.Text = "السطوع: مطفأ"
        FBButton.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
    end
end)

-- [6] منطق زر التصغير
ToggleBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)
