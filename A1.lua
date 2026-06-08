-- المطور: المطور الأسطوري أيهم
-- الوصف: واجهة مخصصة لماب ريفن العسكرية

local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- إنشاء الحاوية الرئيسية
local screenGui = Instance.new("ScreenGui", playerGui)
screenGui.Name = "RavenMilitaryUI"

-- إنشاء إطار التجمع (Frame)
local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Size = UDim2.new(0, 200, 0, 300)
mainFrame.Position = UDim2.new(0.05, 0, 0.5, -150)
mainFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 0) -- اللون الأصفر
mainFrame.BorderSizePixel = 2

-- إضافة عنوان الحقوق
local title = Instance.new("TextLabel", mainFrame)
title.Size = UDim2.new(1, 0, 0, 40)
title.Text = "صنع من قبل المطور الأسطوري أيهم"
title.TextScaled = true
title.BackgroundColor3 = Color3.fromRGB(200, 200, 0)

-- دالة لإنشاء الأزرار الـ 5
for i = 1, 5 do
    local button = Instance.new("TextButton", mainFrame)
    button.Size = UDim2.new(0.8, 0, 0, 40)
    button.Position = UDim2.new(0.1, 0, 0, 50 + (i * 45))
    button.Text = "الزر رقم " .. i
    button.BackgroundColor3 = Color3.fromRGB(255, 255, 255) -- أبيض لتباين الأزرار
    button.Font = Enum.Font.SourceSansBold
end
