-- [[ سكريبت أيهم الأسطوري الجديد - الجزء الأول: الهيكل والتصميم ]]
local Player = game.Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")
local RunService = game:GetService("RunService")

-- تنظيف أي نسخة قديمة منعاً للتداخل
if PlayerGui:FindFirstChild("AihamLegendaryMenu") then 
    PlayerGui.AihamLegendaryMenu:Destroy() 
end

-- إنشاء الواجهة الرئيسية
local ScreenGui = Instance.new("ScreenGui", PlayerGui)
ScreenGui.Name = "AihamLegendaryMenu"
ScreenGui.ResetOnSpawn = false

-- الإطار الرئيسي (Main Frame)
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 520, 0, 340) -- حجم متناسق ومناسب للشاشات
MainFrame.Position = UDim2.new(0.5, -260, 0.5, -170)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15) -- أسود داكن
MainFrame.BorderSizePixel = 2
MainFrame.BorderColor3 = Color3.fromRGB(180, 0, 0) -- حواف حمراء مقتبسة من الصورة
MainFrame.Active = true
MainFrame.Draggable = true

-- العنوان العلوي (Title Bar)
local TitleBar = Instance.new("Frame", MainFrame)
TitleBar.Size = UDim2.new(1, 0, 0, 35)
TitleBar.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
TitleBar.BorderSizePixel = 0

local TitleText = Instance.new("TextLabel", TitleBar)
TitleText.Size = UDim2.new(1, -40, 1, 0)
TitleText.Position = UDim2.new(0, 10, 0, 0)
TitleText.BackgroundTransparency = 1
TitleText.Text = "VR7 TEAM: Aiham Legendary Script" -- ثيم العنوان مثل الصورة
TitleText.TextColor3 = Color3.fromRGB(200, 0, 0)
TitleText.TextSize = 16
TitleText.Font = Enum.Font.SourceSansBold
TitleText.TextXAlignment = Enum.TextXAlignment.Left

-- زر الإغلاق (Close Button)
local CloseBtn = Instance.new("TextButton", TitleBar)
CloseBtn.Size = UDim2.new(0, 25, 0, 25)
CloseBtn.Position = UDim2.new(1, -30, 0, 5)
CloseBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.Font = Enum.Font.SourceSansBold
CloseBtn.TextSize = 14
CloseBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
end)

-- القائمة الجانبية (Side Menu)
local SideMenu = Instance.new("ScrollingFrame", MainFrame)
SideMenu.Size = UDim2.new(0, 140, 1, -35)
SideMenu.Position = UDim2.new(0, 0, 0, 35)
SideMenu.BackgroundColor3 = Color3.fromRGB(20, 5, 5) -- خلفية حمراء داكنة جداً للقائمة
SideMenu.BorderSizePixel = 1
SideMenu.BorderColor3 = Color3.fromRGB(100, 0, 0)
SideMenu.CanvasSize = UDim2.new(0, 0, 0, 350)
SideMenu.ScrollBarThickness = 4

-- منطقة المحتوى (Content Area)
local ContentArea = Instance.new("Frame", MainFrame)
ContentArea.Size = UDim2.new(1, -140, 1, -35)
ContentArea.Position = UDim2.new(0, 140, 0, 35)
ContentArea.BackgroundTransparency = 1

-- إنشاء الصفحات والتنقل (مطابق تماماً لأسماء القوائم في الصورة)
local Pages = {}
local tabs = {
    {eng = "Home", arb = "الرئيسية"},
    {eng = "Game", arb = "التخريب"},
    {eng = "Character", arb = "اللاعب"},
    {eng = "Target", arb = "استهداف"},
    {eng = "Anims", arb = "انيمشنات"},
    {eng = "Misc", arb = "أخرى"},
    {eng = "News", arb = "الاخبار"}
}

for i, tab in ipairs(tabs) do
    -- أزرار القائمة الجانبية
    local btn = Instance.new("TextButton", SideMenu)
    btn.Size = UDim2.new(0.9, 0, 0, 35)
    btn.Position = UDim2.new(0.05, 0, 0, (i-1) * 40 + 10)
    btn.BackgroundColor3 = Color3.fromRGB(40, 5, 5)
    btn.BorderSizePixel = 1
    btn.BorderColor3 = Color3.fromRGB(150, 0, 0)
    btn.Text = tab.eng .. " | " .. tab.arb
    btn.TextColor3 = Color3.fromRGB(200, 0, 0)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 13
    
    -- إنشاء الصفحة المقابلة للزر
    local page = Instance.new("ScrollingFrame", ContentArea)
    page.Size = UDim2.new(1, 0, 1, 0)
    page.BackgroundTransparency = 1
    page.CanvasSize = UDim2.new(0, 0, 0, 400)
    page.ScrollBarThickness = 4
    page.Visible = (i == 1) -- الصفحة الأولى تظهر تلقائياً
    Pages[i] = page
    
    -- تأثير عند الضغط والتنقل
    btn.MouseButton1Click:Connect(function()
        for _, p in ipairs(Pages) do p.Visible = false end
        page.Visible = true
    end)
end

-- === إضافة خانة الأوامر [Cmdbar] في أعلى كل الصفحات (كما تظهر بالصورة) ===
for _, page in ipairs(Pages) do
    local CmdContainer = Instance.new("Frame", page)
    CmdContainer.Size = UDim2.new(0.95, 0, 0, 40)
    CmdContainer.Position = UDim2.new(0.025, 0, 0, 10)
    CmdContainer.BackgroundTransparency = 1
    
    -- زر الـ V الأيسر
    local VBtn = Instance.new("TextButton", CmdContainer)
    VBtn.Size = UDim2.new(0, 30, 0, 35)
    VBtn.BackgroundColor3 = Color3.fromRGB(40, 5, 5)
    VBtn.BorderColor3 = Color3.fromRGB(150, 0, 0)
    VBtn.Text = "V"
    VBtn.TextColor3 = Color3.fromRGB(200, 0, 0)
    VBtn.Font = Enum.Font.SourceSansBold
    VBtn.TextSize = 14

    -- خانة إدخال الأوامر النصية
    local CmdInput = Instance.new("TextBox", CmdContainer)
    CmdInput.Size = UDim2.new(1, -75, 0, 35)
    CmdInput.Position = UDim2.new(0, 35, 0, 0)
    CmdInput.BackgroundColor3 = Color3.fromRGB(30, 5, 5)
    CmdInput.BorderColor3 = Color3.fromRGB(150, 0, 0)
    CmdInput.Text = ""
    CmdInput.PlaceholderText = "[Cmdbar] خانة الاوامر "
    CmdInput.PlaceholderColor3 = Color3.fromRGB(120, 30, 30)
    CmdInput.TextColor3 = Color3.fromRGB(255, 255, 255)
    CmdInput.Font = Enum.Font.SourceSansBold
    CmdInput.TextSize = 14

    -- زر الـ ? الأيمن
    local HelpBtn = Instance.new("TextButton", CmdContainer)
    HelpBtn.Size = UDim2.new(0, 30, 0, 35)
    HelpBtn.Position = UDim2.new(1, -30, 0, 0)
    HelpBtn.BackgroundColor3 = Color3.fromRGB(40, 5, 5)
    HelpBtn.BorderColor3 = Color3.fromRGB(150, 0, 0)
    HelpBtn.Text = "?"
    HelpBtn.TextColor3 = Color3.fromRGB(200, 0, 0)
    HelpBtn.Font = Enum.Font.SourceSansBold
    HelpBtn.TextSize = 14
end

-- زر فتح وإغلاق السكريبت العائم (Toggle Button)
local ToggleButton = Instance.new("TextButton", ScreenGui)
ToggleButton.Size = UDim2.new(0, 45, 0, 45)
ToggleButton.Position = UDim2.new(0, 15, 0.5, -22)
ToggleButton.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
ToggleButton.BorderColor3 = Color3.fromRGB(180, 0, 0)
ToggleButton.BorderSizePixel = 2
ToggleButton.Text = "VR7"
ToggleButton.TextColor3 = Color3.fromRGB(200, 0, 0)
ToggleButton.TextSize = 14
ToggleButton.Font = Enum.Font.SourceSansBold
ToggleButton.Active = true
ToggleButton.Draggable = true

ToggleButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

print("تم تحميل هيكل سكريبت أيهم الأسطوري الجديد بنجاح!")
