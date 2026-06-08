-- المطور الأسطوري أيهم - سكربت ماب ريفن العسكرية الكامل
local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- إنشاء الواجهة الرئيسية
local screenGui = Instance.new("ScreenGui", playerGui)
screenGui.Name = "RavenMilitaryUI"

-- الإطار الرئيسي
local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Size = UDim2.new(0, 500, 0, 300)
mainFrame.Position = UDim2.new(0.5, -250, 0.5, -150)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
mainFrame.BorderColor3 = Color3.fromRGB(255, 215, 0)
mainFrame.BorderSizePixel = 2
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 8)

-- زر الإخفاء (الأيقونة الصغيرة في الزاوية)
local toggleButton = Instance.new("ImageButton", mainFrame)
toggleButton.Size = UDim2.new(0, 30, 0, 30)
toggleButton.Position = UDim2.new(1, -35, 0, 5)
toggleButton.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
toggleButton.Image = "rbxassetid://10481232822" -- أيقونة القفل
toggleButton.ImageColor3 = Color3.fromRGB(255, 215, 0)
toggleButton.BorderSizePixel = 0
Instance.new("UICorner", toggleButton).CornerRadius = UDim.new(1, 0)

-- دالة الإخفاء/الإظهار
local isVisible = true
toggleButton.MouseButton1Click:Connect(function()
    isVisible = not isVisible
    for _, child in pairs(mainFrame:GetChildren()) do
        if child ~= toggleButton then
            child.Visible = isVisible
        end
    end
end)

-- العنوان العلوي
local title = Instance.new("TextLabel", mainFrame)
title.Size = UDim2.new(1, -40, 0, 30)
title.Text = "صنع من قبل المطور الأسطوري أيهم"
title.TextColor3 = Color3.fromRGB(255, 215, 0)
title.BackgroundTransparency = 1
title.Font = Enum.Font.SourceSansBold
title.TextSize = 18

-- القائمة الجانبية
local sideMenu = Instance.new("Frame", mainFrame)
sideMenu.Size = UDim2.new(0.35, 0, 0.85, 0)
sideMenu.Position = UDim2.new(0.02, 0, 0.12, 0)
sideMenu.BackgroundTransparency = 1

for i = 1, 5 do
    
