-- [[ سكربت تشغيل الواجهة والأزرار - يتم وضعه داخل LocalScript ]]

local Player = game.Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- إنشاء الواجهة بشكل يضمن ظهورها على الشاشة فوراً
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AihamCommands"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = PlayerGui

-- الإطار الرئيسي للسكربت (باللون الأسود الغامق)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 550, 0, 350)
MainFrame.Position = UDim2.new(0.5, -275, 0.5, -175)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.BorderSizePixel = 2
MainFrame.BorderColor3 = Color3.fromRGB(255, 215, 0) -- إطار ذهبي خفيف
MainFrame.Parent = ScreenGui

-- عنوان الواجهة (صنع من قبل المطور الأسطوري أيهم)
local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, 0, 0, 40)
TitleLabel.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
TitleLabel.Text = "صنع من قبل المطور الأسطوري أيهم"
TitleLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
TitleLabel.TextSize = 20
TitleLabel.Font = Enum.Font.SourceSansBold
TitleLabel.Parent = MainFrame

-- قائمة الأزرار الصفراء (اليمين)
local SideMenu = Instance.new("Frame")
SideMenu.Size = UDim2.new(0, 160, 1, -40)
SideMenu.Position = UDim2.new(0, 0, 0, 40)
SideMenu.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
SideMenu.Parent = MainFrame

-- منطقة عرض القدرات (اليسار)
local ContentArea = Instance.new("Frame")
ContentArea.Size = UDim2.new(1, -160, 1, -40)
ContentArea.Position = UDim2.new(0, 160, 0, 40)
ContentArea.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
ContentArea.Parent = MainFrame

-- الجداول لتخزين القوائم والقدرات
local Menus = {}
local CurrentMenu = nil

-- أسماء القوائم الخمسة كما في تصميمك
local menuNames = {"قائمة الماب", "القفز", "التحية", "الأسلحة", "الجلوس"}

-- دالة لتغيير حالة ولون زر القدرة
local function setupAbilityButton(button)
	local isActive = false
	button.MouseButton1Click:Connect(function()
		isActive = not isActive
		if isActive then
			button.BackgroundColor3 = Color3.fromRGB(0, 255, 0) -- يضوي بالأخضر عند التفعيل
			button.TextColor3 = Color3.fromRGB(0, 0, 0)
			-- [[ هنا سنضع كود القدرة لاحقاً ]]
			print("تم تفعيل: " .. button.Text)
		else
			button.BackgroundColor3 = Color3.fromRGB(200, 200, 200) -- يعود للرمادي عند الإطفاء
			button.TextColor3 = Color3.fromRGB(0, 0, 0)
			-- [[ هنا سنضع كود إيقاف القدرة لاحقاً ]]
			print("تم تعطيل: " .. button.Text)
		end
	end)
end

-- إنشاء القوائم والأزرار تلقائياً لتجنب الأخطاء
for i = 1, 5 do
	-- 1. إنشاء الزر الأصفر على اليمين
	local MenuButton = Instance.new("TextButton")
	MenuButton.Size = UDim2.new(0.9, 0, 0, 45)
	MenuButton.Position = UDim2.new(0.05, 0, 0, (i-1) * 55 + 10)
	MenuButton.BackgroundColor3 = Color3.fromRGB(220, 180, 0) -- اللون الأصفر الظاهر بالصورة
	MenuButton.Text = menuNames[i]
	MenuButton.TextColor3 = Color3.fromRGB(0, 0, 0)
	MenuButton.Font = Enum.Font.SourceSansBold
	MenuButton.TextSize = 16
	MenuButton.Parent = SideMenu

	-- 2. إنشاء لوحة القدرات الخاصة بهذا الزر (تكون مخفية)
	local AbilityFrame = Instance.new("Frame")
	AbilityFrame.Size = UDim2.new(1, 0, 1, 0)
	AbilityFrame.BackgroundTransparency = 1
	AbilityFrame.Visible = false
	AbilityFrame.Parent = ContentArea
	Menus[i] = AbilityFrame

	-- 3. إنشاء 5 أزرار داخل كل قائمة
	for j = 1, 5 do
		local AbilityButton = Instance.new("TextButton")
		AbilityButton.Size = UDim2.new(0.9, 0, 0, 40)
		AbilityButton.Position = UDim2.new(0.05, 0, 0, (j-1) * 50 + 15)
		AbilityButton.BackgroundColor3 = Color3.fromRGB(200, 200, 200) -- رمادي افتراضي
		AbilityButton.Text = menuNames[i] .. " - ميزة " .. j
		AbilityButton.TextColor3 = Color3.fromRGB(0, 0, 0)
		AbilityButton.Font = Enum.Font.SourceSans
		AbilityButton.TextSize = 16
		AbilityButton.Parent = AbilityFrame
		
		-- تفعيل ميزة الإضاءة الخضراء للزر
		setupAbilityButton(AbilityButton)
	end

	-- ربط الزر الأصفر بإظهار قائمته وإخفاء الباقي
	MenuButton.MouseButton1Click:Connect(function()
		if CurrentMenu then CurrentMenu.Visible = false end
		AbilityFrame.Visible = true
		CurrentMenu = AbilityFrame
	end)
end

-- إظهار القائمة الأولى بشكل تلقائي عند الفتح
Menus[1].Visible = true
CurrentMenu = Menus[1]
