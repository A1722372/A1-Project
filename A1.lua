-- [[ سكريبت أيهم الأسطوري - النسخة الأصلية (كما في 1000001034.jpg) ]]

local Player = game.Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")
local Lighting = game:GetService("Lighting")

if PlayerGui:FindFirstChild("AihamScript_Main") then PlayerGui.AihamScript_Main:Destroy() end

local ScreenGui = Instance.new("ScreenGui", PlayerGui)
ScreenGui.Name = "AihamScript_Main"

-- الإطار الرئيسي
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 450, 0, 350)
MainFrame.Position = UDim2.new(0.5, -225, 0.5, -175)
MainFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", MainFrame)

-- القائمة الجانبية السوداء
local SideMenu = Instance.new("Frame", MainFrame)
SideMenu.Size = UDim2.new(0, 150, 1, 0)
SideMenu.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Instance.new("UICorner", SideMenu)

-- القوائم (الأسماء)
local MenuItems = {"اعدادات الماب", "اللاعب", "الاستهداف", "التأثيرات", "المحفوظات", "العسكرية 🎖️"}
for i, name in ipairs(MenuItems) do
    local btn = Instance.new("TextButton", SideMenu)
    btn.Size = UDim2.new(0.9, 0, 0, 45)
    btn.Position = UDim2.new(0.05, 0, 0, (i-1) * 50 + 10)
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    Instance.new("UICorner", btn)
end

-- المنطقة البيضاء (المحتوى)
local ContentArea = Instance.new("Frame", MainFrame)
ContentArea.Size = UDim2.new(1, -150, 1, 0)
ContentArea.Position = UDim2.new(0, 150, 0, 0)
ContentArea.BackgroundTransparency = 1

-- زر الشادر
local ShaderBtn = Instance.new("TextButton", ContentArea)
ShaderBtn.Size = UDim2.new(0.9, 0, 0, 50)
ShaderBtn.Position = UDim2.new(0.05, 0, 0, 70)
ShaderBtn.Text = "تفعيل الشادر"
ShaderBtn.BackgroundColor3 = Color3.fromRGB(180, 0, 0) -- الأحمر كما في الصورة
ShaderBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", ShaderBtn)

-- التوقيع (صنع بواسطة أيهم)
local Credits = Instance.new("TextLabel", ContentArea)
Credits.Size = UDim2.new(0.9, 0, 0, 30)
Credits.Position = UDim2.new(0.05, 0, 0, 20)
Credits.Text = "صنع بواسطة أيهم"
Credits.BackgroundTransparency = 1
Credits.TextColor3 = Color3.fromRGB(0, 0, 0)

-- زر تغيير لون القائمة
local ColorBtn = Instance.new("TextButton", ContentArea)
ColorBtn.Size = UDim2.new(0.8, 0, 0, 40)
ColorBtn.Position = UDim2.new(0.1, 0, 0, 20)
ColorBtn.Text = "تغيير لون القائمة"
ColorBtn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
ColorBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", ColorBtn)
