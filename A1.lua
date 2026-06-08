-- المطور الأسطوري أيهم - تصميم واجهة احترافي
local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- إنشاء الواجهة
local screenGui = Instance.new("ScreenGui", playerGui)
screenGui.Name = "RavenMilitaryUI"

-- الإطار الرئيسي
local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Size = UDim2.new(0, 500, 0, 300)
mainFrame.Position = UDim2.new(0.5, -250, 0.5, -150)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
mainFrame.BorderColor3 = Color3.fromRGB(255, 215, 0)
mainFrame.BorderSizePixel = 2
local frameCorner = Instance.new("UICorner", mainFrame) -- زوايا دائرية للإطار

-- العنوان العلوي
local title = Instance.new("TextLabel", mainFrame)
title.Size = UDim2.new(1, 0, 0, 30)
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
    local btn = Instance.new("TextButton", sideMenu)
    btn.Size = UDim2.new(1, 0, 0.16, 0)
    btn.Position = UDim2.new(0, 0, (i-1) * 0.2, 0)
    btn.BackgroundColor3 = Color3.fromRGB(200, 160, 0)
    btn.Text = "الأمر " .. (i == 1 and "الأول" or i == 2 and "الثاني" or i == 3 and "الثالث" or i == 4 and "الرابع" or "الخامس")
    btn.Font = Enum.Font.SourceSansBold
    local btnCorner = Instance.new("UICorner", btn) -- زوايا دائرية للأزرار
end

-- منطقة معلومات اللاعب (يمين)
local infoFrame = Instance.new("Frame", mainFrame)
infoFrame.Size = UDim2.new(0.6, 0, 0.85, 0)
infoFrame.Position = UDim2.new(0.38, 0, 0.12, 0)
infoFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
local infoCorner = Instance.new("UICorner", infoFrame) -- زوايا دائرية لمنطقة المعلومات

-- صورة اللاعب
local userImage = Instance.new("ImageLabel", infoFrame)
userImage.Size = UDim2.new(0.3, 0, 0.4, 0)
userImage.Position = UDim2.new(0.05, 0, 0.05, 0)
userImage.Image = game.Players:GetUserThumbnailAsync(player.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)
local imgCorner = Instance.new("UICorner", userImage) -- زوايا دائرية للصورة

-- نص الترحيب
local welcomeText = Instance.new("TextLabel", infoFrame)
welcomeText.Size = UDim2.new(0.9, 0, 0.5, 0)
welcomeText.Position = UDim2.new(0.05, 0, 0.45, 0)
welcomeText.Text = "مرحباً بك في واجهة أوامر ماب ريفن العسكرية الخاصة بالمطور الأسطوري أيهم!\nتصفح الشرائح (الأوامر) في القائمة الجانبية"
welcomeText.TextColor3 = Color3.fromRGB(255, 215, 0)
welcomeText.BackgroundTransparency = 1
welcomeText.TextWrapped = true
