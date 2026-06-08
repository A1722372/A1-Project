-- [[ سكريبت أيهم الأسطوري - نسخة التأثيرات والبارتكلز V5.6 ]]
local Player = game.Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")
local RunService = game:GetService("RunService")
local PlayersService = game:GetService("Players")

if PlayerGui:FindFirstChild("AihamSuperMenu") then PlayerGui.AihamSuperMenu:Destroy() end

local ScreenGui = Instance.new("ScreenGui", PlayerGui)
ScreenGui.Name = "AihamSuperMenu"
ScreenGui.ResetOnSpawn = false

-- الإطار الرئيسي
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 480, 0, 300)
MainFrame.Position = UDim2.new(0.5, -240, 0.5, -150)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.BorderSizePixel = 2
MainFrame.Visible = true
MainFrame.Active = true
MainFrame.Draggable = true

-- نظام التحكم بألوان الحواف
local currentBorderMode = "Rainbow"
local rainbowConnection
local function setBorderColor(mode)
    currentBorderMode = mode
    if rainbowConnection then rainbowConnection:Disconnect() rainbowConnection = nil end
    
    if mode == "Red" then
        MainFrame.BorderColor3 = Color3.fromRGB(255, 0, 0)
    elseif mode == "Yellow" then
        MainFrame.BorderColor3 = Color3.fromRGB(255, 200, 0)
    elseif mode == "Blue" then
        MainFrame.BorderColor3 = Color3.fromRGB(0, 100, 255)
    elseif mode == "Rainbow" then
        rainbowConnection = RunService.RenderStepped:Connect(function()
            local hue = (tick() % 4) / 4
            MainFrame.BorderColor3 = Color3.fromHSV(hue, 1, 1)
        end)
    end
end
setBorderColor("Rainbow")

-- زر الففتح والإغلاق الجانبي (●)
local ToggleButton = Instance.new("TextButton", ScreenGui)
ToggleButton.Size = UDim2.new(0, 40, 0, 40)
ToggleButton.Position = UDim2.new(0, 10, 0.5, -20)
ToggleButton.BackgroundColor3 = Color3.fromRGB(255, 200, 0)
ToggleButton.Text = "●"
ToggleButton.TextColor3 = Color3.fromRGB(0, 0, 0)
ToggleButton.TextSize = 22
ToggleButton.Font = Enum.Font.SourceSansBold
ToggleButton.BorderSizePixel = 1
ToggleButton.Active = true ToggleButton.Draggable = true
ToggleButton.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)

-- العنوان العلوي
local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, 0, 0, 35)
Title.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
Title.Text = "صنع من قبل المطور الأسطوري أيهم"
Title.TextColor3 = Color3.fromRGB(255, 200, 0)
Title.TextSize = 16 Title.Font = Enum.Font.SourceSansBold

-- القائمة الجانبية (الشرائح الخمسة الصفراء)
local SideMenu = Instance.new("Frame", MainFrame)
SideMenu.Size = UDim2.new(0, 130, 1, -35)
SideMenu.Position = UDim2.new(0, 0, 0, 35)
SideMenu.BackgroundColor3 = Color3.fromRGB(15, 15, 15)

local ContentArea = Instance.new("Frame", MainFrame)
ContentArea.Size = UDim2.new(1, -130, 1, -35)
ContentArea.Position = UDim2.new(0, 130, 0, 35)
ContentArea.BackgroundTransparency = 1

local Pages = {}
-- تم استبدال "انميشن" بـ "التأثيرات"
local tabs = {"اعدادات الماب", "اللاعب", "الاستهداف", "نقاط الحفظ", "التأثيرات"}

for i, name in ipairs(tabs) do
    local btn = Instance.new("TextButton", SideMenu)
    btn.Size = UDim2.new(0.9, 0, 0, 38)
    btn.Position = UDim2.new(0.05, 0, 0, (i-1) * 44 + 12)
    btn.Text = name
    btn.BackgroundColor3 = Color3.fromRGB(235, 185, 0)
    btn.TextColor3 = Color3.fromRGB(0, 0, 0)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 13
    
    local page = Instance.new("ScrollingFrame", ContentArea)
    page.Size = UDim2.new(1, 0, 1, 0)
    page.BackgroundTransparency = 1
    page.CanvasSize = UDim2.new(0, 0, 0, 350)
    page.ScrollBarThickness = 5
    page.Visible = (i == 1)
    Pages[i] = page
    
    btn.MouseButton1Click:Connect(function()
        for _, p in ipairs(Pages) do p.Visible = false end
        page.Visible = true
    end)
end

local function addFeature(parent, text, yPos, callback)
    local b = Instance.new("TextButton", parent)
    b.Size = UDim2.new(0.9, 0, 0, 32) b.Position = UDim2.new(0.05, 0, 0, yPos)
    b.BackgroundColor3 = Color3.fromRGB(40, 40, 40) b.TextColor3 = Color3.fromRGB(255, 255, 255)
    b.Text = text b.Font = Enum.Font.SourceSansBold b.TextSize = 13
    local active = false
    b.MouseButton1Click:Connect(function()
        active = not active
        b.BackgroundColor3 = active and Color3.fromRGB(0, 180, 0) or Color3.fromRGB(40, 40, 40)
        b.TextColor3 = active and Color3.fromRGB(0, 0, 0) or Color3.fromRGB(255, 255, 255)
        callback(active, b)
    end)
    return b
end

-- === [ شريحة 1: اعدادات الماب ] ===
local MapPage = Pages[1]
addFeature(MapPage, "تجميع الصناديق التلقائي (Auto Farm)", 10, function(active)
    _G.FarmBoxes = active
    spawn(function()
        while _G.FarmBoxes do
            pcall(function()
                for _, v in pairs(workspace:GetDescendants()) do
                    if v:IsA("TouchTransmitter") and v.Parent.Name:lower():find("box") then
                        firetouchinterest(Player.Character.HumanoidRootPart, v.Parent, 0)
                    end
                end
            end)
            task.wait(1)
        end
    end)
end)

local colors = {"Rainbow", "Red", "Yellow", "Blue"}
local colorNames = {Rainbow = "حواف قوس قزح", Red = "حواف حمراء", Yellow = "حواف صفراء", Blue = "حواف زرقاء"}
for idx, mode in ipairs(colors) do
    local cBtn = Instance.new("TextButton", MapPage)
    cBtn.Size = UDim2.new(0.42, 0, 0, 30)
    cBtn.Position = UDim2.new(idx % 2 == 1 and 0.05 or 0.53, 0, 0, idx <= 2 and 55 or 90)
    cBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50) cBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    cBtn.Text = colorNames[mode] cBtn.Font = Enum.Font.SourceSansBold cBtn.TextSize = 12
    cBtn.MouseButton1Click:Connect(function() setBorderColor(mode) end)
end

-- === [ شريحة 2: اللاعب ] ===
local PlayerPage = Pages[2]
local SpeedInput = Instance.new("TextBox", PlayerPage)
SpeedInput.Size = UDim2.new(0.25, 0, 0, 32) SpeedInput.Position = UDim2.new(0.7, 0, 0, 10)
SpeedInput.BackgroundColor3 = Color3.fromRGB(30, 30, 30) SpeedInput.TextColor3 = Color3.fromRGB(255, 215, 0) SpeedInput.Text = "65"

addFeature(PlayerPage, "تفعيل السرعة الفائقة", 10, function(active)
    Player.Character.Humanoid.WalkSpeed = active and (tonumber(SpeedInput.Text) or 65) or 16
end)

local JumpInput = Instance.new("TextBox", PlayerPage)
JumpInput.Size = UDim2.new(0.25, 0, 0, 32) JumpInput.Position = UDim2.new(0.7, 0, 0, 50)
JumpInput.BackgroundColor3 = Color3.fromRGB(30, 30, 30) JumpInput.TextColor3 = Color3.fromRGB(255, 215, 0) JumpInput.Text = "120"

addFeature(PlayerPage, "تفعيل قوة القفز", 50, function(active)
    Player.Character.Humanoid.JumpPower = active and (tonumber(JumpInput.Text) or 120) or 50
end)

-- === [ شريحة 3: الاستهداف ] ===
local TargetPage = Pages[3]
local NameBox = Instance.new("TextBox", TargetPage)
NameBox.Size = UDim2.new(0.9, 0, 0, 35) NameBox.Position = UDim2.new(0.05, 0, 0, 10)
NameBox.BackgroundColor3 = Color3.fromRGB(30, 30, 30) NameBox.TextColor3 = Color3.fromRGB(255, 255, 255) NameBox.PlaceholderText = "اسم اللاعب..."

local TeleBtn = Instance.new("TextButton", TargetPage)
TeleBtn.Size = UDim2.new(0.9, 0, 0, 32) TeleBtn.Position = UDim2.new(0.05, 0, 0, 55)
TeleBtn.Text = "انتقال فوري" TeleBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50) TeleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
TeleBtn.MouseButton1Click:Connect(function()
    local tName = NameBox.Text:lower()
    for _, p in ipairs(PlayersService:GetPlayers()) do
        if p.Name:lower():sub(1, #tName) == tName and p.Character then
            Player.Character.HumanoidRootPart.CFrame = p.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3)
        end
    end
end)

addFeature(TargetPage, "تفعيل التجسس للكاميرا", 95, function(active)
    local tName = NameBox.Text:lower()
    if active and tName ~= "" then
        for _, p in ipairs(PlayersService:GetPlayers()) do
            if p.Name:lower():sub(1, #tName) == tName and p.Character then workspace.CurrentCamera.CameraSubject = p.Character.Humanoid break end
        end
    else
        workspace.CurrentCamera.CameraSubject = Player.Character:FindFirstChildOfClass("Humanoid")
    end
end)

-- === [ شريحة 4: نقاط الحفظ المتعددة ] ===
local CheckpointPage = Pages[4]
local savedLocations = {}

local CPInput = Instance.new("TextBox", CheckpointPage)
CPInput.Size = UDim2.new(0.55, 0, 0, 32) CPInput.Position = UDim2.new(0.05, 0, 0, 10)
CPInput.BackgroundColor3 = Color3.fromRGB(30, 30, 30) CPInput.TextColor3 = Color3.fromRGB(255, 255, 255)
CPInput.PlaceholderText = "اكتب اسم الموقع هنا..."

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
        GoBtn.MouseButton1Click:Connect(function()
            if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then Player.Character.HumanoidRootPart.CFrame = cframe end
        end)
        
        local DelBtn = Instance.new("TextButton", ItemFrame)
        DelBtn.Size = UDim2.new(0.18, 0, 1, 0) DelBtn.Position = UDim2.new(0.82, 0, 0, 0)
        DelBtn.Text = "X" DelBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0) DelBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        DelBtn.MouseButton1Click:Connect(function()
            savedLocations[name] = nil
            updateCPList()
        end)
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
        CPInput.Text = ""
        updateCPList()
    end
end)

-- === [ شريحة 5: التأثيرات والبارتكلز (بديلة الأنيميشن) ] ===
local EffectsPage = Pages[5]

local function clearEffects()
    local root = Player.Character and Player.Character:FindFirstChild("HumanoidRootPart")
    if root then
        for _, obj in ipairs(root:GetChildren()) do
            if obj:IsA("ParticleEmitter") or obj:IsA("Fire") or obj:IsA("Highlight") then
                obj:Destroy()
            end
        end
    end
end

local function createEffectBtn(text, yPos, color, callback)
    local btn = Instance.new("TextButton", EffectsPage)
    btn.Size = UDim2.new(0.9, 0, 0, 32) btn.Position = UDim2.new(0.05, 0, 0, yPos)
    btn.BackgroundColor3 = color btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Text = text btn.Font = Enum.Font.SourceSansBold btn.TextSize = 13
    btn.MouseButton1Click:Connect(callback)
end

-- زر تأثير النار (الاشتعال)
createEffectBtn("تأثير الاشتعال بالنار", 10, Color3.fromRGB(200, 80, 0), function()
    clearEffects()
    local root = Player.Character and Player.Character:FindFirstChild("HumanoidRootPart")
    if root then Instance.new("Fire", root) end
end)

-- تأثير الإضاءة المشعة (تولع وتضوي بالكامل)
createEffectBtn("تأثير الإضاءة المشعة (Highlight)", 48, Color3.fromRGB(0, 150, 150), function()
    clearEffects()
    local char = Player.Character
    if char then
        local hl = Instance.new("Highlight", char)
        hl.FillColor = Color3.fromRGB(0, 255, 255)
        hl.OutlineColor = Color3.fromRGB(255, 255, 255)
    end
end)

-- تأثير شظايا لون أصفر
createEffectBtn("شظايا جزيئات باللون الأصفر", 86, Color3.fromRGB(180, 180, 0), function()
    clearEffects()
    local root = Player.Character and Player.Character:FindFirstChild("HumanoidRootPart")
    if root then
        local pe = Instance.new("ParticleEmitter", root)
        pe.Color = ColorSequence.new(Color3.fromRGB(255, 215, 0))
        pe.Speed = NumberRange.new(5, 10)
        pe.Rate = 50
    end
end)

-- تأثير شظايا لون أحمر
createEffectBtn("شظايا جزيئات باللون الأحمر", 124, Color3.fromRGB(180, 0, 0), function()
    clearEffects()
    local root = Player.Character and Player.Character:FindFirstChild("HumanoidRootPart")
    if root then
        local pe = Instance.new("ParticleEmitter", root)
        pe.Color = ColorSequence.new(Color3.fromRGB(255, 0, 0))
        pe.Speed = NumberRange.new(5, 10)
        pe.Rate = 50
    end
end)

-- زر إطفاء وإزالة كافة التأثيرات
createEffectBtn("إزالة كافة التأثيرات عن الشخصية", 170, Color3.fromRGB(60, 60, 60), function()
    clearEffects()
end)

-- زر إغلاق القائمة (X) العلوي
local CloseBtn = Instance.new("TextButton", MainFrame)
CloseBtn.Size = UDim2.new(0, 25, 0, 25) CloseBtn.Position = UDim2.new(1, -28, 0, 4)
CloseBtn.Text = "X" CloseBtn.BackgroundColor3 = Color3.fromRGB(180, 0, 0) CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.MouseButton1Click:Connect(function() MainFrame.Visible = false end)
