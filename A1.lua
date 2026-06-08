-- [[ سكريبت أيهم الأسطوري - نسخة V5.2 المصححة والمطورة بالكامل ]]
local Player = game.Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")
local RunService = game:GetService("RunService")
local PlayersService = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")

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
ToggleButton.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
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
MainFrame.Size = UDim2.new(0, 460, 0, 280)
MainFrame.Position = UDim2.new(0.5, -230, 0.5, -140)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.BorderSizePixel = 2
MainFrame.BorderColor3 = Color3.fromRGB(255, 215, 0)
MainFrame.Visible = false
MainFrame.Parent = ScreenGui

ToggleButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 35)
Title.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Title.Text = "صنع من قبل المطور الأسطوري أيهم"
Title.TextColor3 = Color3.fromRGB(255, 215, 0)
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
    if rainbowConnection then
        rainbowConnection:Disconnect()
        rainbowConnection = nil
    end

    if themeName == "أصفر" then
        local color = Color3.fromRGB(255, 215, 0)
        MainFrame.BorderColor3 = color; ToggleButton.BackgroundColor3 = color; Title.TextColor3 = color
    elseif themeName == "أحمر" then
        local color = Color3.fromRGB(255, 0, 0)
        MainFrame.BorderColor3 = color; ToggleButton.BackgroundColor3 = color; Title.TextColor3 = color
    elseif themeName == "أزرق" then
        local color = Color3.fromRGB(0, 150, 255)
        MainFrame.BorderColor3 = color; ToggleButton.BackgroundColor3 = color; Title.TextColor3 = color
    elseif themeName == "قوس قزح" then
        rainbowConnection = RunService.RenderStepped:Connect(function()
            local hue = (tick() % 5) / 5
            local color = Color3.fromHSV(hue, 1, 1)
            MainFrame.BorderColor3 = color; ToggleButton.BackgroundColor3 = color; Title.TextColor3 = color
        end)
    end
end

-----------------------------------------
-- 4. إنشاء التبويبات القوائم
-----------------------------------------
local Pages = {}
local menuNames = {"اعدادات الماب", "اللاعب", "الاستهداف", "نقاط الحفظ", "انميشن"}

for i, name in ipairs(menuNames) do
    local TabBtn = Instance.new("TextButton")
    TabBtn.Size = UDim2.new(0.9, 0, 0, 32)
    TabBtn.Position = UDim2.new(0.05, 0, 0, (i-1) * 36 + 10)
    TabBtn.BackgroundColor3 = Color3.fromRGB(220, 180, 0)
    TabBtn.Text = name
    TabBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
    TabBtn.Font = Enum.Font.SourceSansBold
    TabBtn.TextSize = 12
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
    Btn.Size = UDim2.new(0.9, 0, 0, 32)
    Btn.Position = position
    Btn.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
    Btn.Text = text
    Btn.TextColor3 = Color3.fromRGB(0, 0, 0)
    Btn.Font = Enum.Font.SourceSansBold
    Btn.TextSize = 13
    Btn.Parent = parent

    local active = false
    Btn.MouseButton1Click:Connect(function()
        active = not active
        Btn.BackgroundColor3 = active and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(200, 200, 200)
        onClick(active, Btn)
    end)
    return Btn
end

-----------------------------------------
-- القائمة 1: الإعدادات
-----------------------------------------
local SettingsPage = Pages[1]
createAbilityButton(SettingsPage, "إضاءة ساطعة (FullBright)", UDim2.new(0.05, 0, 0, 10), function(isActive)
    game.Lighting.Ambient = isActive and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(128, 128, 128)
end)

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
    if currentThemeIndex > #themesList then currentThemeIndex = 1 end
    local nextTheme = themesList[currentThemeIndex]
    ChangeColorBtn.Text = "تغيير لون الإطار (الحالي: " .. nextTheme .. ")"
    updateMenuTheme(nextTheme)
end)

-----------------------------------------
-- القائمة 2: اللاعب
-----------------------------------------
local PlayerPage = Pages[2]
local PlayerScroll = Instance.new("ScrollingFrame")
PlayerScroll.Size = UDim2.new(1, 0, 1, 0)
PlayerScroll.BackgroundTransparency = 1
PlayerScroll.CanvasSize = UDim2.new(0, 0, 0, 250)
PlayerScroll.ScrollBarThickness = 5
PlayerScroll.Parent = PlayerPage

local function createCustomValueButton(parent, buttonText, defaultNumber, positionY, onToggle)
    local isBtnActive = false
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(0.65, 0, 0, 32); Btn.Position = UDim2.new(0.05, 0, 0, positionY); Btn.BackgroundColor3 = Color3.fromRGB(200, 200, 200); Btn.Text = buttonText; Btn.TextColor3 = Color3.fromRGB(0, 0, 0); Btn.Font = Enum.Font.SourceSansBold; Btn.TextSize = 13; Btn.Parent = parent

    local NumInput = Instance.new("TextBox")
    NumInput.Size = UDim2.new(0.2, 0, 0, 32); NumInput.Position = UDim2.new(0.75, 0, 0, positionY); NumInput.BackgroundColor3 = Color3.fromRGB(45, 45, 45); NumInput.TextColor3 = Color3.fromRGB(255, 255, 0); NumInput.Text = tostring(defaultNumber); NumInput.Font = Enum.Font.SourceSansBold; NumInput.TextSize = 15; NumInput.ClearTextOnFocus = false; NumInput.Parent = parent

    Btn.MouseButton1Click:Connect(function()
        isBtnActive = not isBtnActive
        Btn.BackgroundColor3 = isBtnActive and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(200, 200, 200)
        local currentNum = tonumber(NumInput.Text) or defaultNumber
        onToggle(isBtnActive, currentNum)
    end)

    NumInput.FocusLost:Connect(function()
        local currentNum = tonumber(NumInput.Text) or defaultNumber
        if isBtnActive then onToggle(true, currentNum) end
    end)
end

createCustomValueButton(PlayerScroll, "تفعيل السرعة الفائقة", 60, 10, function(isActive, speedValue)
    local char = Player.Character
    if char and char:FindFirstChild("Humanoid") then char.Humanoid.WalkSpeed = isActive and speedValue or 16 end
end)

createCustomValueButton(PlayerScroll, "تفعيل القفز العالي", 120, 45, function(isActive, jumpValue)
    local char = Player.Character
    if char and char:FindFirstChild("Humanoid") then char.Humanoid.JumpPower = isActive and jumpValue or 50 end
end)

local flying = false
local flyConnection = nil
createAbilityButton(PlayerScroll, "تفعيل الطيران", UDim2.new(0.05, 0, 0, 80), function(isActive)
    local char = Player.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    local humanoid = char and char:FindFirstChild("Humanoid")
    if not root or not humanoid then return end
    flying = isActive
    if flying then
        local bv = Instance.new("BodyVelocity")
        bv.Name = "FlyVelocity"; bv.Velocity = Vector3.new(0, 0, 0); bv.MaxForce = Vector3.new(100000, 100000, 100000); bv.Parent = root
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

createAbilityButton(PlayerScroll, "تفعيل الاختفاء", UDim2.new(0.05, 0, 0, 115), function(isActive)
    local char = Player.Character
    if char then
        for _, part in ipairs(char:GetDescendants()) do
            if part:IsA("BasePart") or part:IsA("Decal") then
                if part.Name ~= "HumanoidRootPart" then part.Transparency = isActive and 1 or 0 end
            end
        end
    end
end)

local infiniteJumpEnabled = false
local jumpConnection = nil
createAbilityButton(PlayerScroll, "تفعيل القفز اللانهائي", UDim2.new(0.05, 0, 0, 150), function(isActive)
    infiniteJumpEnabled = isActive
    if infiniteJumpEnabled then
        jumpConnection = UserInputService.JumpRequest:Connect(function()
            local char = Player.Character
            local humanoid = char and char:FindFirstChildOfClass("Humanoid")
            if humanoid and infiniteJumpEnabled then humanoid:ChangeState(Enum.HumanoidStateType.Jumping) end
        end)
    else
        if jumpConnection then jumpConnection:Disconnect(); jumpConnection = nil end
    end
end)

local noclipEnabled = false
local noclipConnection = nil
createAbilityButton(PlayerScroll, "تفعيل اختراق الجدران", UDim2.new(0.05, 0, 0, 185), function(isActive)
    noclipEnabled = isActive
    if noclipEnabled then
        noclipConnection = RunService.Stepped:Connect(function()
            local char = Player.Character
            if char and noclipEnabled then
                for _, part in ipairs(char:GetDescendants()) do
                    if part:IsA("BasePart") then part.CanCollide = false end
                end
            end
        end)
    else
        if noclipConnection then noclipConnection:Disconnect(); noclipConnection = nil end
    end
end)

-----------------------------------------
-- القائمة 3: الاستهداف
-----------------------------------------
local TargetPage = Pages[3]
local NameInput = Instance.new("TextBox")
NameInput.Size = UDim2.new(0.9, 0, 0, 40); NameInput.Position = UDim2.new(0.05, 0, 0, 15); NameInput.BackgroundColor3 = Color3.fromRGB(40, 40, 40); NameInput.TextColor3 = Color3.fromRGB(255, 255, 255); NameInput.Text = ""; NameInput.PlaceholderText = "اكتب أول أحرف من اسم اللاعب هنا..."; NameInput.Font = Enum.Font.SourceSans; NameInput.TextSize = 14; NameInput.Parent = TargetPage

local function getTargetPlayer()
    local text = NameInput.Text:lower()
    if text == "" then return nil end
    for _, p in ipairs(PlayersService:GetPlayers()) do
        if p.Name:lower():sub(1, #text) == text or (p.DisplayName and p.DisplayName:lower():sub(1, #text) == text) then return p end
    end
    return nil
end

local TeleportBtn = Instance.new("TextButton")
TeleportBtn.Size = UDim2.new(0.4, 0, 0, 45); TeleportBtn.Position = UDim2.new(0.05, 0, 0, 75); TeleportBtn.BackgroundColor3 = Color3.fromRGB(220, 180, 0); TeleportBtn.Text = "انتقال"; TeleportBtn.TextColor3 = Color3.fromRGB(0, 0, 0); TeleportBtn.Font = Enum.Font.SourceSansBold; TeleportBtn.TextSize = 16; TeleportBtn.Parent = TargetPage

TeleportBtn.MouseButton1Click:Connect(function()
    local target = getTargetPlayer()
    if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
        local myChar = Player.Character
        if myChar and myChar:FindFirstChild("HumanoidRootPart") then myChar.HumanoidRootPart.CFrame = target.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3) end
    end
end)

local SpectateBtn = Instance.new("TextButton")
SpectateBtn.Size = UDim2.new(0.4, 0, 0, 45); SpectateBtn.Position = UDim2.new(0.55, 0, 0, 75); SpectateBtn.BackgroundColor3 = Color3.fromRGB(200, 200, 200); SpectateBtn.Text = "مشاهدة"; SpectateBtn.TextColor3 = Color3.fromRGB(0, 0, 0); SpectateBtn.Font = Enum.Font.SourceSansBold; SpectateBtn.TextSize = 16; SpectateBtn.Parent = TargetPage

local isSpectating = false
SpectateBtn.MouseButton1Click:Connect(function()
    local cam = workspace.CurrentCamera
    isSpectating = not isSpectating
    if isSpectating then
        local target = getTargetPlayer()
        if target and target.Character and target.Character:FindFirstChild("Humanoid") then
            SpectateBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
            cam.CameraSubject = target.Character.Humanoid
        else
            isSpectating = false
        end
    else
        SpectateBtn.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
        local myChar = Player.Character
        if myChar and myChar:FindFirstChild("Humanoid") then cam.CameraSubject = myChar.Humanoid end
    end
end)

-----------------------------------------
-- القائمة 4: نقاط الحفظ
-----------------------------------------
local CheckpointPage = Pages[4]
local CPNameInput = Instance.new("TextBox")
CPNameInput.Size = UDim2.new(0.9, 0, 0, 35); CPNameInput.Position = UDim2.new(0.05, 0, 0, 10); CPNameInput.BackgroundColor3 = Color3.fromRGB(45, 45, 45); CPNameInput.TextColor3 = Color3.fromRGB(255, 255, 255); CPNameInput.Text = ""; CPNameInput.PlaceholderText = "اكتب اسم النقطة..."; CPNameInput.Font = Enum.Font.SourceSans; CPNameInput.TextSize = 14; CPNameInput.Parent = CheckpointPage

local SaveCPBtn = Instance.new("TextButton")
SaveCPBtn.Size = UDim2.new(0.9, 0, 0, 35); SaveCPBtn.Position = UDim2.new(0.05, 0, 0, 50); SaveCPBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0); SaveCPBtn.Text = "حفظ النقطة الحالية"; SaveCPBtn.TextColor3 = Color3.fromRGB(255, 255, 255); SaveCPBtn.Font = Enum.Font.SourceSansBold; SaveCPBtn.TextSize = 14; SaveCPBtn.Parent = CheckpointPage

local CPListFrame = Instance.new("ScrollingFrame")
CPListFrame.Size = UDim2.new(0.9, 0, 0, 135); CPListFrame.Position = UDim2.new(0.05, 0, 0, 95); CPListFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25); CPListFrame.CanvasSize = UDim2.new(0, 0, 0, 0); CPListFrame.ScrollBarThickness = 6; CPListFrame.Parent = CheckpointPage

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Padding = UDim.new(0, 5); UIListLayout.Parent = CPListFrame

local savedPoints = {}
local filename = "AihamCheckpoints_Raven.json"

local function loadPoints()
    if isfile and isfile(filename) then
        local success, data = pcall(function() return HttpService:JSONDecode(readfile(filename)) end)
        if success and type(data) == "table" then savedPoints = data end
    end
end

local function savePointsToFile()
    if writefile then pcall(function() writefile(filename, HttpService:JSONEncode(savedPoints)) end) end
end

local refreshList
refreshList = function()
    for _, child in ipairs(CPListFrame:GetChildren()) do if child:IsA("Frame") then child:Destroy() end end
    local count = 0
    for name, posData in pairs(savedPoints) do
        count = count + 1
        local ItemFrame = Instance.new("Frame")
        ItemFrame.Size = UDim2.new(0.98, 0, 0, 30); ItemFrame.BackgroundTransparency = 1; ItemFrame.Parent = CPListFrame
        
        local GoBtn = Instance.new("TextButton")
        GoBtn.Size = UDim2.new(0.8, 0, 1, 0); GoBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50); GoBtn.Text = name; GoBtn.TextColor3 = Color3.fromRGB(255, 255, 255); GoBtn.Font = Enum.Font.SourceSansBold; GoBtn.TextSize = 14; GoBtn.Parent = ItemFrame
        GoBtn.MouseButton1Click:Connect(function()
            local char = Player.Character
            local root = char and char:FindFirstChild("HumanoidRootPart")
            if root then root.CFrame = CFrame.new(posData.X, posData.Y, posData.Z) end
        end)
        
        local DelBtn = Instance.new("TextButton")
        DelBtn.Size = UDim2.new(0.15, 0, 1, 0); DelBtn.Position = UDim2.new(0.85, 0, 0, 0); DelBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0); DelBtn.Text = "X"; DelBtn.TextColor3 = Color3.fromRGB(255, 255, 255); DelBtn.Font = Enum.Font.SourceSansBold; DelBtn.TextSize = 14; DelBtn.Parent = ItemFrame
        DelBtn.MouseButton1Click:Connect(function()
            savedPoints[name] = nil; savePointsToFile(); refreshList()
        end)
    end
    CPListFrame.CanvasSize = UDim2.new(0, 0, 0, count * 35)
end

SaveCPBtn.MouseButton1Click:Connect(function()
    local name = CPNameInput.Text
    if name == "" then return end
    local char = Player.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    if root then
        savedPoints[name] = {X = root.Position.X, Y = root.Position.Y, Z = root.Position.Z}
        savePointsToFile(); refreshList(); CPNameInput.Text = ""
    end
end)

loadPoints()
refreshList()

-----------------------------------------
-- [[ تصحيح القائمة 5: نقل وإدخال كافة عناصر انميشن داخل الإطار الرئيسي ]]
-----------------------------------------
local AnimationPage = Pages[5]

-- إنشاء قائمة تمرير داخل تبويب انميشن لترتيب الأزرار بشكل مثالي ومنظم لمنع تداخلها
local AnimTabScroll = Instance.new("ScrollingFrame")
AnimTabScroll.Size = UDim2.new(1, 0, 1, 0)
AnimTabScroll.BackgroundTransparency = 1
AnimTabScroll.CanvasSize = UDim2.new(0, 0, 0, 260)
AnimTabScroll.ScrollBarThickness = 5
AnimTabScroll.Parent = AnimationPage

local TabListLayout = Instance.new("UIListLayout")
TabListLayout.Padding = UDim.new(0, 8)
TabListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
TabListLayout.SortOrder = Enum.SortOrder.LayoutOrder
TabListLayout.Parent = AnimTabScroll

-- 1. الزر الواحد الأساسي والموحد لفتح واجهة الأنميشن الشفافة المستقلة
local OpenAnimMenuBtn = Instance.new("TextButton")
OpenAnimMenuBtn.Size = UDim2.new(0.9, 0, 0, 35)
OpenAnimMenuBtn.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
OpenAnimMenuBtn.Text = "افتح قائمة الأنيميشن"
OpenAnimMenuBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
OpenAnimMenuBtn.Font = Enum.Font.SourceSansBold
OpenAnimMenuBtn.TextSize = 14
OpenAnimMenuBtn.LayoutOrder = 1
OpenAnimMenuBtn.Parent = AnimTabScroll

local OpenBtnCorner = Instance.new("UICorner")
OpenBtnCorner.CornerRadius = UDim.new(0, 6)
OpenBtnCorner.Parent = OpenAnimMenuBtn

-- 2. إدخال وتصحيح مكان أزرار القدرات لتكون داخل صفحة انميشن ومنظمة بدلاً من تشتتها بالخارج
local function createTabAbilityButton(text, order, onClick)
    local Btn = I
