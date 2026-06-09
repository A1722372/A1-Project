-- [[ سكريبت أيهم الأسطوري - النسخة V35 - التعديلات النهائية لصفحة الماب ]]
local Player = game.Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")
local Lighting = game:GetService("Lighting")

-- تنظيف أي نسخة سابقة
if PlayerGui:FindFirstChild("AihamScript_Main") then
    PlayerGui.AihamScript_Main:Destroy()
end

-- [1] الحاوية
local ScreenGui = Instance.new("ScreenGui", PlayerGui)
ScreenGui.Name = "AihamScript_Main"
ScreenGui.ResetOnSpawn = false
ScreenGui.DisplayOrder = 2147483647 

-- [2] زر التحكم (المربع)
local ToggleBtn = Instance.new("TextButton", ScreenGui)
ToggleBtn.Size = UDim2.new(0, 50, 0, 50)
ToggleBtn.Position = UDim2.new(0.9, -60, 0.1, 0)
ToggleBtn.Text = "■" 
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 0)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
ToggleBtn.TextSize = 30
ToggleBtn.Draggable = true
ToggleBtn.ZIndex = 100
Instance.new("UICorner", ToggleBtn)

-- [3] الإطار الرئيسي
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 400, 0, 300)
MainFrame.Position = UDim2.new(0.5, -200, 0.5, -150)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true 
MainFrame.Draggable = true
Instance.new("UICorner", MainFrame)

-- [4] التبويبات (كما كانت)
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

-- [5] الميزات (إعدادات الماب) المحدثة حسب طلبك
local MapPage = AllPages["اعدادات الماب"]

-- زر السطوع (الموجود مسبقاً)
local FBEnabled = false
local FBButton = Instance.new("TextButton", MapPage)
FBButton.Size = UDim2.new(0.9, 0, 0, 40)
FBButton.Position = UDim2.new(0.05, 0, 0, 10)
FBButton.Text = "السطوع: مطفأ"
FBButton.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
Instance.new("UICorner", FBButton)

FBButton.MouseButton1Click:Connect(function()
    FBEnabled = not FBEnabled
    Lighting.Ambient = FBEnabled and Color3.new(1, 1, 1) or Color3.new(0, 0, 0)
    FBButton.Text = FBEnabled and "السطوع: شغال" or "السطوع: مطفأ"
    FBButton.BackgroundColor3 = FBEnabled and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(150, 0, 0)
end)

-- زر الشادر (المستطيل العلوي)
local ShaderBtn = Instance.new("TextButton", MapPage)
ShaderBtn.Size = UDim2.new(0.9, 0, 0, 40)
ShaderBtn.Position = UDim2.new(0.05, 0, 0, 60)
ShaderBtn.Text = "تفعيل شادر جودة الإضاءة"
ShaderBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
Instance.new("UICorner", ShaderBtn)

ShaderBtn.MouseButton1Click:Connect(function()
    Lighting.Brightness = 3
    Lighting.ClockTime = 12
    ShaderBtn.Text = "تم تفعيل الشادر!"
end)

-- المربع الكبير (معلوماتك وديسكورد)
local InfoBox = Instance.new("TextLabel", MapPage)
InfoBox.Size = UDim2.new(0.9, 0, 0, 100)
InfoBox.Position = UDim2.new(0.05, 0, 0, 110)
InfoBox.Text = "تم صناعة هذا السكربت بواسطة anxam\n\nرابط الديسكورد:\nhttps://discord.gg/7rRwEm3bjx"
InfoBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
InfoBox.TextColor3 = Color3.new(1, 1, 1)
InfoBox.TextWrapped = true
Instance.new("UICorner", InfoBox)

-- [6] منطق الإخفاء
ToggleBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)
