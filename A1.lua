-- [[ سكريبت أيهم الأسطوري - الهيكل المفتوح (V19) ]]
local Player = game.Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")
local RunService = game:GetService("RunService")

-- جدول الشرائح المفتوح: أضف أي اسم هنا، وسينشئ السكريبت الزر والصفحة فوراً
local MenuConfig = {
    "اعدادات الماب",
    "اللاعب",
    "الاستهداف",
    "التأثيرات",
    "المحفوظات",
    "تعريف السيرفر",
    "العسكرية 🎖️",
    "إضافة 8", -- يمكنك إضافة أي عدد تشاء
    "إضافة 9"
}

-- [إنشاء الواجهة الرئيسية]
local ScreenGui = Instance.new("ScreenGui", PlayerGui)
ScreenGui.Name = "AihamMenuV19"
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 500, 0, 350)
MainFrame.Position = UDim2.new(0.5, -250, 0.5, -175)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.Active = true MainFrame.Draggable = true

-- [قائمة الأزرار الديناميكية]
local SideMenu = Instance.new("ScrollingFrame", MainFrame)
SideMenu.Size = UDim2.new(0, 140, 1, 0)
SideMenu.CanvasSize = UDim2.new(0, 0, 0, #MenuConfig * 45) -- تتمدد تلقائياً حسب عدد الشرائح
SideMenu.ScrollBarThickness = 4
SideMenu.BackgroundColor3 = Color3.fromRGB(15, 15, 15)

-- [منطقة عرض المحتوى]
local ContentArea = Instance.new("Frame", MainFrame)
ContentArea.Size = UDim2.new(1, -140, 1, 0)
ContentArea.Position = UDim2.new(0, 140, 0, 0)
ContentArea.BackgroundTransparency = 1

local AllPages = {}

-- [بناء الشرائح تلقائياً]
for i, name in ipairs(MenuConfig) do
    -- إنشاء زر لكل شريحة
    local btn = Instance.new("TextButton", SideMenu)
    btn.Size = UDim2.new(0.9, 0, 0, 40)
    btn.Position = UDim2.new(0.05, 0, 0, (i-1) * 45 + 5)
    btn.Text = name
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    
    -- إنشاء الصفحة الخاصة بكل زر
    local page = Instance.new("ScrollingFrame", ContentArea)
    page.Size = UDim2.new(1, 0, 1, 0)
    page.BackgroundTransparency = 1
    page.Visible = (i == 1) -- تظهر أول شريحة فقط
    AllPages[name] = page
    
    btn.MouseButton1Click:Connect(function()
        for _, p in pairs(AllPages) do p.Visible = false end
        page.Visible = true
    end)
end

-- [مثال لكيفية إضافة محتوى لأي صفحة لاحقاً]
local function addContent(pageName, element)
    if AllPages[pageName] then
        element.Parent = AllPages[pageName]
    end
end
