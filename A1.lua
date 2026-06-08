-- المطور الأسطوري أيهم - تصميم واجهة احترافي
local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- إنشاء الواجهة
local screenGui = Instance.new("ScreenGui", playerGui)
screenGui.Name = "RavenMilitaryUI_Hidden"

-- الإطار الرئيسي (مخفي في البداية)
local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Size = UDim2.new(0, 500, 0, 300)
mainFrame.Position = UDim2.new(0.5, -250, 0.5, -150)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
mainFrame.BorderColor3 = Color3.fromRGB(255, 215, 0)
mainFrame.BorderSizePixel = 2
mainFrame.Visible = false -- اللوحة مخفية في البداية
local frameCorner = Instance.new("UICorner", mainFrame)

-- أيقونة الإخفاء الجديدة (في الزاوية العليا)
local hideBtnContainer = Instance.new("Frame", screenGui)
hideBtnContainer.Size = UDim2.new(0, 40, 0, 40)
hideBtnContainer.Position = UDim2.new(0, 55, 0, 100) -- الموقع التقريبي للمربع الأحمر
hideBtnContainer.BackgroundColor3 = Color3.fromRGB(30, 30, 30) -- لون الخلفية للأيقونات الأخرى
local hideIcon = Instance.new("ImageLabel", hideBtnContainer)
hideIcon.Size = UDim2.new(0.8, 0, 0.8, 0)
hideIcon.Position = UDim2.new(0.1, 0, 0.1, 0)
hideIcon.Image = "rbxassetid://6031763421" -- أيقونة عين سوداء
hideIcon.ImageColor3 = Color3.new(0,0,0) -- جعل الأيقونة سوداء
hideIcon.BackgroundTransparency = 1
Instance.new("UICorner", hideBtnContainer, {CornerRadius = UDim.new(0, 20)})

local hideBtn = Instance.new("TextButton", hideBtnContainer)
hideBtn.Size = UDim2.new(1, 0, 1, 0)
hideBtn.BackgroundTransparency = 1
hideBtn.Text = ""

-- أيقونة الإظهار (في أسفل يسار الشاشة)
local showBtnContainer = Instance.new("Frame", screenGui)
showBtnContainer.Size = UDim2.new(0, 40, 0, 40)
showBtnContainer.Position = UDim2.new(0, 10, 1, -50) -- الموقع التقريبي لزر "إظهار" مخفي
showBtnContainer.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
local showIcon = Instance.new("ImageLabel", showBtnContainer)
showIcon.Size = UDim2.new(0.8, 0, 0.8, 0)
showIcon.Position = UDim2.new(0.1, 0, 0.1, 0)
showIcon.Image = "rbxassetid://6031763421"
showIcon.ImageColor3 = Color3.new(0,0,0)
showIcon.BackgroundTransparency = 1
Instance.new("UICorner", showBtnContainer, {CornerRadius = UDim.new(0, 20)})

local showBtn = Instance.new("TextButton", showBtnContainer)
showBtn.Size = UDim2.new(1, 0, 1, 0)
showBtn.BackgroundTransparency = 1
showBtn.Text = ""

-- وظيفة الإخفاء (تخفي اللوحة والأيقونة)
hideBtn.MouseButton1Click:Connect(function()
	mainFrame.Visible = false
	hideBtnContainer.Visible = false
	showBtnContainer.Visible = true -- إظهار زر الإظهار
end)

-- وظيفة الإظهار (تظهر اللوحة والأيقونة مرة أخرى)
showBtn.MouseButton1Click:Connect(function()
	mainFrame.Visible = true
	hideBtnContainer.Visible = true
	showBtnContainer.Visible = false -- إخفاء زر الإظهار
end)

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
