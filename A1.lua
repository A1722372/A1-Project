-- [[ سكريبت أيهم الأسطوري V12 - مع واجهة زاهية وملونة بالكامل ]]
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

-- === [ الإطار الرئيسي المحدث ] ===
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 500, 0, 350) -- تكبير الحجم قليلاً للتصميم الجديد
MainFrame.Position = UDim2.new(0.5, -250, 0.5, -175)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25) -- خلفية داكنة قليلاً
MainFrame.BorderSizePixel = 0 -- إزالة الحدود التقليدية

-- إضافة حافة بنفسجية مضيئة (UIGradient)
local FrameStroke = Instance.new("UIStroke", MainFrame)
FrameStroke.Thickness = 3
FrameStroke.Color = Color3.fromRGB(150, 0, 255) -- لون بنفسجي مشبع

local FrameCorner = Instance.new("UICorner", MainFrame)
FrameCorner.CornerRadius = UDim.new(0, 10) -- حواف دائرية

MainFrame.Active = true
MainFrame.Draggable = true -- الحفاظ على خاصية السحب

-- جدول نقاط الحفظ الخاص بشريحة الحفظ
local savedLocations = {}

-- === [ زر الفتح والإغلاق الجانبي المحدث (المظهر القديم بألوان جديدة) ] ===
local ToggleButton = Instance.new("TextButton", ScreenGui)
ToggleButton.Size = UDim2.new(0, 50, 0, 50) -- تكبير الزر قليلاً
ToggleButton.Position = UDim2.new(0, 15, 0.5, -25)
ToggleButton.BackgroundColor3 = Color3.fromRGB(150, 0, 255) -- لون بنفسجي
ToggleButton.Text = "A" -- تغيير النص ليرمز لـ "أيهم"
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.TextSize = 26 ToggleButton.Font = Enum.Font.SourceSansBold
ToggleButton.Active = true ToggleButton.Draggable = true

local ButtonCorner = Instance.new("UICorner", ToggleButton)
ButtonCorner.CornerRadius = UDim.new(1, 0) -- زر دائري بالكامل

ToggleButton.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)

-- === [ العنوان العلوي المحدث ] ===
local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, -30, 0, 40) Title.Position = UDim2.new(0, 0, 0, 0)
Title.BackgroundColor3 = Color3.fromRGB(15, 15, 15) -- خلفية داكنة للعنوان
Title.BackgroundTransparency = 1 -- شفاف ليعتمد على خلفية الإطار
Title.Text = "صنع من قبل المطور الأسطوري أيهم"
Title.TextColor3 = Color3.fromRGB(255, 255, 255) -- نص أبيض
Title.TextSize = 18 Title.Font = Enum.Font.SourceSansBold

local TitleCorner = Instance.new("UICorner", Title)
TitleCorner.CornerRadius = UDim.new(0, 10) -- حواف دائرية للعنوان

-- === [ القائمة الجانبية المحدثة ] ===
local SideMenu = Instance.new("Frame", MainFrame)
SideMenu.Size = UDim2.new(0, 140, 1, -40) SideMenu.Position = UDim2.new(0, 0, 0, 40)
SideMenu.BackgroundColor3 = Color3.fromRGB(20, 20, 20) -- خلفية القائمة
SideMenu.BorderSizePixel = 0

local SideCorner = Instance.new("UICorner", SideMenu)
SideCorner.CornerRadius = UDim.new(0, 10) -- حواف دائرية

local ContentArea = Instance.new("Frame", MainFrame)
ContentArea.Size = UDim2.new(1, -140, 1, -40) ContentArea.Position = UDim2.new(0, 140, 0, 40)
ContentArea.BackgroundTransparency = 1

local Pages = {}
local tabs = {"اعدادات الماب", "اللاعب", "الاستهداف", "نقاط الحفظ", "التأثيرات"}

-- بناء وتفعيل الصفحات والشرائح بالكامل (مع تعديل الألوان)
for i, name in ipairs(tabs) do
    local btn = Instance.new("TextButton", SideMenu)
    btn.Size = UDim2.new(0.9, 0, 0, 40) btn.Position = UDim2.new(0.05, 0, 0, (i-1) * 46 + 15)
    btn.Text = name btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40) btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.SourceSansBold btn.TextSize = 14
    
    local BtnCorner = Instance.new("UICorner", btn)
    BtnCorner.CornerRadius = UDim.new(0, 8)
    
    local page = Instance.new("ScrollingFrame", ContentArea)
    page.Size = UDim2.new(1, -10, 1, -10) page.Position = UDim2.new(0, 5, 0, 5)
    page.BackgroundTransparency = 1
    page.CanvasSize = UDim2.new(0, 0, 0, 500) page.ScrollBarThickness = 6
    page.Visible = (i == 1) Pages[i] = page
    
    -- تأثيرات تفاعلية للأزرار
    btn.MouseEnter:Connect(function() btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60) end)
    btn.MouseLeave:Connect(function() btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40) end)
    
    btn.MouseButton1Click:Connect(function()
        for _, p in ipairs(Pages) do p.Visible = false end
        page.Visible = true
    end)
end

-- === [ دوال مساعدة لإنشاء عناصر الواجهة بألوان جديدة ] ===
local function createButton(parent, text, yPos, color, callback)
    local btn = Instance.new("TextButton", parent)
    btn.Size = UDim2.new(0.9, 0, 0, 38) btn.Position = UDim2.new(0.05, 0, 0, yPos)
    btn.Text = text btn.BackgroundColor3 = color btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.SourceSansBold btn.TextSize = 14
    local BtnCorner = Instance.new("UICorner", btn) BtnCorner.CornerRadius = UDim.new(0, 8)
    btn.MouseButton1Click:Connect(callback)
    return btn
end

local function createTextBox(parent, placeholder, yPos, callback)
    local box = Instance.new("TextBox", parent)
    box.Size = UDim2.new(0.9, 0, 0, 38) box.Position = UDim2.new(0.05, 0, 0, yPos)
    box.BackgroundColor3 = Color3.fromRGB(40, 40, 40) box.TextColor3 = Color3.fromRGB(255, 255, 255)
    box.PlaceholderText = placeholder box.Font = Enum.Font.SourceSansBold box.TextSize = 14
    local BoxCorner = Instance.new("UICorner", box) BoxCorner.CornerRadius = UDim.new(0, 8)
    if callback then box.FocusLost:Connect(function(enter) if enter then callback(box.Text) end end) end
    return box
end

local function createLabel(parent, text, yPos)
    local label = Instance.new("TextLabel", parent)
    label.Size = UDim2.new(0.9, 0, 0, 30) label.Position = UDim2.new(0.05, 0, 0, yPos)
    label.Text = text label.TextColor3 = Color3.fromRGB(255, 255, 255) label.BackgroundTransparency = 1
    label.Font = Enum.Font.SourceSansBold label.TextSize = 14
    return label
end

-- === [ شريحة 1: اعدادات الماب ] ===
local MapPage = Pages[1]

local brightActive = false
local originalBrightness = Lighting.Brightness
local originalAmbient = Lighting.Ambient
local originalOutdoorAmbient = Lighting.OutdoorAmbient

local BrightBtn = createButton(MapPage, "تفعيل FullBright (إضاءة كاملة)", 15, Color3.fromRGB(40, 40, 40), function()
    brightActive = not brightActive
    MapPage:FindFirstChild("FullBrightButton").BackgroundColor3 = brightActive and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(40, 40, 40)
    if brightActive then
        Lighting.Brightness = 4 Lighting.Ambient = Color3.fromRGB(255, 255, 255) Lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
    else
        Lighting.Brightness = originalBrightness Lighting.Ambient = originalAmbient Lighting.OutdoorAmbient = originalOutdoorAmbient
    end
end)
BrightBtn.Name = "FullBrightButton"

createLabel(MapPage, "تغيير لون حواف الواجهة:", 65)

local colors = {"Rainbow", "Red", "Yellow", "Blue", "Green", "Orange", "Purple", "Pink", "Cyan", "Lime"}
local colorData = {
    Rainbow = {name = "قوس قزح", color = nil, isRainbow = true},
    Red = {name = "أحمر", color = Color3.fromRGB(255, 0, 0)},
    Yellow = {name = "أصفر", color = Color3.fromRGB(255, 200, 0)},
    Blue = {name = "أزرق", color = Color3.fromRGB(0, 100, 255)},
    Green = {name = "أخضر", color = Color3.fromRGB(0, 200, 0)},
    Orange = {name = "برتقالي", color = Color3.fromRGB(255, 120, 0)},
    Purple = {name = "بنفسجي", color = Color3.fromRGB(150, 0, 255)},
    Pink = {name = "وردي", color = Color3.fromRGB(255, 100, 200)},
    Cyan = {name = "سماوي", color = Color3.fromRGB(0, 200, 255)},
    Lime = {name = "ليموني", color = Color3.fromRGB(150, 255, 0)}
}

local rainbowConnection
local function setBorderColor(mode)
    if rainbowConnection then rainbowConnection:Disconnect() rainbowConnection = nil end
    local data = colorData[mode]
    if data then
        if data.isRainbow then
            rainbowConnection = RunService.RenderStepped:Connect(function()
                local hue = (tick() % 4) / 4
                FrameStroke.Color = Color3.fromHSV(hue, 1, 1)
            end)
        else
            FrameStroke.Color = data.color
        end
    end
end

-- إنشاء أزرار الألوان بشكل تلقائي
local colorContainer = Instance.new("Frame", MapPage)
colorContainer.Size = UDim2.new(0.9, 0, 0, 250) colorContainer.Position = UDim2.new(0.05, 0, 0, 95)
colorContainer.BackgroundTransparency = 1

local colorLayout = Instance.new("UIGridLayout", colorContainer)
colorLayout.CellSize = UDim2.new(0, 100, 0, 35) colorLayout.CellPadding = UDim2.new(0, 10, 0, 10)
colorLayout.SortOrder = Enum.SortOrder.LayoutOrder

for idx, mode in ipairs(colors) do
    local data = colorData[mode]
    local cBtn = Instance.new("TextButton", colorContainer)
    cBtn.Text = data.name cBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50) cBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    cBtn.Font = Enum.Font.SourceSansBold cBtn.TextSize = 13 cBtn.LayoutOrder = idx
    local BtnCorner = Instance.new("UICorner", cBtn) BtnCorner.CornerRadius = UDim.new(0, 8)
    
    if data.isRainbow then
        local gradient = Instance.new("UIGradient", cBtn)
        gradient.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.new(1,0,0)), ColorSequenceKeypoint.new(0.5, Color3.new(0,1,0)), ColorSequenceKeypoint.new(1, Color3.new(0,0,1))})
        RunService.RenderStepped:Connect(function() gradient.Rotation = (tick() % 5) * 72 end)
    else
        local line = Instance.new("Frame", cBtn)
        line.Size = UDim2.new(1, 0, 0, 3) line.Position = UDim2.new(0, 0, 1, -3)
        line.BackgroundColor3 = data.color line.BorderSizePixel = 0
        local LineCorner = Instance.new("UICorner", line) LineCorner.CornerRadius = UDim.new(0, 2)
    end
    
    cBtn.MouseButton1Click:Connect(function() setBorderColor(mode) end)
end

-- === [ شريحة 2: اللاعب ] ===
local PlayerPage = Pages[2]

createLabel(PlayerPage, "السرعة:", 15)
local SpeedInput = createTextBox(PlayerPage, "مثلاً: 65", 45) SpeedInput.Text = "65"
local speedActive = false
local SpeedBtn = createButton(PlayerPage, "تفعيل السرعة", 90, Color3.fromRGB(50, 50, 50), function()
    speedActive = not speedActive
    PlayerPage:FindFirstChild("SpeedButton").BackgroundColor3 = speedActive and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(50, 50, 50)
    if speedActive then Player.Character.Humanoid.WalkSpeed = tonumber(SpeedInput.Text) or 65 else Player.Character.Humanoid.WalkSpeed = 16 end
end)
SpeedBtn.Name = "SpeedButton"

createLabel(PlayerPage, "القفز:", 145)
local JumpInput = createTextBox(PlayerPage, "مثلاً: 120", 175) JumpInput.Text = "120"
local jumpActive = false
local JumpBtn = createButton(PlayerPage, "تفعيل القفز", 220, Color3.fromRGB(50, 50, 50), function()
    jumpActive = not jumpActive
    PlayerPage:FindFirstChild("JumpButton").BackgroundColor3 = jumpActive and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(50, 50, 50)
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
JumpBtn.Name = "JumpButton"

-- زر الطيران
local flying = false
local flyConnection
local bodyVelocity, bodyGyro
local FlyBtn = createButton(PlayerPage, "تفعيل الطيران السهل (Fly)", 275, Color3.fromRGB(150, 0, 255), function()
    flying = not flying
    local btn = PlayerPage:FindFirstChild("FlyButton")
    btn.BackgroundColor3 = flying and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(150, 0, 255)
    btn.Text = flying and "تعطيل الطيران" or "تفعيل الطيران السهل (Fly)"
    
    local torso = Player.Character and (Player.Character:FindFirstChild("UpperTorso") or Player.Character:FindFirstChild("HumanoidRootPart"))
    if not torso then return end
    
    if flying then
        bodyVelocity = Instance.new("BodyVelocity", torso)
        bodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        bodyVelocity.Velocity = Vector3.new(0, 0, 0)
        
        bodyGyro = Instance.new("BodyGyro", torso)
        bodyGyro.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
        bodyGyro.CFrame = torso.CFrame
        
        flyConnection = RunService.RenderStepped:Connect(function()
            if Player.Character and torso and bodyVelocity and bodyGyro then
                bodyGyro.CFrame = workspace.CurrentCamera.CFrame
                local moveDirection = Player.Character.Humanoid.MoveDirection
                local velocity = moveDirection * 70
                
                if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                    velocity = velocity + Vector3.new(0, 50, 0)
                elseif UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
                    velocity = velocity + Vector3.new(0, -50, 0)
                end
                bodyVelocity.Velocity = velocity
            end
        end)
    else
        if flyConnection then flyConnection:Disconnect() flyConnection = nil end
        if bodyVelocity then bodyVelocity:Destroy() end
        if bodyGyro then bodyGyro:Destroy() end
    end
end)
FlyBtn.Name = "FlyButton"

local noclipActive = false local noclipConnection
createButton(PlayerPage, "تفعيل اختراق الجدران (Noclip)", 325, Color3.fromRGB(40, 40, 40), function()
    noclipActive = not noclipActive
    PlayerPage:FindFirstChild("NoclipButton").BackgroundColor3 = noclipActive and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(40, 40, 40)
    if noclipActive then
        noclipConnection = RunService.Stepped:Connect(function()
            if Player.Character then for _, part in ipairs(Player.Character:GetChildren()) do if part:IsA("BasePart") then part.CanCollide = false end end end
        end)
    else
        if noclipConnection then noclipConnection:Disconnect() noclipConnection = nil end
    end
end).Name = "NoclipButton"

local infJumpActive = false
UserInputService.JumpRequest:Connect(function()
    if infJumpActive and Player.Character and Player.Character:FindFirstChild("Humanoid") then Player.Character.Humanoid:ChangeState("Jumping") end
end)
createButton(PlayerPage, "تفعيل القفز اللانهائي (Inf Jump)", 375, Color3.fromRGB(40, 40, 40), function()
    infJumpActive = not infJumpActive
    PlayerPage:FindFirstChild("InfJumpButton").BackgroundColor3 = infJumpActive and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(40, 40, 40)
end).Name = "InfJumpButton"

-- === [ شريحة 3: الاستهداف ] ===
local TargetPage = Pages[3]
local NameBox = createTextBox(TargetPage, "اكتب اسم اللاعب هنا...", 15)

createButton(TargetPage, "انتقال فوري للاعب", 65, Color3.fromRGB(150, 0, 255), function()
    local tName = NameBox.Text:lower()
    for _, p in ipairs(PlayersService:GetPlayers()) do
        if p.Name:lower():sub(1, #tName) == tName and p.Character then Player.Character.HumanoidRootPart.CFrame = p.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3) end
    end
end)

-- === [ شريحة 4: نقاط الحفظ اليدوية ] ===
local CheckpointPage = Pages[4]
local CPInput = createTextBox(CheckpointPage, "اسم الموقع...", 15)

local ListContainer = Instance.new("ScrollingFrame", CheckpointPage)
ListContainer.Size = UDim2.new(0.9, 0, 0, 200) ListContainer.Position = UDim2.new(0.05, 0, 0, 65)
ListContainer.BackgroundTransparency = 0.9 ListContainer.CanvasSize = UDim2.new(0, 0, 0, 600) ListContainer.ScrollBarThickness = 5
local ListLayout = Instance.new("UIListLayout", ListContainer) ListLayout.Padding = UDim.new(0, 5) ListLayout.SortOrder = Enum.SortOrder.Name

local function updateCPList()
    ListContainer:ClearAllChildren()
    Instance.new("UIListLayout", ListContainer).Padding = UDim.new(0, 5)
    
    for name, cframe in pairs(savedLocations) do
        local ItemFrame = Instance.new("Frame", ListContainer)
        ItemFrame.Size = UDim2.new(1, 0, 0, 35) ItemFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        ItemFrame.Name = name
        local FrameCorner = Instance.new("UICorner", ItemFrame) FrameCorner.CornerRadius = UDim.new(0, 6)
        
        local GoBtn = Instance.new("TextButton", ItemFrame)
        GoBtn.Size = UDim2.new(0.75, 0, 1, 0) GoBtn.Position = UDim2.new(0, 0, 0, 0)
        GoBtn.Text = name GoBtn.BackgroundTransparency = 1 GoBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        GoBtn.Font = Enum.Font.SourceSansBold GoBtn.TextSize = 13
        GoBtn.MouseButton1Click:Connect(function() if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then Player.Character.HumanoidRootPart.CFrame = cframe end end)
        
        local DelBtn = Instance.new("TextButton", ItemFrame)
        DelBtn.Size = UDim2.new(0.2, 0, 0.8, 0) DelBtn.Position = UDim2.new(0.78, 0, 0.1, 0)
        DelBtn.Text = "حذف" DelBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0) DelBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        DelBtn.Font = Enum.Font.SourceSansBold DelBtn.TextSize = 12
        local DelCorner = Instance.new("UICorner", DelBtn) DelCorner.CornerRadius = UDim.new(0, 6)
        DelBtn.MouseButton1Click:Connect(function() savedLocations[name] = nil updateCPList() end)
    end
end

createButton(CheckpointPage, "حفظ الموقع الحالي", 280, Color3.fromRGB(0, 150, 0), function()
    local locName = CPInput.Text
    if locName ~= "" and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
        savedLocations[locName] = Player.Character.HumanoidRootPart.CFrame
        CPInput.Text = "" updateCPList()
    end
end)

-- === [ شريحة 5: التأثيرات ] ===
local EffectsPage = Pages[5]

local function clearAllEffects()
    if Player.Character then
        for _, item in ipairs(Player.Character:GetChildren()) do
            if item:IsA("Highlight") or item.Name == "PlayerParticles" or item.Name == "PlayerFire" then item:Destroy() end
        end
        local root = Player.Character:FindFirstChild("HumanoidRootPart")
        if root then
            for _, item in ipairs(root:GetChildren()) do
                if item.Name == "PlayerParticles" or item:IsA("ParticleEmitter") or item.Name == "PlayerFire" then item:Destroy() end
            end
        end
    end
end

local function giveDirectEffect(effectType, customColor)
    clearAllEffects()
    local root = Player.Character and Player.Character:FindFirstChild("HumanoidRootPart")
    if not root then return end
    
    if effectType == "Highlight" then
        local hl = Instance.new("Highlight") hl.Name = "PlayerHighlight" hl.FillColor = customColor hl.OutlineColor = Color3.fromRGB(255, 255, 255) hl.Parent = Player.Character
    elseif effectType == "Particles" then
        local pe = Instance.new("ParticleEmitter") pe.Name = "PlayerParticles" pe.Color = ColorSequence.new(customColor) pe.Speed = NumberRange.new(8, 12) pe.Rate = 80 pe.Lifetime = NumberRange.new(1, 1.5) pe.Size = NumberSequence.new(0.5, 0) pe.Parent = root
    elseif effectType == "Fire" then
        local f = Instance.new("Fire") f.Name = "PlayerFire" f.Size = 10 f.Heat = 15 f.Parent = root
    end
end

createButton(EffectsPage, "تفعيل تأثير النار على الجسم فوراً", 15, Color3.fromRGB(210, 90, 0), function() giveDirectEffect("Fire") end)
createButton(EffectsPage, "تفعيل الإضاءة المشعة (Highlight)", 65, Color3.fromRGB(0, 160, 160), function() giveDirectEffect("Highlight", Color3.fromRGB(0, 255, 255)) end)
createButton(EffectsPage, "تفعيل شظايا الذهب (Gold Particles)", 115, Color3.fromRGB(190, 190, 0), function() giveDirectEffect("Particles", Color3
