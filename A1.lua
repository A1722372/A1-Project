-- [[ سكريبت أيهم الأسطوري - النسخة V30 - إصلاح شامل ]]
local Player = game.Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")
local Lighting = game:GetService("Lighting")

-- [1] إنشاء الحاوية (ZIndex عالي جداً لضمان الظهور)
local ScreenGui = Instance.new("ScreenGui", PlayerGui)
ScreenGui.Name = "AihamScript_Main"
ScreenGui.ResetOnSpawn = false
ScreenGui.DisplayOrder = 999999 -- رقم ضخم ليبقى فوق كل شيء

-- [2] زر التصغير (الأيقونة)
local ToggleBtn = Instance.new("ImageButton", ScreenGui)
ToggleBtn.Size = UDim2.new(0, 50, 0, 50)
ToggleBtn.Position = UDim2.new(0.9, -60, 0.1, 0)
ToggleBtn.BackgroundTransparency = 1
ToggleBtn.Image = "rbxassetid://18563336718"
ToggleBtn.Draggable = true
ToggleBtn.ZIndex = 10 -- تأكد من أن الزر يظهر دائماً

-- [3] الإطار الرئيسي
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 500, 0, 350)
MainFrame.Position = UDim2.new(0.5, -250, 0.5, -175)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true 
MainFrame.Draggable = true
MainFrame.Visible = true -- يبدأ ظاهراً
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)

-- [4] التبويبات والمحتوى
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
    page.BackgroundTransparency = 1
    page.Visible = (i == 1)
    AllPages[name] = page
    
    btn.MouseButton1Click:Connect(function()
        for _, p in pairs(AllPages) do p.Visible = false end
        page.Visible = true
    end)
end

-- [5] الميزات (إعدادات الماب)
local MapPage = AllPages["اعدادات الماب"]

-- أ. زر تغيير الألوان (تم إصلاحه)
local ColorBtn = Instance.new("TextButton", MapPage)
ColorBtn.Size = UDim2.new(0.9, 0, 0, 40)
ColorBtn.Position = UDim2.new(0.05, 0, 0, 10)
ColorBtn.Text = "تغيير لون القائمة"
ColorBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
Instance.new("UICorner", ColorBtn)

local colorList = {Color3.fromRGB(20, 20, 20), Color3.fromRGB(255, 255, 255), Color3.fromRGB(0, 100, 255), Color3.fromRGB(255, 200, 0)}
local colorIndex = 1
ColorBtn.MouseButton1Click:Connect(function()
    colorIndex = (colorIndex % #colorList) + 1
    MainFrame.BackgroundColor3 = colorList[colorIndex]
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

-- [6] منطق زر الصورة (الإظهار والإخفاء)
ToggleBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)
