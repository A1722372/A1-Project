-- [[ V5.5 سكريبت أيهم الأسطوري الكامل - أحدث نسخة مطورة ومصححة بالكامل ]] --
local Player = game.Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")
local RunService = game:GetService("RunService")
local PlayersService = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")

-- تنظيف الشاشة من أي نسخة قديمة معلقة
if PlayerGui:FindFirstChild("AihamSuperMenu") then
    PlayerGui.AihamSuperMenu:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AihamSuperMenu"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = PlayerGui

-- واجهة القائمة الرئيسية المطورة V5.5 (الشفافة الأنيقة)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 460, 0, 320)
MainFrame.Position = UDim2.new(0.5, -230, 0.5, -160)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.BackgroundTransparency = 0.15
MainFrame.BorderSizePixel = 2
MainFrame.BorderColor3 = Color3.fromRGB(255, 215, 0)
MainFrame.Visible = true
MainFrame.Parent = ScreenGui
MainFrame.Active = true
MainFrame.Draggable = true

-- زر الفتح والإغلاق الصغير الجانبي (●)
local ToggleButton = Instance.new("TextButton")
ToggleButton.Name = "ToggleButton"
ToggleButton.Size = UDim2.new(0, 40, 0, 40)
ToggleButton.Position = UDim2.new(0, 10, 0.5, -20)
ToggleButton.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
ToggleButton.Text = "●"
ToggleButton.TextColor3 = Color3.fromRGB(0, 0, 0)
ToggleButton.TextSize = 22
ToggleButton.Font = Enum.Font.SourceSansBold
ToggleButton.BorderSizePixel = 2
ToggleButton.Parent = ScreenGui
ToggleButton.Active = true
ToggleButton.Draggable = true

ToggleButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
Title.Text = "صنع من قبل المطور الأسطوري أيهم - V5.5"
Title.TextColor3 = Color3.fromRGB(255, 215, 0)
Title.TextSize = 18
Title.Font = Enum.Font.SourceSansBold
Title.Parent = MainFrame

local SideMenu = Instance.new("Frame")
SideMenu.Size = UDim2.new(0, 130, 1, -40)
SideMenu.Position = UDim2.new(0, 0, 0, 40)
SideMenu.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
SideMenu.Parent = MainFrame

local ContentArea = Instance.new("Frame")
ContentArea.Size = UDim2.new(1, -130, 1, -40)
ContentArea.Position = UDim2.new(0, 130, 0, 40)
ContentArea.BackgroundTransparency = 1
ContentArea.Parent = MainFrame

-- التبويبات الخمسة للنسخة 5.5
local Pages = {}
local menuNames = {"اعدادات الماب", "اللاعب", "الاستهداف", "نقاط الحفظ", "أنيميشن ورقص"}

for i, name in ipairs(menuNames) do
    local TabBtn = Instance.new("TextButton")
    TabBtn.Size = UDim2.new(0.9, 0, 0, 35)
    TabBtn.Position = UDim2.new(0.05, 0, 0, (i-1) * 42 + 15)
    TabBtn.BackgroundColor3 = Color3.fromRGB(220, 180, 0)
    TabBtn.Text = name
    TabBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
    TabBtn.Font = Enum.Font.SourceSansBold
    TabBtn.TextSize = 13
    TabBtn.Parent = SideMenu

    local PageScroll = Instance.new("ScrollingFrame")
    PageScroll.Size = UDim2.new(1, 0, 1, 0)
    PageScroll.BackgroundTransparency = 1
    PageScroll.CanvasSize = UDim2.new(0, 0, 0, 400)
    PageScroll.ScrollBarThickness = 6
    PageScroll.Visible = (i == 1)
    PageScroll.Parent = ContentArea
    Pages[i] = PageScroll

    TabBtn.MouseButton1Click:Connect(function()
        for _, page in ipairs(Pages) do page.Visible = false end
        PageScroll.Visible = true
    end)
end

-- دالة عامة لإنشاء الأزرار التلقائية المتغيرة الألوان
local function createAbilityButton(parent, text, positionY, onClick)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(0.9, 0, 0, 35)
    Btn.Position = UDim2.new(0.05, 0, 0, positionY)
    Btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    Btn.Text = text
    Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    Btn.Font = Enum.Font.SourceSansBold
    Btn.TextSize = 14
    Btn.Parent = parent

    local active = false
    Btn.MouseButton1Click:Connect(function()
        active = not active
        Btn.BackgroundColor3 = active and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(50, 50, 50)
        Btn.TextColor3 = active and Color3.fromRGB(0, 0, 0) or Color3.fromRGB(255, 255, 255)
        onClick(active, Btn)
    end)
    return Btn
end

-- === [ تبويب 1: إعدادات الماب + ميزات الـ AFK ] ===
local SettingsPage = Pages[1]

createAbilityButton(SettingsPage, "تجميع الصناديق وتجميع دوري تلقائي (AFK)", 15, function(isActive)
    _G.AutoFarm = isActive
    spawn(function()
        while _G.AutoFarm do
            -- كود تجميع الصناديق والميزات التلقائية لماب ريفن العسكرية
            pcall(function()
                for _, obj in ipairs(workspace:GetDescendants()) do
                    if obj:IsA("TouchTransmitter") and (obj.Parent.Name:lower():find("box") or obj.Parent.Name:lower():find("chest") or obj.Parent.Name:lower():find("crate")) then
                        firetouchinterest(Player.Character.HumanoidRootPart, obj.Parent, 0)
                        firetouchinterest(Player.Character.HumanoidRootPart, obj.Parent, 1)
                    end
                end
            end)
            task.wait(1)
        end
    end)
end)

createAbilityButton(SettingsPage, "إضاءة ساطعة كاملة (FullBright)", 60, function(isActive)
    if isActive then
        game.Lighting.Ambient = Color3.fromRGB(255, 255, 255)
        game.Lighting.Brightness = 2
    else
        game.Lighting.Ambient = Color3.fromRGB(128, 128, 128)
        game.Lighting.Brightness = 1
    end
end)

-- === [ تبويب 2: التحكم باللاعب ] ===
local PlayerPage = Pages[2]

local function createCustomValueButton(parent, buttonText, defaultNumber, positionY, onToggle)
    local isBtnActive = false
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(0.65, 0, 0, 35)
    Btn.Position = UDim2.new(0.05, 0, 0, positionY)
    Btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    Btn.Text = buttonText
    Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    Btn.Font = Enum.Font.SourceSansBold
    Btn.TextSize = 14
    Btn.Parent = parent

    local NumInput = Instance.new("TextBox")
    NumInput.Size = UDim2.new(0.2, 0, 0, 35)
    NumInput.Position = UDim2.new(0.75, 0, 0, positionY)
    NumInput.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    NumInput.TextColor3 = Color3.fromRGB(255, 215, 0)
    NumInput.Text = tostring(defaultNumber)
    NumInput.Font = Enum.Font.SourceSansBold
    NumInput.TextSize = 14
    NumInput.ClearTextOnFocus = false
    NumInput.Parent = parent

    Btn.MouseButton1Click:Connect(function()
        isBtnActive = not isBtnActive
        Btn.BackgroundColor3 = isBtnActive and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(50, 50, 50)
        Btn.TextColor3 = isBtnActive and Color3.fromRGB(0, 0, 0) or Color3.fromRGB(255, 255, 255)
        local currentNum = tonumber(NumInput.Text) or defaultNumber
        onToggle(isBtnActive, currentNum)
    end)
end

createCustomValueButton(PlayerPage, "تفعيل السرعة الفائقة", 60, 15, function(isActive, speedValue)
    local char = Player.Character
    if char and char:FindFirstChild("Humanoid") then
        char.Humanoid.WalkSpeed = isActive and speedValue or 16
    end
end)

createCustomValueButton(PlayerPage, "تفعيل قوة القفز العالي", 120, 60, function(isActive, jumpValue)
    local char = Player.Character
    if char and char:FindFirstChild("Humanoid") then
        char.Humanoid.JumpPower = isActive and jumpValue or 50
    end
end)

-- === [ تبويب 3: الاستهداف والانتقال ] ===
local TargetPage = Pages[3]

local NameInput = Instance.new("TextBox")
NameInput.Size = UDim2.new(0.9, 0, 0, 40)
NameInput.Position = UDim2.new(0.05, 0, 0, 15)
NameInput.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
NameInput.TextColor3 = Color3.fromRGB(255, 255, 255)
NameInput.PlaceholderText = "اكتب أول أحرف من اسم اللاعب المُراد..."
NameInput.Text = ""
NameInput.Font = Enum.Font.SourceSans
NameInput.TextSize = 14
NameInput.Parent = TargetPage

local TeleportBtn = Instance.new("TextButton")
TeleportBtn.Size = UDim2.new(0.9, 0, 0, 40)
TeleportBtn.Position = UDim2.new(0.05, 0, 0, 70)
TeleportBtn.BackgroundColor3 = Color3.fromRGB(220, 180, 0)
TeleportBtn.Text = "انتقال إلى اللاعب فوراً"
TeleportBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
TeleportBtn.Font = Enum.Font.SourceSansBold
TeleportBtn.TextSize = 15
TeleportBtn.Parent = TargetPage

TeleportBtn.MouseButton1Click:Connect(function()
    local text = NameInput.Text:lower()
    if text == "" then return end
    for _, p in ipairs(PlayersService:GetPlayers()) do
        if p.Name:lower():sub(1, #text) == text then
            if p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                local myChar = Player.Character
                if myChar and myChar:FindFirstChild("HumanoidRootPart") then 
                    myChar.HumanoidRootPart.CFrame = p.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3) 
                end
            end
            break
        end
    end
end)

-- === [ تبويب 4: نقاط الحفظ ] ===
local CheckpointPage = Pages[4]
local savedCFrame = nil

createAbilityButton(CheckpointPage, "حفظ موقعك الحالي كعلامة", 15, function(isActive, btn)
    local char = Player.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        savedCFrame = char.HumanoidRootPart.CFrame
        btn.Text = "تم الحفظ بنجاح!"
        task.wait(1)
        btn.Text = "حفظ موقعك الحالي كعلامة"
    end
end)

createAbilityButton(CheckpointPage, "انتقال إلى النقطة المحفوظة", 60, function(isActive, btn)
    local char = Player.Character
    if char and char:FindFirstChild("HumanoidRootPart") and savedCFrame then
        char.HumanoidRootPart.CFrame = savedCFrame
    end
end)

-- === [ تبويب 5: قائمة الرقصات والأنيميشن التلقائي ] ===
local AnimPage = Pages[5]
local currentTrack = nil

local function playAnimation(id)
    if currentTrack then currentTrack:Stop() end
    local char = Player.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    if hum and id ~= 0 then
        local anim = Instance.new("Animation")
        anim.AnimationId = "rbxassetid://" .. id
        currentTrack = hum:LoadAnimation(anim)
        currentTrack:Play()
    end
end

local anims = {
    {"رقصة حماسية 1", 507750864},
    {"رقصة حماسية 2", 507751034},
    {"حركة الضحك الساخرة", 507749043},
    {"أنيميشن التحية العسكرية", 507744230},
    {"إيقاف كافة الحركات", 0}
}

for idx, data in ipairs(anims) do
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(0.9, 0, 0, 35)
    b.Position = UDim2.new(0.05, 0, 0, (idx-1) * 45 + 15)
    b.BackgroundColor3 = data[2] == 0 and Color3.fromRGB(150, 0, 0) or Color3.fromRGB(40, 40, 40)
    b.TextColor3 = Color3.fromRGB(255, 255, 255)
    b.Text = data[1]
    b.Font = Enum.Font.SourceSansBold
    b.TextSize = 14
    b.Parent = AnimPage

    b.MouseButton1Click:Connect(function()
        playAnimation(data[2])
    end)
end
