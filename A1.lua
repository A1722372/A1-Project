local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local TopBar = Instance.new("Frame")
local TitleLabel = Instance.new("TextLabel")
local CloseButton = Instance.new("TextButton")
local LeftPanel = Instance.new("Frame")
local ContentPanel = Instance.new("Frame")
local UIListLayout = Instance.new("UIListLayout")
local FrameStroke = Instance.new("UIStroke")

-- زر التصغير العائم المربع بالنقطة السوداء
local MinimizeButton = Instance.new("TextButton")
local ButtonStroke = Instance.new("UIStroke")
local Dot = Instance.new("Frame")

ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

-- إعدادات زر التصغير العائم
MinimizeButton.Name = "MinimizeButton"
MinimizeButton.Parent = ScreenGui
MinimizeButton.BackgroundColor3 = Color3.fromRGB(255, 204, 0)
MinimizeButton.Position = UDim2.new(0.15, 0, 0.4, 0)
MinimizeButton.Size = UDim2.new(0, 45, 0, 45)
MinimizeButton.Text = ""
MinimizeButton.Active = true
MinimizeButton.Draggable = true

ButtonStroke.Parent = MinimizeButton
ButtonStroke.Color = Color3.fromRGB(0, 0, 0)
ButtonStroke.Thickness = 2

Dot.Name = "Dot"
Dot.Parent = MinimizeButton
Dot.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Dot.Position = UDim2.new(0.35, 0, 0.35, 0)
Dot.Size = UDim2.new(0.3, 0, 0.3, 0)
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(1, 0)
UICorner.Parent = Dot

-- إعداد الواجهة الرئيسية
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.Position = UDim2.new(0.25, 0, 0.2, 0)
MainFrame.Size = UDim2.new(0, 580, 0, 360)
MainFrame.Active = true
MainFrame.Draggable = true

FrameStroke.Parent = MainFrame
FrameStroke.Thickness = 2
FrameStroke.Color = Color3.fromRGB(255, 215, 0)

-- الشريط العلوي
TopBar.Name = "TopBar"
TopBar.Parent = MainFrame
TopBar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
TopBar.Size = UDim2.new(1, 0, 0, 35)

TitleLabel.Parent = TopBar
TitleLabel.Size = UDim2.new(0.85, 0, 1, 0)
TitleLabel.Position = UDim2.new(0, 10, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "صنع من قبل المطور الأسطوري أيهم"
TitleLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
TitleLabel.Font = Enum.Font.SourceSansBold
TitleLabel.TextSize = 18
TitleLabel.TextXAlignment = Enum.TextXAlignment.Center

CloseButton.Parent = TopBar
CloseButton.Size = UDim2.new(0, 35, 0, 35)
CloseButton.Position = UDim2.new(1, -35, 0, 0)
CloseButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.Font = Enum.Font.SourceSansBold
CloseButton.TextSize = 18

CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

MinimizeButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

LeftPanel.Name = "LeftPanel"
LeftPanel.Parent = MainFrame
LeftPanel.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
LeftPanel.Position = UDim2.new(0, 5, 0, 40)
LeftPanel.Size = UDim2.new(0, 140, 1, -45)

UIListLayout.Parent = LeftPanel
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 6)

ContentPanel.Name = "ContentPanel"
ContentPanel.Parent = MainFrame
ContentPanel.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
ContentPanel.Position = UDim2.new(0, 150, 0, 40)
ContentPanel.Size = UDim2.new(1, -155, 1, -45)

local tabs = {}
local pages = {}
local currentThemeColor = Color3.fromRGB(0, 255, 0)
local rainbowThemeActive = false

-- نظام تحديث الألوان للثيم بالكامل (الإطار، النص، والأزرار الجانبية)
local function UpdateUITheme(newColor)
    currentThemeColor = newColor
    TitleLabel.TextColor3 = newColor
    for tName, btn in pairs(tabs) do
        if btn:GetAttribute("Selected") == true then
            btn.BackgroundColor3 = Color3.fromRGB(math.max(newColor.R*255 - 60, 0), math.max(newColor.G*255 - 60, 0), math.max(newColor.B*255 - 60, 0))
        else
            btn.BackgroundColor3 = newColor
        end
    end
end

-- دالة بناء التبويبات
local function CreateTab(tabName, order)
    local TabButton = Instance.new("TextButton")
    TabButton.Size = UDim2.new(1, 0, 0, 38)
    TabButton.BackgroundColor3 = currentThemeColor
    TabButton.TextColor3 = Color3.fromRGB(0, 0, 0)
    TabButton.Font = Enum.Font.SourceSansBold
    TabButton.TextSize = 16
    TabButton.Text = tabName
    TabButton.LayoutOrder = order
    TabButton.Parent = LeftPanel
    TabButton:SetAttribute("Selected", false)

    local Page = Instance.new("ScrollingFrame")
    Page.Size = UDim2.new(1, 0, 1, 0)
    Page.BackgroundTransparency = 1
    Page.Visible = false
    Page.CanvasSize = UDim2.new(0, 0, 1.5, 0)
    Page.Parent = ContentPanel
    
    local PageGrid = Instance.new("UIGridLayout")
    PageGrid.Parent = Page
    PageGrid.CellSize = UDim2.new(0, 200, 0, 40)
    PageGrid.CellPadding = UDim2.new(0, 10, 0, 10)
    PageGrid.SortOrder = Enum.SortOrder.LayoutOrder

    TabButton.MouseButton1Click:Connect(function()
        for _, p in pairs(pages) do p.Visible = false end
        for tName, tBtn in pairs(tabs) do 
            tBtn:SetAttribute("Selected", false)
            tBtn.BackgroundColor3 = currentThemeColor
            tBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
        end
        Page.Visible = true
        TabButton:SetAttribute("Selected", true)
        TabButton.BackgroundColor3 = Color3.fromRGB(math.max(currentThemeColor.R*255 - 60, 0), math.max(currentThemeColor.G*255 - 60, 0), math.max(currentThemeColor.B*255 - 60, 0))
        TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    end)

    tabs[tabName] = TabButton
    pages[tabName] = Page
    return Page
end

-- دالة إنشاء أزرار الميزات داخل الصفحات
local function CreateFeatureButton(page, text, callback)
    local Button = Instance.new("TextButton")
    Button.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.Font = Enum.Font.SourceSans
    Button.TextSize = 15
    Button.Text = text
    Button.Parent = page

    local active = false
    Button.MouseButton1Click:Connect(function()
        active = not active
        if active then
            Button.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
        else
            Button.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
        end
        callback(active)
    end)
    return Button
end

-- =========================================================
-- بناء التبويبات والميزات كاملة وثابتة
-- =========================================================

-- 1. اعدادات الماب
local MapPage = CreateTab("اعدادات الماب", 1)

CreateFeatureButton(MapPage, "🎬 تفعيل الشادر (Shaders RTX)", function(state)
    local lighting = game:GetService("Lighting")
    if state then
        lighting.Brightness = 2.5
        lighting.GlobalShadows = true
        lighting.ShadowSoftness = 0.1
        lighting.ExposureCompensation = 0.5
        if not lighting:FindFirstChild("Bloom") then
            local bloom = Instance.new("BloomEffect", lighting)
            bloom.Intensity = 1
            bloom.Size = 24
            bloom.Threshold = 0.9
        end
    else
        lighting.Brightness = 2
        if lighting:FindFirstChild("Bloom") then lighting.Bloom:Destroy() end
    end
end)

CreateFeatureButton(MapPage, "جعل الماب مضوي (FullBright)", function(state)
    if state then
        game:GetService("Lighting").Ambient = Color3.fromRGB(255, 255, 255)
    else
        game:GetService("Lighting").Ambient = Color3.fromRGB(130, 130, 130)
    end
end)

-- 2. ألوان السكريبت (تحديث الألوان الحقيقي الذي طلبته للأزرار، الإطار، والنصوص)
local ColorsPage = CreateTab("ألوان السكريبت", 2)

CreateFeatureButton(ColorsPage, "🔴 الثيم الأحمر", function()
    rainbowThemeActive = false
    FrameStroke.Color = Color3.fromRGB(255, 0, 0)
    UpdateUITheme(Color3.fromRGB(255, 50, 50))
end)

CreateFeatureButton(ColorsPage, "🔵 الثيم الأزرق", function()
    rainbowThemeActive = false
    FrameStroke.Color = Color3.fromRGB(0, 0, 255)
    UpdateUITheme(Color3.fromRGB(50, 150, 255))
end)

CreateFeatureButton(ColorsPage, "🟡 الثيم الأصفر", function()
    rainbowThemeActive = false
    FrameStroke.Color = Color3.fromRGB(255, 255, 0)
    UpdateUITheme(Color3.fromRGB(255, 220, 0))
end)

CreateFeatureButton(ColorsPage, "🟢 الثيم الأخضر الافتراضي", function()
    rainbowThemeActive = false
    FrameStroke.Color = Color3.fromRGB(255, 215, 0)
    UpdateUITheme(Color3.fromRGB(0, 255, 0))
end)

CreateFeatureButton(ColorsPage, "🌈 ثيم قوس قزح المتحرك", function(state)
    rainbowThemeActive = state
    task.spawn(function()
        local hue = 0
        while rainbowThemeActive do
            hue = hue + 0.005
            local rainbowColor = Color3.fromHSV(hue % 1, 1, 1)
            FrameStroke.Color = rainbowColor
            UpdateUITheme(rainbowColor)
            task.wait(0.02)
        end
    end)
end)

-- 3. اللاعب
local PlayerPage = CreateTab("اللاعب", 3)
CreateFeatureButton(PlayerPage, "⚡ سرعة ركض عالية", function(state)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = state and 50 or 16
end)
CreateFeatureButton(PlayerPage, "🦘 قفزة خارقة", function(state)
    game.Players.LocalPlayer.Character.Humanoid.JumpPower = state and 100 or 50
end)

-- 4. الاستهداف
local TargetPage = CreateTab("الاستهداف", 4)
-- 5. نقاط الحفظ
local SavePage = CreateTab("نقاط الحفظ", 5)
-- 6. التأثيرات
local EffectsPage = CreateTab("التأثيرات", 6)

-- 7. تبويب IY
local IYPage = CreateTab("IY", 7)
CreateFeatureButton(IYPage, "⏱️ منع الطرد — Anti-AFK", function(state)
    if state then
        _G.AntiAFK = game.Players.LocalPlayer.Idled:Connect(function()
            game:GetService("VirtualUser"):CaptureController()
            game:GetService("VirtualUser"):ClickButton2(Vector2.new(0,0))
        end)
    else
        if _G.AntiAFK then _G.AntiAFK:Disconnect() _G.AntiAFK = nil end
    end
end)

-- تشغيل القائمة الأولى افتراضياً بشكل صحيح
pages["اعدادات الماب"].Visible = true
tabs["اعدادات الماب"]:SetAttribute("Selected", true)
tabs["اعدادات الماب"].BackgroundColor3 = Color3.fromRGB(0, 195, 0)
tabs["اعدادات الماب"].TextColor3 = Color3.fromRGB(255, 255, 255)
