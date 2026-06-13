local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AnxamScript"
ScreenGui.Parent = game.CoreGui

-- اللوحة الرئيسية
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 500, 0, 300)
MainFrame.Position = UDim2.new(0.5, -250, 0.5, -150)
MainFrame.BackgroundColor3 = Color3.fromRGB(220, 220, 220)
MainFrame.Parent = ScreenGui
local Corner = Instance.new("UICorner", MainFrame) -- زوايا دائرية

-- القائمة الجانبية (الأيقونات)
local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0, 150, 1, 0)
Sidebar.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
Sidebar.Parent = MainFrame
local SidebarCorner = Instance.new("UICorner", Sidebar)

-- مثال لزر داخل القائمة (اللاعب)
local PlayerBtn = Instance.new("TextButton")
PlayerBtn.Size = UDim2.new(0.9, 0, 0, 40)
PlayerBtn.Position = UDim2.new(0.05, 0, 0.1, 0)
PlayerBtn.Text = "اللاعب"
PlayerBtn.Parent = Sidebar

-- منطقة الميزات اليمنى
local ContentArea = Instance.new("ScrollingFrame")
ContentArea.Size = UDim2.new(0, 350, 1, 0)
ContentArea.Position = UDim2.new(0.3, 0, 0, 0)
ContentArea.BackgroundTransparency = 1
ContentArea.Parent = MainFrame
