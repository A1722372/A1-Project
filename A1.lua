-- [[ سكريبت أيهم الأسطوري - النسخة المطورة للهواتف (إضافة ميزة تغيير ألوان الإطار) ]]
local Player = game.Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")
local RunService = game:GetService("RunService")
local PlayersService = game:GetService("Players")

-- تنظيف الشاشة من أي نسخة قديمة
if PlayerGui:FindFirstChild("AihamSuperMenu") then
    PlayerGui.AihamSuperMenu:Destroy()
end

-- الواجهة الرئيسية
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AihamSuperMenu"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = PlayerGui

-----------------------------------------
-- 1. المربع الصغير (نقطة فتح وإغلاق القائمة)
-----------------------------------------
local ToggleButton = Instance.new("TextButton")
ToggleButton.Name = "ToggleButton"
ToggleButton.Size = UDim2.new(0, 40, 0, 40)
ToggleButton.Position = UDim2.new(0, 10, 0.5, -20)
ToggleButton.BackgroundColor3 = Color3.fromRGB(255, 215, 0) -- البداية أصفر
ToggleButton.Text = "●"
ToggleButton.TextColor3 = Color3.fromRGB(0, 0, 0)
ToggleButton.TextSize = 20
ToggleButton.BorderSizePixel = 2
ToggleButton.Parent = ScreenGui

ToggleButton.Active = true
ToggleButton.Draggable = true

-----------------------------------------
-- 2. الإطار الرئيسي للواجهة (Main Frame)
-----------------------------------------
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 450, 0, 280)
MainFrame.Position = UDim2.new(0.5, -225, 0.5, -140)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.BorderSizePixel = 2
MainFrame.BorderColor3 = Color3.fromRGB(255, 215, 0) -- البداية أصفر
MainFrame.Visible = false
MainFrame.Parent = ScreenGui

ToggleButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 35)
Title.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Title.Text = "صنع من قبل المطور الأسطوري أيهم"
Title.TextColor3 = Color3.fromRGB(255, 215, 0) -- البداية أصفر
Title.TextSize = 16
Title.Font = Enum.Font.SourceSansBold
Title.Parent = MainFrame

local SideMenu = Instance.new("Frame")
SideMenu.Size = UDim2.new(0, 130, 1, -35)
SideMenu.Position = UDim2.new(0, 0, 0, 35)
SideMenu.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
SideMenu.Parent = MainFrame

local ContentArea = Instance.new("Frame")
ContentArea.Size = UDim2.new(1, -130, 1, -35)
ContentArea.Position = UDim2.new(0, 130, 0, 35)
ContentArea.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
ContentArea.Parent = MainFrame

-----------------------------------------
-- 3. نظام وإدارة تغيير الألوان (Theme System)
-----------------------------------------
local currentTheme = "أصفر"
local rainbowConnection = nil

local function updateMenuTheme(themeName)
    currentTheme = themeName
    
    -- إيقاف تشغيل قوس قزح القديم إذا كان يعمل لتجنب التداخل
    if rainbowConnection then
        rainbowConnection:Disconnect()
        rainbowConnection = nil
    end

    if themeName == "أصفر" then
        local color = Color3.fromRGB(255, 215, 0)
        MainFrame.BorderColor3 = color
        ToggleButton.BackgroundColor3 = color
        Title.TextColor3 = color
    elseif themeName == "أحمر" then
        local color = Color3.fromRGB(255, 0, 0)
        MainFrame.BorderColor3 = color
        ToggleButton.BackgroundColor3 = color
        Title.TextColor3 = color
    elseif themeName == "أزرق" then
        local color = Color3.fromRGB(0, 150, 255)
        MainFrame.BorderColor3 = color
        ToggleButton.BackgroundColor3 = color
        Title.TextColor3 = color
    elseif themeName == "قوس قزح" then
        -- تشغيل تأثير قوس قزح المتغير والمتحرك تلقائياً
        rainbowConnection = RunService.RenderStepped:Connect(function()
            local hue = (tick() % 5) / 5 -- سرعة تغير الألوان
            local color = Color3.fromHSV(hue, 1, 1)
            MainFrame.BorderColor3 = color
            ToggleButton.BackgroundColor3 = color
            Title.TextColor3 = color
        end)
    end
end

-----------------------------------------
-- 4. إنشاء التبويبات (الإعدادات، اللاعب، الاستهداف)
-----------------------------------------
local Pages = {}
local menuNames = {"اعدادات الماب", "اللاعب", "الاستهداف"}

for i, name in ipairs(menuNames) do
    local TabBtn = Instance.new("TextButton")
    TabBtn.Size = UDim2.new(0.9, 0, 0, 40)
    TabBtn.Position = UDim2.new(0.05, 0, 0, (i-1) * 45 + 10)
    TabBtn.BackgroundColor3 = Color3.fromRGB(220, 180, 0)
    TabBtn.Text = name
    TabBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
    TabBtn.Font = Enum.Font.SourceSansBold
    TabBtn.TextSize = 14
    TabBtn.Parent = SideMenu

    local PageFrame = Instance.new("Frame")
    PageFrame.Size = UDim2.new(1, 0, 1, 0)
    PageFrame.BackgroundTransparency = 1
    PageFrame.Visible = (i == 1)
    PageFrame.Parent = ContentArea
    Pages[i] = PageFrame

    TabBtn.MouseButton1Click:Connect(function()
        for _, page in ipairs(Pages) do page.Visible = false end
        PageFrame.Visible = true
    end)
end

local function createAbilityButton(parent, text, position, onClick)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(0.9, 0, 0, 35)
    Btn.Position = position
    Btn.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
    Btn.Text = text
    Btn.TextColor3 = Color3.fromRGB(0, 0, 0)
    Btn.Font = Enum.Font.SourceSansBold
    Btn.TextSize = 14
    Btn.Parent = parent

    local active = false
    Btn.MouseButton1Click:Connect(function()
        active = not active
        if active then
            Btn.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
        else
            Btn.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
        end
        onClick(active)
    end)
    return Btn
end

-----------------------------------------
-- القائمة 1: الإعدادات (تحديث الزر الجديد)
-----------------------------------------
local SettingsPage = Pages[1]

createAbilityButton(SettingsPage, "إضاءة ساطعة (FullBright)", UDim2.new(0.05, 0, 0, 10), function(isActive)
    game.Lighting.Ambient = isActive and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(128, 128, 128)
end)

-- إنشاء زر تبديل الألوان داخل قائمة الإعدادات
local ChangeColorBtn = Instance.new("TextButton")
ChangeColorBtn.Size = UDim2.new(0.9, 0, 0, 35)
ChangeColorBtn.Position = UDim2.new(0.05, 0, 0, 50)
ChangeColorBtn.BackgroundColor3 = Color3.fromRGB(240, 240, 240)
ChangeColorBtn.Text = "تغيير لون الإطار (الحالي: أصفر)"
ChangeColorBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
ChangeColorBtn.Font = Enum.Font.SourceSansBold
ChangeColorBtn.TextSize = 14
ChangeColorBtn.Parent = SettingsPage

local themesList = {"أصفر", "أحمر", "أزرق", "قوس قزح"}
local currentThemeIndex = 1

ChangeColorBtn.MouseButton1Click:Connect(function()
    currentThemeIndex = currentThemeIndex + 1
    if currentThemeIndex > #themesList then
        currentThemeIndex = 1
    end
    
    local nextTheme = themesList[currentThemeIndex]
    ChangeColorBtn.Text = "تغيير لون الإطار (الحالي: " .. nextTheme .. ")"
    updateMenuTheme(nextTheme)
end)

-----------------------------------------
-- القائمة 2: اللاعب
-----------------------------------------
local PlayerPage = Pages[2]
createAbilityButton(PlayerPage, "تفعيل السرعة الفائقة", UDim2.new(0.05, 0, 0, 10), function(isActive)
    local char = Player.Character
    if char and char:FindFirstChild("Humanoid") then char.Humanoid.WalkSpeed = isActive and 60 or 16 end
end)

createAbilityButton(PlayerPage, "تفعيل القفز العالي", UDim2.new(0.05, 0, 0, 50), function(isActive)
    local char = Player.Character
    if char and char:FindFirstChild("Humanoid") then char.Humanoid.JumpPower = isActive and 120 or 50 end
end)

local flying = false
local flyConnection = nil
createAbilityButton(PlayerPage, "تفعيل الطيران", UDim2.new(0.05, 0, 0, 90), function(isActive)
    local char = Player.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    local humanoid = char and char:FindFirstChild("Humanoid")
    if not root or not humanoid then return end
    flying = isActive
    if flying then
        local bv = Instance.new("BodyVelocity")
        bv.Name = "FlyVelocity"
        bv.Velocity = Vector3.new(0, 0, 0)
        bv.MaxForce = Vector3.new(100000, 100000, 100000)
        bv.Parent = root
        humanoid.PlatformStand = true
        flyConnection = RunService.RenderStepped:Connect(function()
            local cam = workspace.CurrentCamera
            if flying and root and bv then bv.Velocity = cam.CFrame.LookVector * 50 end
        end)
    else
        if flyConnection then flyConnection:Disconnect() end
        local bv = root:FindFirstChild("FlyVelocity")
        if bv then bv:Destroy() end
        humanoid.PlatformStand = false
    end
end)

createAbilityButton(PlayerPage, "تفعيل الاختفاء", UDim2.new(0.05, 0, 0, 130), function(isActive)
    local char = Player.Character
    if char then
        for _, part in ipairs(char:GetDescendants()) do
            if part:IsA("BasePart") or part:IsA("Decal") then
                if part.Name ~= "HumanoidRootPart" then part.Transparency = isActive and 1 or 0 end
            end
        end
    end
end)

-----------------------------------------
-- القائمة 3: الاستهداف
-----------------------------------------
local TargetPage = Pages[3]

local NameInput = Instance.new("TextBox")
NameInput.Size = UDim2.new(0.9, 0, 0, 40)
NameInput.Position = UDim2.new(0.05, 0, 0, 15)
NameInput.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
NameInput.TextColor3 = Color3.fromRGB(255, 255, 255)
NameInput.Text = ""
NameInput.PlaceholderText = "اكتب أول أحرف من اسم اللاعب هنا..."
NameInput.Font = Enum.Font.SourceSans
NameInput.TextSize = 14
NameInput.Parent = TargetPage

local function getTargetPlayer()
    local text = NameInput.Text:lower()
    if text == "" then return nil end
    for _, p in ipairs(PlayersService:GetPlayers()) do
        if p.Name:lower():sub(1, #text) == text or (p.DisplayName and p.DisplayName:lower():sub(1, #text) == text) then
            return p
        end
    end
    return nil
end

local TeleportBtn = Instance.new("TextButton")
TeleportBtn.Size = UDim2.new(0.4, 0, 0, 45)
TeleportBtn.Position = UDim2.new(0.05, 0, 0, 75)
TeleportBtn.BackgroundColor3 = Color3.fromRGB(220, 180, 0)
TeleportBtn.Text = "انتقال"
TeleportBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
TeleportBtn.Font = Enum.Font.SourceSansBold
TeleportBtn.TextSize = 16
TeleportBtn.Parent = TargetPage

TeleportBtn.MouseButton1Click:Connect(function()
    local target = getTargetPlayer()
    if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
        local myChar = Player.Character
        if myChar and myChar:FindFirstChild("HumanoidRootPart") then
            myChar.HumanoidRootPart.CFrame = target.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3)
            print("تم الانتقال إلى: " .. target.Name)
        end
    else
        print("لم يتم العثور على اللاعب!")
    end
end)

local SpectateBtn = Instance.new("TextButton")
SpectateBtn.Size = UDim2.new(0.4, 0, 0, 45)
SpectateBtn.Position = UDim2.new(0.55, 0, 0, 75)
SpectateBtn.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
SpectateBtn.Text = "مشاهدة"
SpectateBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
SpectateBtn.Font = Enum.Font.SourceSansBold
SpectateBtn.TextSize = 16
SpectateBtn.Parent = TargetPage

local isSpectating = false
SpectateBtn.MouseButton1Click:Connect(function()
    local cam = workspace.CurrentCamera
    isSpectating = not isSpectating

    if isSpectating then
        local target = getTargetPlayer()
        if target and target.Character and target.Character:FindFirstChild("Humanoid") then
            SpectateBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
            cam.CameraSubject = target.Character.Humanoid
            print("أنت تشاهد الآن: " .. target.Name)
        else
            isSpectating = false
            print("تعذر المشاهدة، تأكد من الاسم!")
        end
    else
        SpectateBtn.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
        local myChar = Player.Character
        if myChar and myChar:FindFirstChild("Humanoid") then
            cam.CameraSubject = myChar.Humanoid
            print("تم إيقاف المشاهدة العودة للشخصية.")
        end
    end
end)
