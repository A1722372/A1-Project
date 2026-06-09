-- [[ سكريبت أيهم الأسطوري - النسخة المفتوحة الشاملة V20 ]]
local Player = game.Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- [1] إنشاء الحاوية الأساسية
local ScreenGui = Instance.new("ScreenGui", PlayerGui)
ScreenGui.Name = "AihamScript_Main"
ScreenGui.ResetOnSpawn = false

-- [2] إنشاء الإطار الرئيسي (الواجهة)
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 500, 0, 350)
MainFrame.Position = UDim2.new(0.5, -250, 0.5, -175)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true 
MainFrame.Draggable = true

local UICorner = Instance.new("UICorner", MainFrame)
UICorner.CornerRadius = UDim.new(0, 10)

-- [3] إعدادات التبويبات (أضف أي اسم هنا في أي وقت!)
local MenuConfig = {
    "اعدادات الماب",
    "اللاعب",
    "الاستهداف",
    "التأثيرات",
    "المحفوظات",
    "العسكرية 🎖️"
}

-- [4] قائمة الأزرار الجانبية
local SideMenu = Instance.new("ScrollingFrame", MainFrame)
SideMenu.Size = UDim2.new(0, 150, 1, 0)
SideMenu.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
SideMenu.BorderSizePixel = 0
SideMenu.CanvasSize = UDim2.new(0, 0, 0, #MenuConfig * 50)
SideMenu.ScrollBarThickness = 2

-- [5] منطقة عرض المحتوى
local ContentArea = Instance.new("Frame", MainFrame)
ContentArea.Size = UDim2.new(1, -150, 1, 0)
ContentArea.Position = UDim2.new(0, 150, 0, 0)
ContentArea.BackgroundTransparency = 1

local AllPages = {}

-- [6] بناء الأزرار والصفحات ديناميكياً
for i, name in ipairs(MenuConfig) do
    local btn = Instance.new("TextButton", SideMenu)
    btn.Size = UDim2.new(0.9, 0, 0, 40)
    btn.Position = UDim2.new(0.05, 0, 0, (i-1) * 45 + 5)
    btn.Text = name
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 5)
    
    local page = Instance.new("ScrollingFrame", ContentArea)
    page.Size = UDim2.new(1, 0, 1, 0)
    page.BackgroundTransparency = 1
    page.Visible = (i == 1)
    page.Name = name
    AllPages[name] = page
    
    btn.MouseButton1Click:Connect(function()
        for _, p in pairs(AllPages) do p.Visible = false end
        page.Visible = true
    end)
end

-- [7] زر التصغير والتكبير
local ToggleBtn = Instance.new("TextButton", ScreenGui)
ToggleBtn.Size = UDim2.new(0, 50, 0, 50)
ToggleBtn.Position = UDim2.new(0, 20, 0.5, -25)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
ToggleBtn.Text = "👁️"
ToggleBtn.TextColor3 = Color3.new(1, 1, 1)
ToggleBtn.Draggable = true
Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(1, 0)

ToggleBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)
