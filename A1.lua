-- إنشاء الـ UI الأساسي
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AnxamScript_V2"
ScreenGui.ResetOnSpawn = false

-- التأكد من التشغيل المحمي على الـ Executors
pcall(function()
    ScreenGui.Parent = game:GetService("CoreGui")
end)
if not ScreenGui.Parent then
    ScreenGui.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
end

-- اللوحة الرئيسية (مثبتة ومتناسقة للموبايل)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 550, 0, 320) -- حجم مدروس ومناسب لشاشات الموبايل
MainFrame.Position = UDim2.new(0.5, -275, 0.5, -160) -- التثبيت في المنتصف تماماً
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.BorderSizePixel = 0
MainFrame.Visible = true
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = MainFrame

-- القائمة الجانبية للأقسام (Sidebar)
local Sidebar = Instance.new("Frame")
Sidebar.Name = "Sidebar"
Sidebar.Size = UDim2.new(0, 160, 1, -20)
Sidebar.Position = UDim2.new(0, 10, 0, 10)
Sidebar.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
Sidebar.BorderSizePixel = 0
Sidebar.Parent = MainFrame

local SidebarCorner = Instance.new("UICorner")
SidebarCorner.CornerRadius = UDim.new(0, 8)
SidebarCorner.Parent = Sidebar

local SidebarList = Instance.new("UIListLayout")
SidebarList.Parent = Sidebar
SidebarList.Padding = UDim.new(0, 6)
SidebarList.HorizontalAlignment = Enum.HorizontalAlignment.Center
SidebarList.SortOrder = Enum.SortOrder.LayoutOrder

local SidebarPadding = Instance.new("UIPadding")
SidebarPadding.Parent = Sidebar
SidebarPadding.PaddingTop = UDim.new(0, 10)

-- منطقة عرض المحتوى (يمين السكريبت)
local ContentContainer = Instance.new("Frame")
ContentContainer.Name = "ContentContainer"
ContentContainer.Size = UDim2.new(1, -190, 1, -20)
ContentContainer.Position = UDim2.new(0, 180, 0, 10)
ContentContainer.BackgroundTransparency = 1
ContentContainer.Parent = MainFrame

-- جدول لحفظ صفحات الأقسام
local Pages = {}

-- دالة لإنشاء قسم جديد
local function CreateCategory(name, layoutOrder)
    -- زر القسم في القائمة الجانبية
    local Button = Instance.new("TextButton")
    Button.Name = name .. "Btn"
    Button.Size = UDim2.new(0.9, 0, 0, 38)
    Button.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    Button.TextColor3 = Color3.fromRGB(230, 230, 230)
    Button.TextSize = 14
    Button.Font = Enum.Font.SourceSansBold
    Button.Text = name
    Button.LayoutOrder = layoutOrder
    Button.Parent = Sidebar

    local BtnCorner = Instance.new("UICorner")
    BtnCorner.CornerRadius = UDim.new(0, 6)
    BtnCorner.Parent = Button

    -- صفحة المحتوى المقابلة للقسم
    local Page = Instance.new("ScrollingFrame")
    Page.Name = name .. "Page"
    Page.Size = UDim2.new(1, 0, 1, 0)
    Page.BackgroundTransparency = 1
    Page.BorderSizePixel = 0
    Page.ScrollBarThickness = 4
    Page.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 100)
    Page.Visible = false
    Page.Parent = ContentContainer

    local PageList = Instance.new("UIListLayout")
    PageList.Parent = Page
    PageList.Padding = UDim.new(0, 8)
    PageList.HorizontalAlignment = Enum.HorizontalAlignment.Center
    PageList.SortOrder = Enum.SortOrder.LayoutOrder

    Pages[name] = Page

    -- نظام التنقل عند الضغط
    Button.MouseButton1Click:Connect(function()
        for _, p in pairs(Pages) do
            p.Visible = false
        end
        Page.Visible = true
        
        -- تأثير بصري خفيف للزر النشط
        for _, btn in pairs(Sidebar:GetChildren()) do
            if btn:IsA("TextButton") then
                btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
            end
        end
        Button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    end)

    return Page
end

-- إنشاء الأقسام الستة المذكورة في صورتك بالترتيب
local SettingsPage   = CreateCategory("إعدادات اللاعب", 1)
local PlayerPage     = CreateCategory("اللاعب", 2)
local TargetPage     = CreateCategory("الاستهداف", 3)
local EffectsPage    = CreateCategory("التأثيرات", 4)
local SavesPage      = CreateCategory("المحفوظات", 5)
local MilitaryPage   = CreateCategory("العسكرية 🎖️", 6)

-- فتح صفحة "اللاعب" تلقائياً كصفحة رئيسية عند التشغيل
Pages["اللاعب"].Visible = true

---------------------------------------------------------
-- دالة مخصصة لإنشاء أزرار الميزات (مثل التي في الصورة)
---------------------------------------------------------
local function CreateFeatureButton(parentPage, text, color, layoutOrder)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(0.95, 0, 0, 42)
    Btn.BackgroundColor3 = color or Color3.fromRGB(55, 55, 55)
    Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    Btn.TextSize = 15
    Btn.Font = Enum.Font.SourceSansBold
    Btn.Text = text
    Btn.LayoutOrder = layoutOrder
    Btn.Parent = parentPage

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 6)
    Corner.Parent = Btn
    
    return Btn
end

-- إضافة الميزات الموضحة في صورتك داخل قسم "اللاعب"
CreateFeatureButton(PlayerPage, "قفز لا نهائي", Color3.fromRGB(55, 55, 55), 1)
CreateFeatureButton(PlayerPage, "اختراق الجدران", Color3.fromRGB(55, 55, 55), 2)
CreateFeatureButton(PlayerPage, "تفعيل الطيران (Fly V3)", Color3.fromRGB(14, 110, 200), 3) -- باللون الأزرق كالصورة
CreateFeatureButton(PlayerPage, "إعادة رسون فوري (Instant Reset)", Color3.fromRGB(150, 30, 30), 4) -- باللون الأحمر كالصورة
CreateFeatureButton(PlayerPage, "الجاذبية: طبيعية", Color3.fromRGB(55, 55, 55), 5)

---------------------------------------------------------
-- زر الإخفاء والظهار العائم (Toggle Button)
---------------------------------------------------------
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Name = "ToggleBtn"
ToggleBtn.Size = UDim2.new(0, 45, 0, 45)
ToggleBtn.Position = UDim2.new(0, 15, 0, 15) -- يظهر أعلى اليسار بعيداً عن أزرار اللعبة
ToggleBtn.BackgroundColor3 = Color3.fromRGB(150, 30, 30)
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.TextSize = 12
ToggleBtn.Font = Enum.Font.SourceSansBold
ToggleBtn.Text = "إخفاء"
ToggleBtn.Parent = ScreenGui

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(1, 0) -- دائري تماماً
ToggleCorner.Parent = ToggleBtn

-- برمجة الاختفاء والظهار للوحة الرئيسية
ToggleBtn.MouseButton1Click:Connect(function()
    if MainFrame.Visible then
        MainFrame.Visible = false
        ToggleBtn.Text = "إظهار"
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(14, 110, 200)
    else
        MainFrame.Visible = true
        ToggleBtn.Text = "إخفاء"
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(150, 30, 30)
    end
end)
