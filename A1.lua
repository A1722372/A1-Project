-- [[ سكريبت أيهم الأسطوري - النسخة V44 (إصلاح الألوان والكلتش) ]]
local Player = game.Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")
local RunService = game:GetService("RunService")

-- تنظيف شامل
if PlayerGui:FindFirstChild("AihamScript_Main") then PlayerGui.AihamScript_Main:Destroy() end

local ScreenGui = Instance.new("ScreenGui", PlayerGui)
ScreenGui.Name = "AihamScript_Main"
ScreenGui.ResetOnSpawn = false

-- الإطار الرئيسي (خلفية داكنة ثابتة)
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 400, 0, 350)
MainFrame.Position = UDim2.new(0.5, -200, 0.5, -175)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30) -- لون رمادي غامق لضمان التباين
Instance.new("UICorner", MainFrame)

-- إصلاح ألوان القائمة الجانبية (لضمان ظهور الكتابة)
local SideMenu = Instance.new("ScrollingFrame", MainFrame)
SideMenu.Size = UDim2.new(0, 120, 1, 0)
SideMenu.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Instance.new("UICorner", SideMenu)

-- وظيفة إنشاء أزرار بوضوح عالي
local function CreateMenuBtn(name, position, parent)
    local btn = Instance.new("TextButton", parent)
    btn.Size = UDim2.new(0.9, 0, 0, 40)
    btn.Position = position
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(255, 255, 255) -- لون الخط أبيض ليكون واضحاً
    btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50) -- لون الزر رمادي فاتح
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 16
    Instance.new("UICorner", btn)
    return btn
end

-- تطبيق الإصلاح على القوائم
local MenuConfig = {"اعدادات الماب", "اللاعب"}
for i, name in ipairs(MenuConfig) do
    CreateMenuBtn(name, UDim2.new(0.05, 0, 0, (i-1) * 45 + 5), SideMenu)
end

-- إصلاح زر الطيران (Fly V3) في تبويب اللاعب
local PlayerPage = Instance.new("Frame", MainFrame)
PlayerPage.Size = UDim2.new(1, -120, 1, 0)
PlayerPage.Position = UDim2.new(0, 120, 0, 0)
PlayerPage.BackgroundTransparency = 1

local FlyV3Btn = CreateMenuBtn("تفعيل الطيران (Fly V3)", UDim2.new(0.05, 0, 0, 210), PlayerPage)
FlyV3Btn.BackgroundColor3 = Color3.fromRGB(0, 120, 255) -- أزرق للتمييز
FlyV3Btn.MouseButton1Click:Connect(function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/XNEOFF/FlyGuiV3/main/FlyGuiV3.txt"))()
end)

-- إضافة زر لتصحيح ألوان الواجهة يدوياً إذا حدث كلتش
local FixBtn = CreateMenuBtn("إصلاح الألوان", UDim2.new(0.05, 0, 0, 260), PlayerPage)
FixBtn.MouseButton1Click:Connect(function()
    for _, obj in pairs(MainFrame:GetDescendants()) do
        if obj:IsA("TextButton") or obj:IsA("TextBox") then
            obj.TextColor3 = Color3.fromRGB(255, 255, 255)
        end
    end
end)
