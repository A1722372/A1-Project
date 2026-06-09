-- سكريبت أيهم الأسطوري V12 - تحديث التمرير وزر الإخفاء
local Player = game.Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- تنظيف النسخ السابقة
if PlayerGui:FindFirstChild("AihamSuperMenu") then PlayerGui.AihamSuperMenu:Destroy() end

local ScreenGui = Instance.new("ScreenGui", PlayerGui)
ScreenGui.Name = "AihamSuperMenu"

-- زر الإخفاء (الأيقونة)
local ToggleButton = Instance.new("ImageButton", ScreenGui) -- يمكنك استبداله بـ TextButton إذا أردت
ToggleButton.Size = UDim2.new(0, 50, 0, 50)
ToggleButton.Position = UDim2.new(0, 20, 0.5, -25)
ToggleButton.BackgroundColor3 = Color3.fromRGB(255, 200, 0)
ToggleButton.Text = "MENU"
ToggleButton.Font = Enum.Font.SourceSansBold
ToggleButton.Active = true
ToggleButton.Draggable = true -- يمكنك تحريك زر الإخفاء في الشاشة
ToggleButton.Layer = 1

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 500, 0, 400)
MainFrame.Position = UDim2.new(0.5, -250, 0.5, -200)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.Visible = false -- يبدأ مخفياً

-- وظيفة زر الإخفاء
ToggleButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

-- القائمة الجانبية (تم تفعيل ScrollBar)
local SideMenu = Instance.new("ScrollingFrame", MainFrame)
SideMenu.Size = UDim2.new(0, 140, 1, 0)
SideMenu.CanvasSize = UDim2.new(0, 0, 2, 0) -- مساحة كافية للتمرير
SideMenu.ScrollBarThickness = 6
SideMenu.BackgroundColor3 = Color3.fromRGB(15, 15, 15)

-- منطقة المحتوى (تم تفعيل ScrollBar)
local ContentArea = Instance.new("Frame", MainFrame)
ContentArea.Size = UDim2.new(1, -140, 1, 0)
ContentArea.Position = UDim2.new(0, 140, 0, 0)
ContentArea.BackgroundTransparency = 1

-- دالة إنشاء الصفحات مع خاصية Scroll
local function createPage()
    local page = Instance.new("ScrollingFrame", ContentArea)
    page.Size = UDim2.new(1, 0, 1, 0)
    page.CanvasSize = UDim2.new(0, 0, 2, 0) -- لجعل الصفحة قابلة للتمرير
    page.ScrollBarThickness = 8
    page.BackgroundTransparency = 1
    page.Visible = false
    return page
end

-- تجربة بناء القوائم
local tabs = {"اعدادات الماب", "اللاعب", "الاستهداف", "التأثيرات", "الأنيميشن", "إضافات", "معلومات"}
for i, name in ipairs(tabs) do
    local btn = Instance.new("TextButton", SideMenu)
    btn.Size = UDim2.new(0.9, 0, 0, 40)
    btn.Position = UDim2.new(0.05, 0, 0, (i-1) * 45 + 5)
    btn.Text = name
    btn.BackgroundColor3 = Color3.fromRGB(255, 200, 0)
    
    local page = createPage()
    btn.MouseButton1Click:Connect(function()
        for _, child in pairs(ContentArea:GetChildren()) do
            if child:IsA("ScrollingFrame") then child.Visible = false end
        end
        page.Visible = true
    end)
end
