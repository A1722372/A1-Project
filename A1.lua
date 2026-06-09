-- [[ سكريبت أيهم الأسطوري V12 - نسخة الصناديق بدون طيران - مصلح ]]
local Player = game.Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")
local Backpack = Player:WaitForChild("Backpack")
local RunService = game:GetService("RunService")
local PlayersService = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")

-- تنظيف أي نسخ قديمة لضمان عمل السكريبت بنجاح
if PlayerGui:FindFirstChild("AihamSuperMenu") then PlayerGui.AihamSuperMenu:Destroy() end

local ScreenGui = Instance.new("ScreenGui", PlayerGui)
ScreenGui.Name = "AihamSuperMenu"
ScreenGui.ResetOnSpawn = false

-- الإطار الرئيسي للشاشة
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 480, 0, 320)
MainFrame.Position = UDim2.new(0.5, -240, 0.5, -160)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.BorderSizePixel = 3
MainFrame.Active = true
MainFrame.Draggable = true

-- جدول نقاط الحفظ الخاص بشريحة الحفظ
local savedLocations = {}

-- نظام ألوان الحواف الكامل لجميع الشرائح
local rainbowConnection
local function setBorderColor(mode)
    if rainbowConnection then rainbowConnection:Disconnect() rainbowConnection = nil end
    if mode == "Red" then MainFrame.BorderColor3 = Color3.fromRGB(255, 0, 0)
    elseif mode == "Yellow" then MainFrame.BorderColor3 = Color3.fromRGB(255, 200, 0)
    elseif mode == "Blue" then MainFrame.BorderColor3 = Color3.fromRGB(0, 100, 255)
    elseif mode == "Rainbow" then
        rainbowConnection = RunService.RenderStepped:Connect(function()
            local hue = (tick() % 4) / 4
            MainFrame.BorderColor3 = Color3.fromHSV(hue, 1, 1)
        end)
    end
end
setBorderColor("Yellow")

-- زر الفتح والإغلاق الجانبي الصغير (●)
local ToggleButton = Instance.new("TextButton", ScreenGui)
ToggleButton.Size = UDim2.new(0, 40, 0, 40)
ToggleButton.Position = UDim2.new(0, 10, 0.5, -20)
ToggleButton.BackgroundColor3 = Color3.fromRGB(255, 200, 0)
ToggleButton.Text = "●"
ToggleButton.TextColor3 = Color3.fromRGB(0, 0, 0)
ToggleButton.TextSize = 22 ToggleButton.Font = Enum.Font.SourceSansBold
ToggleButton.Active = true ToggleButton.Draggable = true
ToggleButton.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)

-- العنوان العلوي الثابت
local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, 0, 0, 35) Title.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
Title.Text = "صنع من قبل المطور الأسطوري أيهم"
Title.TextColor3 = Color3.fromRGB(255, 200, 0) Title.TextSize = 16 Title.Font = Enum.Font.SourceSansBold

-- القائمة الجانبية للتنقل
local SideMenu = Instance.new("Frame", MainFrame)
SideMenu.Size = UDim2.new(0, 130, 1, -35) SideMenu.Position = UDim2.new(0, 0, 0, 35)
SideMenu.BackgroundColor3 = Color3.fromRGB(15, 15, 15)

local ContentArea = Instance.new("Frame", MainFrame)
ContentArea.Size = UDim2.new(1, -130, 1, -35) ContentArea.Position = UDim2.new(0, 130, 0, 35)
ContentArea.BackgroundTransparency = 1

local Pages = {}
local tabs = {"اعدادات الماب", "اللاعب", "الاستهداف", "نقاط الحفظ", "التأثيرات", "الصناديق", "الرقصات"}

-- بناء وتفعيل الصفحات
for i, name in ipairs(tabs) do
    local btn = Instance.new("TextButton", SideMenu)
    btn.Size = UDim2.new(0.9, 0, 0, 38) btn.Position = UDim2.new(0.05, 0, 0, (i-1) * 44 + 12)
    btn.Text = name btn.BackgroundColor3 = Color3.fromRGB(235, 185, 0) btn.TextColor3 = Color3.fromRGB(0, 0, 0)
    btn.Font = Enum.Font.SourceSansBold btn.TextSize = 13
    
    local page = Instance.new("ScrollingFrame", ContentArea)
    page.Size = UDim2.new(1, 0, 1, 0) page.BackgroundTransparency = 1
    page.CanvasSize = UDim2.new(0, 0, 0, 450) page.ScrollBarThickness = 5
    page.Visible = (i == 1) Pages[i] = page
    
    btn.MouseButton1Click:Connect(function()
        for _, p in ipairs(Pages) do p.Visible = false end
        page.Visible = true
    end)
end

-- === [ شريحة 1: اعدادات الماب ] ===
local MapPage = Pages[1]
local BrightBtn = Instance.new("TextButton", MapPage)
BrightBtn.Size = UDim2.new(0.9, 0, 0, 35) BrightBtn.Position = UDim2.new(0.05, 0, 0, 10)
BrightBtn.Text = "جعل الماب مضوي بالكامل (FullBright)" BrightBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
BrightBtn.TextColor3 = Color3.fromRGB(255, 255, 255) BrightBtn.Font = Enum.Font.SourceSansBold BrightBtn.TextSize = 13
local brightActive = false
local originalBrightness = Lighting.Brightness
local originalAmbient = Lighting.Ambient
BrightBtn.MouseButton1Click:Connect(function()
    brightActive = not brightActive
    BrightBtn.BackgroundColor3 = brightActive and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(40, 40, 40)
    if brightActive then
        Lighting.Brightness = 4 Lighting.Ambient = Color3.fromRGB(255, 255, 255) Lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
    else
        Lighting.Brightness = originalBrightness Lighting.Ambient = originalAmbient
    end
end)

local colors = {"Rainbow", "Red", "Yellow", "Blue"}
local colorNames = {Rainbow = "حواف قوس قزح", Red = "حواف حمراء", Yellow = "حواف صفراء", Blue = "حواف زرقاء"}
for idx, mode in ipairs(colors) do
    local cBtn = Instance.new("TextButton", MapPage)
    cBtn.Size = UDim2.new(0.42, 0, 0, 32)
    cBtn.Position = UDim2.new(idx % 2 == 1 and 0.05 or 0.53, 0, 0, idx <= 2 and 60 or 100)
    cBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50) cBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    cBtn.Text = colorNames[mode] cBtn.Font = Enum.Font.SourceSansBold cBtn.TextSize = 12
    cBtn.MouseButton1Click:Connect(function() setBorderColor(mode) end)
end

-- === [ شريحة 2: اللاعب ] ===
local PlayerPage = Pages[2]
-- زر Fly V3 مضاف في شريحة اللاعب
local FlyBtn = Instance.new("TextButton", PlayerPage)
FlyBtn.Size = UDim2.new(0.9, 0, 0, 32) FlyBtn.Position = UDim2.new(0.05, 0, 0, 185)
FlyBtn.Text = "Fly V3" FlyBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 200) FlyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
FlyBtn.MouseButton1Click:Connect(function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/XNEOFF/FlyGuiV3/main/FlyGuiV3.txt"))()
end)

local SpeedLabel = Instance.new("TextLabel", PlayerPage)
SpeedLabel.Size = UDim2.new(0.3, 0, 0, 30) SpeedLabel.Position = UDim2.new(0.05, 0, 0, 15)
SpeedLabel.Text = "السرعة:" SpeedLabel.TextColor3 = Color3.fromRGB(255, 255, 255) SpeedLabel.BackgroundTransparency = 1
local SpeedInput = Instance.new("TextBox", PlayerPage)
SpeedInput.Size = UDim2.new(0.2, 0, 0, 30) SpeedInput.Position = UDim2.new(0.35, 0, 0, 15)
SpeedInput.BackgroundColor3 = Color3.fromRGB(40, 40, 40) SpeedInput.TextColor3 = Color3.fromRGB(255, 200, 0)
SpeedInput.Text = "65" SpeedInput.Font = Enum.Font.SourceSansBold SpeedInput.TextSize = 14
local SpeedBtn = Instance.new("TextButton", PlayerPage)
SpeedBtn.Size = UDim2.new(0.35, 0, 0, 30) SpeedBtn.Position = UDim2.new(0.6, 0, 0, 15)
SpeedBtn.Text = "تفعيل السرعة" SpeedBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50) SpeedBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
local speedActive = false
SpeedInput:GetPropertyChangedSignal("Text"):Connect(function()
    if speedActive and Player.Character and Player.Character:FindFirstChild("Humanoid") then
        Player.Character.Humanoid.WalkSpeed = tonumber(SpeedInput.Text) or 65
    end
end)
SpeedBtn.MouseButton1Click:Connect(function()
    speedActive = not speedActive
    SpeedBtn.BackgroundColor3 = speedActive and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(50, 50, 50)
    if speedActive then Player.Character.Humanoid.WalkSpeed = tonumber(SpeedInput.Text) or 65 else Player.Character.Humanoid.WalkSpeed = 16 end
end)
local JumpLabel = Instance.new("TextLabel", PlayerPage)
JumpLabel.Size = UDim2.new(0.3, 0, 0, 30) JumpLabel.Position = UDim2.new(0.05, 0, 0, 60)
JumpLabel.Text = "القفز:" JumpLabel.TextColor3 = Color3.fromRGB(255, 255, 255) JumpLabel.BackgroundTransparency = 1
local JumpInput = Instance.new("TextBox", PlayerPage)
JumpInput.Size = UDim2.new(0.2, 0, 0, 30) JumpInput.Position = UDim2.new(0.35, 0, 0, 60)
JumpInput.BackgroundColor3 = Color3.fromRGB(40, 40, 40) JumpInput.TextColor3 = Color3.fromRGB(255, 200, 0)
JumpInput.Text = "120" JumpInput.Font = Enum.Font.SourceSansBold JumpInput.TextSize = 14
local JumpBtn = Instance.new("TextButton", PlayerPage)
JumpBtn.Size = UDim2.new(0.35, 0, 0, 30) JumpBtn.Position = UDim2.new(0.6, 0, 0, 60)
JumpBtn.Text = "تفعيل القفز" JumpBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50) JumpBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
local jumpActive = false
JumpBtn.MouseButton1Click:Connect(function()
    jumpActive = not jumpActive
    JumpBtn.BackgroundColor3 = jumpActive and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(50, 50, 50)
    if Player.Character and Player.Character:FindFirstChild("Humanoid") then
        local val = tonumber(JumpInput.Text) or 120
        if jumpActive then
            Player.Character.Humanoid.UseJumpPower = false
            Player.Character.Humanoid.JumpHeight = val
            Player.Character.Humanoid.JumpPower = val
        else
            Player.Character.Humanoid.UseJumpPower = true
            Player.Character.Humanoid.JumpPower = 50
        end
    end
end)
local NoclipBtn = Instance.new("TextButton", PlayerPage)
NoclipBtn.Size = UDim2.new(0.9, 0, 0, 32) NoclipBtn.Position = UDim2.new(0.05, 0, 0, 105)
NoclipBtn.Text = "تفعيل اختراق الجدران (Noclip)" NoclipBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40) NoclipBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
local noclipActive = false local noclipConnection
NoclipBtn.MouseButton1Click:Connect(function()
    noclipActive = not noclipActive
    NoclipBtn.BackgroundColor3 = noclipActive and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(40, 40, 40)
    if noclipActive then
        noclipConnection = RunService.Stepped:Connect(function()
            if Player.Character then for _, part in ipairs(Player.Character:GetChildren()) do if part:IsA("BasePart") then part.CanCollide = false end end end
        end)
    else
        if noclipConnection then noclipConnection:Disconnect() noclipConnection = nil end
    end
end)
local InfJumpBtn = Instance.new("TextButton", PlayerPage)
InfJumpBtn.Size = UDim2.new(0.9, 0, 0, 32) InfJumpBtn.Position = UDim2.new(0.05, 0, 0, 145)
InfJumpBtn.Text = "تفعيل القفز اللانهائي (Inf Jump)" InfJumpBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40) InfJumpBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
local infJumpActive = false
UserInputService.JumpRequest:Connect(function()
    if infJumpActive and Player.Character and Player.Character:FindFirstChild("Humanoid") then Player.Character.Humanoid:ChangeState("Jumping") end
end)
InfJumpBtn.MouseButton1Click:Connect(function() infJumpActive = not infJumpActive InfJumpBtn.BackgroundColor3 = infJumpActive and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(40, 40, 40) end)

-- باقي الشرائح كما كانت...
local TargetPage = Pages[3]
local NameBox = Instance.new("TextBox", TargetPage)
NameBox.Size = UDim2.new(0.9, 0, 0, 35) NameBox.Position = UDim2.new(0.05, 0, 0, 10)
NameBox.BackgroundColor3 = Color3.fromRGB(30, 30, 30) NameBox.TextColor3 = Color3.fromRGB(255, 255, 255) NameBox.PlaceholderText = "اسم اللاعب..."
local TeleBtn = Instance.new("TextButton", TargetPage)
TeleBtn.Size = UDim2.new(0.9, 0, 0, 32) TeleBtn.Position = UDim2.new(0.05, 0, 0, 55)
TeleBtn.Text = "انتقال فوري للاعب" TeleBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50) TeleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
TeleBtn.MouseButton1Click:Connect(function()
    local tName = NameBox.Text:lower()
    for _, p in ipairs(PlayersService:GetPlayers()) do
        if p.Name:lower():sub(1, #tName) == tName and p.Character then Player.Character.HumanoidRootPart.CFrame = p.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3) end
    end
end)

local CheckpointPage = Pages[4]
local CPInput = Instance.new("TextBox", CheckpointPage)
CPInput.Size = UDim2.new(0.55, 0, 0, 32) CPInput.Position = UDim2.new(0.05, 0, 0, 10)
CPInput.BackgroundColor3 = Color3.fromRGB(30, 30, 30) CPInput.TextColor3 = Color3.fromRGB(255, 255, 255) CPInput.PlaceholderText = "اسم الموقع..."
local ListContainer = Instance.new("ScrollingFrame", CheckpointPage)
ListContainer.Size = UDim2.new(0.9, 0, 0, 160) ListContainer.Position = UDim2.new(0.05, 0, 0, 50)
ListContainer.BackgroundTransparency = 0.9 ListContainer.CanvasSize = UDim2.new(0, 0, 0, 600) ListContainer.ScrollBarThickness = 4
local function updateCPList()
    ListContainer:ClearAllChildren()
    local count = 0
    for name, cframe in pairs(savedLocations) do
        local ItemFrame = Instance.new("Frame", ListContainer)
        ItemFrame.Size = UDim2.new(0.95, 0, 0, 30) ItemFrame.Position = UDim2.new(0, 0, 0, count * 34)
        ItemFrame.BackgroundTransparency = 1
        local GoBtn = Instance.new("TextButton", ItemFrame)
        GoBtn.Size = UDim2.new(0.8, 0, 1, 0) GoBtn.Text = name
        GoBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45) GoBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        GoBtn.MouseButton1Click:Connect(function() if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then Player.Character.HumanoidRootPart.CFrame = cframe end end)
        local DelBtn = Instance.new("TextButton", ItemFrame)
        DelBtn.Size = UDim2.new(0.18, 0, 1, 0) DelBtn.Position = UDim2.new(0.82, 0, 0, 0)
        DelBtn.Text = "X" DelBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0) DelBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        DelBtn.MouseButton1Click:Connect(function() savedLocations[name] = nil updateCPList() end)
        count = count + 1
    end
end
local SaveBtn = Instance.new("TextButton", CheckpointPage)
SaveBtn.Size = UDim2.new(0.3, 0, 0, 32) SaveBtn.Position = UDim2.new(0.65, 0, 0, 10)
SaveBtn.Text = "حفظ" SaveBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0) SaveBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SaveBtn.MouseButton1Click:Connect(function()
    local locName = CPInput.Text
    if locName ~= "" and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
        savedLocations[locName] = Player.Character.HumanoidRootPart.CFrame
        CPInput.Text = "" updateCPList()
    end
end)

local EffectsPage = Pages[5]
local function clearAllEffects()
    if Player.Character then
        for _, item in ipairs(Player.Character:GetChildren()) do
            if item:IsA("Highlight") or item.Name == "PlayerParticles" then item:Destroy() end
        end
        local root = Player.Character:FindFirstChild("HumanoidRootPart")
        if root then
            for _, item in ipairs(root:GetChildren()) do
                if item.Name == "PlayerParticles" or item:IsA("ParticleEmitter") then item:Destroy() end
            end
        end
    end
end
local function giveDirectEffect(effectType, customColor)
    clearAllEffects()
    local root = Player.Character and Player.Character:FindFirstChild("HumanoidRootPart")
    if not root then return end
    if effectType == "Highlight" then
        local hl = Instance.new("Highlight")
        hl.Name = "PlayerHighlight" hl.FillColor = customColor hl.OutlineColor = Color3.fromRGB(255, 255, 255)
        hl.Parent = Player.Character
    elseif effectType == "Particles" then
        local pe = Instance.new("ParticleEmitter")
        pe.Name = "PlayerParticles" pe.Color = ColorSequence.new(customColor)
        pe.Speed = NumberRange.new(8, 12) pe.Rate = 80 pe.Lifetime = NumberRange.new(1, 1.5)
        pe.Size = NumberSequence.new(0.5, 0) pe.LightEmission = 0.5 pe.Parent = root
    elseif effectType == "Fire" then
        local f = Instance.new("Fire")
        f.Name = "PlayerParticles" f.Size = 10 f.Heat = 15 f.Parent = root
    end
end
local function createEffectBtn(text, yPos, color, callback)
    local btn = Instance.new("TextButton", EffectsPage) btn.Size = UDim2.new(0.9, 0, 0, 32) btn.Position = UDim2.new(0.05, 0, 0, yPos) btn.BackgroundColor3 = color btn.TextColor3 = Color3.fromRGB(255, 255, 255) btn.Text = text btn.Font = Enum.Font.SourceSansBold btn.TextSize = 13 btn.MouseButton1Click:Connect(callback)
end
createEffectBtn("تفعيل تأثير النار على الجسم فوراً", 10, Color3.fromRGB(210, 90, 0), function() giveDirectEffect("Fire") end)
createEffectBtn("تفعيل تأثير الإضاءة المشعة الشاملة (Highlight)", 48, Color3.fromRGB(0, 160, 160), function() giveDirectEffect("Highlight", Color3.fromRGB(0, 255, 255)) end)
createEffectBtn("تفعيل شظايا الذهب المصلحة (Yellow Particles)", 86, Color3.fromRGB(190, 190, 0), function() giveDirectEffect("Particles", Color3.fromRGB(255, 215, 0)) end)
createEffectBtn("تفعيل شظايا اللهب المصلحة (Red Particles)", 124, Color3.fromRGB(190, 0, 0), function() giveDirectEffect("Particles", Color3.fromRGB(255, 0, 0)) end)
createEffectBtn("إزالة كافة التأثيرات والبارتكلز فوراً", 170, Color3.fromRGB(60, 60, 60), function() clearAllEffects() end)

local ChestPage = Pages[6]
local chestData = {
    {name = "TE1", pos = CFrame.new(364.75, 72.27, -2792.82)},
    {name = "TE2", pos = CFrame.new(-87.30, 72.99, -2713.92)},
    {name = "TE3", pos = CFrame.new(-391.09, 72.99, -2659.82)},
    {name = "Green", pos = CFrame.new(-213.54, 73.27, -2343.59)}
}
for i, data in ipairs(chestData) do
    local btn = Instance.new("TextButton", ChestPage)
    btn.Size = UDim2.new(0.9, 0, 0, 45)
    btn.Position = UDim2.new(0.05, 0, 0, (i-1) * 55 + 10)
    btn.Text = data.name
    btn.BackgroundColor3 = Color3.fromRGB(0, 100, 0)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.SourceSansBold
    btn.MouseButton1Click:Connect(function()
        if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
            Player.Character.HumanoidRootPart.CFrame = data.pos
        end
    end)
end

local EmotePage = Pages[7]
EmotePage.ClipsDescendants = true 
local emoteList = {
    {name = "رقصة 1", id = "0000000000"},
    {name = "رقصة 2", id = "0000000000"}
}
EmotePage.CanvasSize = UDim2.new(0, 0, 0, (#emoteList * 55) + 20)
local function playEmote(id)
    local char = Player.Character
    if char and char:FindFirstChild("Humanoid") then
        local anim = Instance.new("Animation")
        anim.AnimationId = "rbxassetid://" .. id
        local track = char.Humanoid:LoadAnimation(anim)
        track:Play()
    end
end
for i, data in ipairs(emoteList) do
    local eBtn = Instance.new("TextButton", EmotePage)
    eBtn.Size = UDim2.new(0.9, 0, 0, 40)
    eBtn.Position = UDim2.new(0.05, 0, 0, (i-1) * 50 + 10)
    eBtn.Text = data.name
    eBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    eBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    eBtn.MouseButton1Click:Connect(function() playEmote(data.id) end)
end

local CloseBtn = Instance.new("TextButton", MainFrame) CloseBtn.Size = UDim2.new(0, 25, 0, 25) CloseBtn.Position = UDim2.new(1, -28, 0, 4) CloseBtn.Text = "X" CloseBtn.BackgroundColor3 = Color3.fromRGB(180, 0, 0) CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255) CloseBtn.MouseButton1Click:Connect(function() MainFrame.Visible = false end)
