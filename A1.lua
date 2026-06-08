-- [[ هيكل سكربت واجهة المستخدم (Roblox GUI Structure) ]]
-- [[ تم إنشاؤه بناءً على التصميم في الصور المرفقة ]]

-- 1. تعريف المتغيرات والخدمات الأساسية
local Player = game.Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- 2. إنشاء الواجهة الرسومية الرئيسية (ScreenGui)
local MainGui = Instance.new("ScreenGui")
MainGui.Name = "Aiham_Military_Menu_GUI"
MainGui.Parent = PlayerGui

-- 3. إنشاء الإطار الرئيسي (Main Frame) باللون الأسود
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 500, 0, 300) -- مقاس تقريبي مناسب
MainFrame.Position = UDim2.new(0.5, -250, 0.5, -150)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20) -- أسود غامق
MainFrame.Parent = MainGui

-- (إضافة تفاصيل الصورة الشخصية والنصوص "صنع من قبل..." كما في الصور)
-- [[ الكود الخاص بهذه العناصر الجمالية يتم وضعه هنا، ولكن تم حذفه للتركيز على الهيكل الوظيفي ]]

-- 4. إنشاء قائمة الأزرار الرئيسية (التبويبات) على اليمين
local TabsFrame = Instance.new("Frame")
TabsFrame.Name = "TabsFrame"
TabsFrame.Size = UDim2.new(0, 150, 1, 0)
TabsFrame.Position = UDim2.new(1, -150, 0, 0)
TabsFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30) -- لون خلفية أزرار التبويب
TabsFrame.Parent = MainFrame

-- 5. إنشاء لوحات المحتوى (المخفية) على اليسار
local PagesFrame = Instance.new("Frame")
PagesFrame.Name = "PagesFrame"
PagesFrame.Size = UDim2.new(1, -150, 1, 0)
PagesFrame.Position = UDim2.new(0, 0, 0, 0)
PagesFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
PagesFrame.Parent = MainFrame

-- [[ جدول لتخزين لوحات المحتوى لسهولة الوصول إليها ]]
local Pages = {}

-- 6. دالة لإنشاء القوائم الخمس وكل قائمة بها 5 أزرار قدرات
local function CreateMenuList()
	for i = 1, 5 do
		-- أ. إنشاء زر القائمة الرئيسي (الأصفر)
		local TabButton = Instance.new("TextButton")
		TabButton.Name = "Tab_Button_" .. i
		TabButton.Size = UDim2.new(0.9, 0, 0, 40)
		TabButton.Position = UDim2.new(0.05, 0, 0, (i-1)*50 + 10)
		TabButton.BackgroundColor3 = Color3.fromRGB(255, 215, 0) -- أصفر ذهبي كما في الصور
		TabButton.TextColor3 = Color3.fromRGB(0, 0, 0)
		TabButton.TextSize = 18
		TabButton.Text = "قائمة ميزة " .. i -- يمكنك تغيير الاسم
		TabButton.Parent = TabsFrame

		-- ب. إنشاء لوحة المحتوى المرتبطة بهذا الزر (تكون مخفية في البداية)
		local Page = Instance.new("Frame")
		Page.Name = "Page_" .. i
		Page.Size = UDim2.new(1, 0, 1, 0)
		Page.Position = UDim2.new(0, 0, 0, 0)
		Page.BackgroundColor3 = PagesFrame.BackgroundColor3
		Page.Visible = false
		Page.Parent = PagesFrame
		Pages[i] = Page -- تخزينها في الجدول

		-- ج. إنشاء 5 أزرار قدرات داخل هذه اللوحة (رمادية)
		for j = 1, 5 do
			local CapabilityButton = Instance.new("TextButton")
			CapabilityButton.Name = "Cap_" .. i .. "_" .. j
			CapabilityButton.Size = UDim2.new(0.8, 0, 0, 40)
			CapabilityButton.Position = UDim2.new(0.1, 0, 0, (j-1)*50 + 20)
			CapabilityButton.BackgroundColor3 = Color3.fromRGB(169, 169, 169) -- رمادي افتراضي
			CapabilityButton.TextColor3 = Color3.fromRGB(0, 0, 0)
			CapabilityButton.TextSize = 16
			CapabilityButton.Text = "قدرة " .. i .. "." .. j -- اسم مؤقت
			CapabilityButton.Parent = Page
		end
	end
end

-- 7. تشغيل الدالة لإنشاء العناصر
CreateMenuList()

-- 8. وظيفة التنقل بين القوائم (Tabs)
for i, button in pairs(TabsFrame:GetChildren()) do
	if button:IsA("TextButton") then
		button.MouseButton1Click:Connect(function()
			-- إخفاء جميع اللوحات أولاً
			for j, page in pairs(Pages) do
				page.Visible = false
			end
			-- إظهار اللوحة الخاصة بالزر الذي تم ضغطه
			Pages[i].Visible = true
		end
	end
end

-- ========================================================
-- [[ الجزء القادم هو مكان وضع القدرات ]]
-- ========================================================

-- دالة لتغيير لون الزر إلى الأخضر عند تفعيله
local function ToggleButtonColor(button, state)
	if state then
		button.BackgroundColor3 = Color3.fromRGB(0, 255, 0) -- أخضر ساطع
	else
		button.BackgroundColor3 = Color3.fromRGB(169, 169, 169) -- رمادي (اللون الأصلي)
	end
end

-- مثال لاستخدام هذه الدالة مع زر القدرة الأول في القائمة الأولى ( Cap_1_1 )
-- local Cap1_1_Active = false
-- Pages[1]["Cap_1_1"].MouseButton1Click:Connect(function()
--	Cap1_1_Active = not Cap1_1_Active -- عكس الحالة
--	ToggleButtonColor(Pages[1]["Cap_1_1"], Cap1_1_Active) -- تغيير اللون
--	-- [[ هنا تضع الكود الخاص بالقدرة ]]
--	if Cap1_1_Active then
--		print("تم تفعيل القدرة 1.1")
--	else
--		print("تم إيقاف القدرة 1.1")
--	end
-- end)

-- ========================================================
-- [[ نهاية الهيكل ]]
-- ========================================================
  
