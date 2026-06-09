local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local TopBar = Instance.new("Frame")
local TitleLabel = Instance.new("TextLabel")
local CloseButton = Instance.new("TextButton")
local LeftPanel = Instance.new("Frame")
local ContentPanel = Instance.new("Frame")
local UIListLayout = Instance.new("UIListLayout")
local FrameStroke = Instance.new("UIStroke")

-- إنشاء زر التصغير العائم المربع بالنقطة السوداء (حسب صورة 1000001008.jpg)
local MinimizeButton = Instance.new("TextButton")
local ButtonStroke = Instance.new("UIStroke")
local Dot = Instance.new("Frame")

ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

-- إعدادات زر التصغير العائم المربع (أصفر وداخله نقطة سوداء)
MinimizeButton.Name = "MinimizeButton"
MinimizeButton.Parent = ScreenGui
MinimizeButton.BackgroundColor3 = Color3.fromRGB(255, 204, 0) -- لون أصفر فاقع كالصورة
MinimizeButton.Position = UDim2.new(0.18, 0, 0.5, 0) -- موقعه على يسار القائمة
MinimizeButton.Size = UDim2.new(0, 45, 0, 45) -- شكل مربع
MinimizeButton.Text = ""
MinimizeButton.Active = true
MinimizeButton.Draggable = true -- يمكنك تحريك الزر العائم في أي مكان بالشاشة

ButtonStroke.Parent = MinimizeButton
ButtonStroke.Color = Color3.fromRGB(0, 0, 0)
ButtonStroke.Thickness = 2

-- النقطة السوداء في منتصف الزر الأصفر
Dot.Name = "Dot"
Dot.Parent = MinimizeButton
Dot.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Dot.Position = UDim2.new(0.35, 0, 0.35, 0)
Dot.Size = UDim2.new(0.3, 0, 0.3, 0)
-- جعل النقطة دائرية تماماً كالصورة
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(1, 0)
UICorner.Parent = Dot

-- إعداد الواجهة الرئيسية (تصميم صورة 1000001000_2.jpg)
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15) -- خلفية سوداء داكنة
MainFrame.Position = UDim2.new(0.25, 0, 0.2, 0)
MainFrame.Size = UDim2.new(0, 580, 0, 360)
MainFrame.Active = true
MainFrame.Draggable = true

FrameStroke.Parent = MainFrame
FrameStroke.Color = Color3.fromRGB(255, 215, 0) -- حواف صفراء ذهبية
FrameStroke.Thickness = 2

-- الشريط العلوي (Top Bar)
TopBar.Name = "TopBar"
TopBar.Parent = MainFrame
TopBar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
TopBar.Size = UDim2.new(1, 0, 0, 35)

-- عنوان المطور (صنع من قبل المطور الأسطوري أيهم)
TitleLabel.Parent = TopBar
TitleLabel.Size = UDim2.new(0.85, 0, 1, 0)
TitleLabel.Position = UDim2.new(0, 10, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "صنع من قبل المطور الأسطوري أيهم"
TitleLabel.TextColor3 = Color3.fromRGB(0, 255, 0) -- أخضر فاقع
TitleLabel.Font = Enum.Font.SourceSansBold
TitleLabel.TextSize = 18
TitleLabel.TextXAlignment = Enum.TextXAlignment.Center

-- زر الإغلاق الأحمر [X]
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

-- وظيفة زر التصغير العائم (يخفي القائمة الكبيرة ويظهرها)
MinimizeButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

-- لوحة التبويبات الجانبية اليسرى (أزرار خضراء فاقعة ونصوص سوداء)
LeftPanel.Name = "LeftPanel"
LeftPanel.Parent = MainFrame
LeftPanel.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
LeftPanel.Position = UDim2.new(0, 5, 0, 40)
LeftPanel.Size = UDim2.new(0, 140, 1, -45)

UIListLayout.Parent = LeftPanel
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 6)

-- لوحة عرض محتوى الميزات (اليمنى)
ContentPanel.Name = "ContentPanel"
ContentPanel.Parent = MainFrame
ContentPanel.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
ContentPanel.Position = UDim2.new(0, 150, 0, 40)
ContentPanel.Size = UDim2.new(1, -155, 1, -45)

local tabs = {}
local pages = {}

-- دالة بناء التبويبات السبعة
local function CreateTab(tabName, order)
    local TabButton = Instance.new("TextButton")
    TabButton.Size = UDim2.new(1, 0, 0, 38)
    TabButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0) -- لون أخضر فاقع
    TabButton.TextColor3 = Color3.fromRGB(0, 0, 0) -- نص أسود
    TabButton.Font = Enum.Font.SourceSansBold
    TabButton.TextSize = 16
    TabButton.Text = tabName
    TabButton.LayoutOrder = order
    TabButton.Parent = LeftPanel

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
        for _, t in pairs(tabs) do 
            t.BackgroundColor3 = Color3.fromRGB(0, 255, 0) 
            t.TextColor3 = Color3.fromRGB(0, 0, 0)
        end
        Page.Visible = true
        TabButton.BackgroundColor3 = Color3.fromRGB(0, 180, 0)
        TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    end)

    tabs[tabName] = TabButton
    pages[tabName] = Page
    return Page
end

-- دالة إنشاء أزرار الميزات (تتحول للأخضر عند التفعيل)
local function CreateFeatureButton(page, text, callback)
    local Button = Instance.new("TextButton")
    Button.BackgroundColor3 = Color3.fromRGB(45, 45, 45) -- رمادي داكن
    Button.TextColor3 = Color3.fromRGB(255, 255, 255) -- نص أبيض
    Button.Font = Enum.Font.SourceSans
    Button.TextSize = 15
    Button.Text = text
    Button.Parent = page

    local active = false
    Button.MouseButton1Click:Connect(function()
        active = not active
        if active then
            Button.BackgroundColor3 = Color3.fromRGB(0, 200, 0) -- يتحول للأخضر
        else
            Button.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
        end
        callback(active)
    end)
end

-- =========================================================
-- الشرائح السبعة (7 قوائم)
-- =========================================================

-- القائمة 1: اعدادات الماب
local MapPage = CreateTab("اعدادات الماب", 1)
CreateFeatureButton(MapPage, "جعل الماب مضوي بالكامل (FullBright)", function(state)
    if state then
        game:GetService("Lighting").Ambient = Color3.fromRGB(255, 255, 255)
        game:GetService("Lighting").Brightness = 2
    else
        game:GetService("Lighting").Ambient = Color3.fromRGB(130, 130, 130)
        game:GetService("Lighting").Brightness = 1
    end
end)
CreateFeatureButton(MapPage, "شرائح حمراء", function(state) end)
CreateFeatureButton(MapPage, "شرائح قوس قزح", function(state) end)
CreateFeatureButton(MapPage, "شرائح زرقاء", function(state) end)
CreateFeatureButton(MapPage, "شرائح صفراء", function(state) end)

-- القائمة 2: اللاعب
local PlayerPage = CreateTab("اللاعب", 2)
CreateFeatureButton(PlayerPage, "سرعة ركض عالية", function(state)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = state and 50 or 16
end)
CreateFeatureButton(PlayerPage, "قفزة خارقة", function(state)
    game.Players.LocalPlayer.Character.Humanoid.JumpPower = state and 100 or 50
end)

-- القائمة 3: الاستهداف
local TargetPage = CreateTab("الاستهداف", 3)
CreateFeatureButton(TargetPage, "تفعيل التصويب التلقائي", function(state) end)

-- القائمة 4: نقاط الحفظ
local SavePage = CreateTab("نقاط الحفظ", 4)
CreateFeatureButton(SavePage, "حفظ الموقع الحالي", function(state) end)

-- القائمة 5: التأثيرات
local EffectsPage = CreateTab("التأثيرات", 5)
CreateFeatureButton(EffectsPage, "إزالة الضباب", function(state) end)

-- القائمة 6: تبويب IY (القدرات الستة)
local IYPage = CreateTab("IY", 6)

CreateFeatureButton(IYPage, "💫 حلقة الألوان", function(state)
    if state then
        _G.ColorRing = true
        local char = game.Players.LocalPlayer.Character or game.Players.LocalPlayer.CharacterAdded:Wait()
        local hrp = char:WaitForChild("HumanoidRootPart")
        local ring = Instance.new("Part")
        ring.Name = "ColorRingPart"
        ring.Size = Vector3.new(5, 0.2, 5)
        ring.CanCollide = false
        ring.Parent = char
        local attachment0 = Instance.new("Attachment", hrp)
        local attachment1 = Instance.new("Attachment", ring)
        local align = Instance.new("AlignPosition", ring)
        align.Attachment0 = attachment1
        align.Attachment1 = attachment0
        local speed = 0
        task.spawn(function()
            while _G.ColorRing and ring and ring.Parent do
                speed = speed + 0.05
                ring.Color = Color3.fromHSV(math.sin(speed)%1, 1, 1)
                task.wait(0.02)
            end
        end)
    else
        _G.ColorRing = false
        local char = game.Players.LocalPlayer.Character
        if char and char:FindFirstChild("ColorRingPart") then char.ColorRingPart:Destroy() end
    end
end)

CreateFeatureButton(IYPage, "👁️ رؤية الأعلى — Top View", function(state)
    local camera = workspace.CurrentCamera
    if state then
        _G.TopView = true
        task.spawn(function()
            while _G.TopView do
                local player = game.Players.LocalPlayer
                if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                    local hrp = player.Character.HumanoidRootPart
                    camera.CFrame = CFrame.new(hrp.Position + Vector3.new(0, 40, 0), hrp.Position)
                end
                task.wait()
            end
        end)
    else
        _G.TopView = false
        camera.CameraType = Enum.CameraType.Custom
    end
end)

CreateFeatureButton(IYPage, "🧱 المشي على الجدران — WallWalk", function(state)
    _G.WallWalk = state
    local char = game.Players.LocalPlayer.Character
    local hrp = char:FindFirstChild("HumanoidRootPart")
    task.spawn(function()
        while _G.WallWalk and task.wait(0.1) do
            local ray = Ray.new(hrp.Position, hrp.CFrame.LookVector * 3)
            local part, pos, normal = workspace:FindPartOnRay(ray, char)
            if part and math.abs(normal.Y) < 0.1 then
                hrp.Velocity = Vector3.new(0, 15, 0) + (hrp.CFrame.LookVector * 10)
            end
        end
    end)
end)

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

CreateFeatureButton(IYPage, "🌀 تدوير الشخصية — Spin", function(state)
    if state then
        _G.Spinning = true
        local hrp = game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart")
        task.spawn(function()
            while _G.Spinning do
                hrp.CFrame = hrp.CFrame * CFrame.Angles(0, math.rad(20), 0)
                task.wait(0.01)
            end
        end)
    else _G.Spinning = false end
end)

CreateFeatureButton(IYPage, "👻 إخفاء كامل — Invisible", function(state)
    local char = game.Players.LocalPlayer.Character
    for _, part in pairs(char:GetDescendants()) do
        if part:IsA("BasePart") or part:IsA("Decal") then
            if part.Name ~= "HumanoidRootPart" then part.Transparency = state and 1 or 0 end
        end
    end
end)

-- القائمة 7: الأدوات والأوامر الإضافية
local ExtraPage = CreateTab("الأوامر الإضافية", 7)
CreateFeatureButton(ExtraPage, "أدوات مجانية", function(state) end)

-- تشغيل القائمة الأولى تلقائياً
pages["اعدادات الماب"].Visible = true
tabs["اعدادات الماب"].BackgroundColor3 = Color3.fromRGB(0, 180, 0)
tabs["اعدادات الماب"].TextColor3 = Color3.fromRGB(255, 255, 255)
