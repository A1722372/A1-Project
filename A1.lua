-- [[ سكريبت أيهم الأسطوري - النسخة الذهبية المتكاملة V18 ]]
local Player = game.Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")
local RunService = game:GetService("RunService")
local PlayersService = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local TweenService = game:GetService("TweenService")

if PlayerGui:FindFirstChild("AihamSuperMenu") then PlayerGui.AihamSuperMenu:Destroy() end

local ScreenGui = Instance.new("ScreenGui", PlayerGui)
ScreenGui.Name = "AihamSuperMenu"
ScreenGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 490, 0, 340)
MainFrame.Position = UDim2.new(0.5, -245, 0.5, -170)
MainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
MainFrame.BorderSizePixel = 3
MainFrame.BorderColor3 = Color3.fromRGB(255, 200, 0)
MainFrame.Active = true
MainFrame.Draggable = true

local yellowElements = {}
local rainbowConnection

-- دالة التحكم بالألوان والإطارات
local function setBorderColor(mode)
    if rainbowConnection then rainbowConnection:Disconnect() rainbowConnection = nil end
    local function applyColor(color)
        MainFrame.BorderColor3 = color
        for _, obj in ipairs(yellowElements) do
            if obj and obj.Parent then
                if obj:IsA("TextButton") then obj.BackgroundColor3 = color
                elseif obj:IsA("TextLabel") or obj:IsA("TextBox") then obj.TextColor3 = color end
            end
        end
    end
    if mode == "Red" then applyColor(Color3.fromRGB(255, 0, 0))
    elseif mode == "Yellow" then applyColor(Color3.fromRGB(255, 200, 0))
    elseif mode == "Blue" then applyColor(Color3.fromRGB(0, 100, 255))
    elseif mode == "Rainbow" then
        rainbowConnection = RunService.RenderStepped:Connect(function()
            applyColor(Color3.fromHSV((tick() % 4) / 4, 1, 1))
        end)
    end
end

-- زر التصغير العائم الذكي
local ToggleButton = Instance.new("TextButton", ScreenGui)
ToggleButton.Size = UDim2.new(0, 42, 0, 42) ToggleButton.Position = UDim2.new(0, 10, 0.5, -21)
ToggleButton.BackgroundColor3 = Color3.fromRGB(255, 200, 0) ToggleButton.Text = ""
ToggleButton.BorderSizePixel = 2 ToggleButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
ToggleButton.Active = true ToggleButton.Draggable = true
local Dot = Instance.new("Frame", ToggleButton)
Dot.Size = UDim2.new(0, 12, 0, 12) Dot.Position = UDim2.new(0.5, -6, 0.5, -6)
Dot.BackgroundColor3 = Color3.fromRGB(0, 0, 0) Dot.BorderSizePixel = 0
local DotCorner = Instance.new("UICorner", Dot) DotCorner.CornerRadius = UDim.new(1, 0)
ToggleButton.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)
table.insert(yellowElements, ToggleButton)

-- لوحة العنوان
local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, 0, 0, 35) Title.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
Title.Text = "صنع من قبل المطور الأسطوري أيهم"
Title.TextColor3 = Color3.fromRGB(255, 200, 0) Title.TextSize = 15 Title.Font = Enum.Font.SourceSansBold
table.insert(yellowElements, Title)

local CloseBtn = Instance.new("TextButton", MainFrame) 
CloseBtn.Size = UDim2.new(0, 25, 0, 25) CloseBtn.Position = UDim2.new(1, -28, 0, 5) 
CloseBtn.Text = "X" CloseBtn.Font = Enum.Font.SourceSansBold CloseBtn.TextSize = 14
CloseBtn.BackgroundColor3 = Color3.fromRGB(180, 0, 0) CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255) 
CloseBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

local SideMenu = Instance.new("ScrollingFrame", MainFrame)
SideMenu.Size = UDim2.new(0, 135, 1, -35) SideMenu.Position = UDim2.new(0, 0, 0, 35)
SideMenu.BackgroundColor3 = Color3.fromRGB(12, 12, 12) SideMenu.CanvasSize = UDim2.new(0, 0, 0, 400)
SideMenu.ScrollBarThickness = 4

local ContentArea = Instance.new("Frame", MainFrame)
ContentArea.Size = UDim2.new(1, -135, 1, -35) ContentArea.Position = UDim2.new(0, 135, 0, 35)
ContentArea.BackgroundTransparency = 1

local Pages = {}
local tabs = {"اعدادات الماب", "اللاعب", "الاستهداف", "التأثيرات", "المحفوظات", "تعريف السيرفر", "العسكرية 🎖️"}

for i, name in ipairs(tabs) do
    local btn = Instance.new("TextButton", SideMenu)
    btn.Size = UDim2.new(0.9, 0, 0, 35) btn.Position = UDim2.new(0.05, 0, 0, (i-1) * 40 + 10)
    btn.Text = name btn.BackgroundColor3 = Color3.fromRGB(235, 185, 0) btn.TextColor3 = Color3.fromRGB(0, 0, 0)
    btn.Font = Enum.Font.SourceSansBold btn.TextSize = 12
    table.insert(yellowElements, btn)
    
    local page = Instance.new("ScrollingFrame", ContentArea)
    page.Size = UDim2.new(1, 0, 1, 0) page.BackgroundTransparency = 1
    page.CanvasSize = UDim2.new(0, 0, 0, 450) page.ScrollBarThickness = 4
    page.Visible = (i == 1) Pages[i] = page
    
    btn.MouseButton1Click:Connect(function()
        for _, p in ipairs(Pages) do p.Visible = false end
        page.Visible = true
    end)
    
    -- شرط الخانة السابعة السرية (ماب ريفل العسكرية - الرقم المرجعي الافتراضي أو الفحص بالاسم)
    if i == 7 then
        btn.Visible = false -- مخفية تلقائياً
        task.spawn(function()
            -- يقوم بالفحص إذا كان الماب هو ريفل العسكرية
            if game.PlaceId == 17403211475 or string.find(game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name:lower(), "reef") then
                btn.Visible = true
            end
        end)
    end
end

-- === [ شريحة 1: اعدادات الماب ] ===
local MapPage = Pages[1]
local ShaderBtn = Instance.new("TextButton", MapPage)
ShaderBtn.Size = UDim2.new(0.9, 0, 0, 32) ShaderBtn.Position = UDim2.new(0.05, 0, 0, 10)
ShaderBtn.Text = "تفعيل الشادر المتطور (Shader RTX)" ShaderBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
ShaderBtn.TextColor3 = Color3.fromRGB(255, 255, 255) ShaderBtn.Font = Enum.Font.SourceSansBold ShaderBtn.TextSize = 12
local shaderActive = false
ShaderBtn.MouseButton1Click:Connect(function()
    shaderActive = not shaderActive ShaderBtn.BackgroundColor3 = shaderActive and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(40, 40, 40)
    if shaderActive then Lighting.Brightness = 2.5 Lighting.GlobalShadows = true else Lighting.Brightness = 1 end
end)

local BrightBtn = Instance.new("TextButton", MapPage)
BrightBtn.Size = UDim2.new(0.9, 0, 0, 32) BrightBtn.Position = UDim2.new(0.05, 0, 0, 48)
BrightBtn.Text = "جعل الماب مضوي بالكامل (FullBright)" BrightBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
BrightBtn.TextColor3 = Color3.fromRGB(255, 255, 255) BrightBtn.Font = Enum.Font.SourceSansBold BrightBtn.TextSize = 12
local brightActive = false
BrightBtn.MouseButton1Click:Connect(function()
    brightActive = not brightActive BrightBtn.BackgroundColor3 = brightActive and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(40, 40, 40)
    if brightActive then Lighting.Ambient = Color3.fromRGB(255, 255, 255) else Lighting.Ambient = Color3.fromRGB(130, 130, 130) end
end)

local colors = {"Rainbow", "Red", "Yellow", "Blue"}
local colorNames = {Rainbow = "شرائح قوس قزح", Red = "شرائح حمراء", Yellow = "شرائح صفراء", Blue = "شرائح زرقاء"}
for idx, mode in ipairs(colors) do
    local cBtn = Instance.new("TextButton", MapPage) cBtn.Size = UDim2.new(0.42, 0, 0, 30)
    cBtn.Position = UDim2.new(idx % 2 == 1 and 0.05 or 0.53, 0, 0, idx <= 2 and 90 or 125)
    cBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45) cBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    cBtn.Text = colorNames[mode] cBtn.Font = Enum.Font.SourceSansBold cBtn.TextSize = 11
    cBtn.MouseButton1Click:Connect(function() setBorderColor(mode) end)
end

-- === [ شريحة 2: اللاعب ] ===
local PlayerPage = Pages[2]
local function createStatRow(text, yPos, defaultVal, callback)
    local lbl = Instance.new("TextLabel", PlayerPage) lbl.Size = UDim2.new(0.3, 0, 0, 30) lbl.Position = UDim2.new(0.05, 0, 0, yPos)
    lbl.Text = text lbl.TextColor3 = Color3.fromRGB(255, 255, 255) lbl.BackgroundTransparency = 1 lbl.TextSize = 12
    local box = Instance.new("TextBox", PlayerPage) box.Size = UDim2.new(0.2, 0, 0, 30) box.Position = UDim2.new(0.35, 0, 0, yPos)
    box.BackgroundColor3 = Color3.fromRGB(35, 35, 35) box.TextColor3 = Color3.fromRGB(255, 200, 0) box.Text = defaultVal box.TextSize = 13
    table.insert(yellowElements, box)
    local btn = Instance.new("TextButton", PlayerPage) btn.Size = UDim2.new(0.35, 0, 0, 30) btn.Position = UDim2.new(0.6, 0, 0, yPos)
    btn.Text = "تفعيل" btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45) btn.TextColor3 = Color3.fromRGB(255, 255, 255) btn.TextSize = 12
    local active = false btn.MouseButton1Click:Connect(function() active = not active btn.BackgroundColor3 = active and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(45, 45, 45) callback(active, tonumber(box.Text) or tonumber(defaultVal)) end)
end

createStatRow("السرعة:", 10, "65", function(act, val) if Player.Character and Player.Character:FindFirstChild("Humanoid") then Player.Character.Humanoid.WalkSpeed = act and val or 16 end end)
createStatRow("القفز:", 45, "120", function(act, val) if Player.Character and Player.Character:FindFirstChild("Humanoid") then Player.Character.Humanoid.JumpPower = act and val or 50 end end)

local FlyBtn = Instance.new("TextButton", PlayerPage) FlyBtn.Size = UDim2.new(0.9, 0, 0, 30) FlyBtn.Position = UDim2.new(0.05, 0, 0, 85)
FlyBtn.Text = "تفعيل الطيران (FlyGuiV3)" FlyBtn.BackgroundColor3 = Color3.fromRGB(100, 0, 100) FlyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
FlyBtn.MouseButton1Click:Connect(function() loadstring(game:HttpGet("https://raw.githubusercontent.com/XNEOFF/FlyGuiV3/main/FlyGuiV3.txt"))() end)

local NoclipBtn = Instance.new("TextButton", PlayerPage) NoclipBtn.Size = UDim2.new(0.9, 0, 0, 30) NoclipBtn.Position = UDim2.new(0.05, 0, 0, 120)
NoclipBtn.Text = "تفعيل اختراق الجدران (Noclip)" NoclipBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40) NoclipBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
local noclipActive = false local noclipConn
NoclipBtn.MouseButton1Click:Connect(function()
    noclipActive = not noclipActive NoclipBtn.BackgroundColor3 = noclipActive and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(40, 40, 40)
    if noclipActive then noclipConn = RunService.Stepped:Connect(function() if Player.Character then for _, p in ipairs(Player.Character:GetChildren()) do if p:IsA("BasePart") then p.CanCollide = false end end end end) else if noclipConn then noclipConn:Disconnect() end end
end)

-- === [ شريحة 3: الاستهداف ] ===
local TargetPage = Pages[3]
local NameBox = Instance.new("TextBox", TargetPage) NameBox.Size = UDim2.new(0.9, 0, 0, 32) NameBox.Position = UDim2.new(0.05, 0, 0, 10)
NameBox.BackgroundColor3 = Color3.fromRGB(30, 30, 30) NameBox.TextColor3 = Color3.fromRGB(255, 255, 255) NameBox.PlaceholderText = "اسم اللاعب المراد استهدافه..."
local TeleBtn = Instance.new("TextButton", TargetPage) TeleBtn.Size = UDim2.new(0.9, 0, 0, 32) TeleBtn.Position = UDim2.new(0.05, 0, 0, 50)
TeleBtn.Text = "انتقال فوري للاعب" TeleBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50) TeleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
TeleBtn.MouseButton1Click:Connect(function()
    local tName = NameBox.Text:lower()
    for _, p in ipairs(PlayersService:GetPlayers()) do if p.Name:lower():sub(1, #tName) == tName and p.Character then Player.Character.HumanoidRootPart.CFrame = p.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3) end end
end)

-- === [ شريحة 4: التأثيرات ] ===
local EffectsPage = Pages[4]
local function clearEffects() if Player.Character then for _, v in ipairs(Player.Character:GetChildren()) do if v:IsA("Highlight") or v.Name == "AihamFX" then v:Destroy() end end if Player.Character:FindFirstChild("HumanoidRootPart") then for _, v in ipairs(Player.Character.HumanoidRootPart:GetChildren()) do if v.Name == "AihamFX" or v:IsA("ParticleEmitter") or v:IsA("Fire") then v:Destroy() end end end end end
local function giveEffect(t, c) clearEffects() local root = Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") if not root then return end if t == "Fire" then local f = Instance.new("Fire", root) f.Name = "AihamFX" f.Size = 10 elseif t == "Highlight" then local h = Instance.new("Highlight", Player.Character) h.Name = "AihamFX" h.FillColor = c elseif t == "Particles" then local p = Instance.new("ParticleEmitter", root) p.Name = "AihamFX" p.Color = ColorSequence.new(c) p.Speed = NumberRange.new(6, 10) p.Rate = 70 end end

createEffectBtn = function(txt, y, col, cb) local b = Instance.new("TextButton", EffectsPage) b.Size = UDim2.new(0.9, 0, 0, 30) b.Position = UDim2.new(0.05, 0, 0, y) b.BackgroundColor3 = col b.TextColor3 = Color3.fromRGB(255, 255, 255) b.Text = txt b.Font = Enum.Font.SourceSansBold b.TextSize = 12 b.MouseButton1Click:Connect(cb) end
createEffectBtn("تفعيل تأثير النار على الجسم", 10, Color3.fromRGB(200, 80, 0), function() giveEffect("Fire") end)
createEffectBtn("تفعيل تأثير الإضاءة المشعة المشعة (Highlight)", 45, Color3.fromRGB(0, 150, 150), function() giveEffect("Highlight", Color3.fromRGB(0, 255, 255)) end)
createEffectBtn("تفعيل شظايا الذهب المصلحة", 80, Color3.fromRGB(170, 170, 0), function() giveEffect("Particles", Color3.fromRGB(255, 215, 0)) end)
createEffectBtn("إزالة كافة التأثيرات فوراً", 120, Color3.fromRGB(50, 50, 50), function() clearEffects() end)

-- === [ شريحة 5: المحفوظات (تتسع لأكثر من 30 موقع) ] ===
local CheckpointPage = Pages[5]
local CPInput = Instance.new("TextBox", CheckpointPage) CPInput.Size = UDim2.new(0.6, 0, 0, 32) CPInput.Position = UDim2.new(0.05, 0, 0, 10)
CPInput.BackgroundColor3 = Color3.fromRGB(30, 30, 30) CPInput.TextColor3 = Color3.fromRGB(255, 255, 255) CPInput.PlaceholderText = "اكتب اسم المكان لحفظه..."

local ListContainer = Instance.new("ScrollingFrame", CheckpointPage) ListContainer.Size = UDim2.new(0.9, 0, 0, 180) ListContainer.Position = UDim2.new(0.05, 0, 0, 50)
ListContainer.BackgroundTransparency = 0.95 ListContainer.CanvasSize = UDim2.new(0, 0, 0, 1000) ListContainer.ScrollBarThickness = 5
local UIListLayout = Instance.new("UIListLayout", ListContainer) UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder UIListLayout.Padding = UDim.new(0, 5)

local savedLocations = {}
local function updateCPList()
    ListContainer:ClearAllChildren()
    Instance.new("UIListLayout", ListContainer).Padding = UDim.new(0, 5)
    for name, cframe in pairs(savedLocations) do
        local ItemFrame = Instance.new("Frame", ListContainer) ItemFrame.Size = UDim2.new(0.95, 0, 0, 32) ItemFrame.BackgroundTransparency = 1
        local GoBtn = Instance.new("TextButton", ItemFrame) GoBtn.Size = UDim2.new(0.82, 0, 1, 0) GoBtn.Text = name
        GoBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40) GoBtn.TextColor3 = Color3.fromRGB(255, 255, 255) GoBtn.Font = Enum.Font.SourceSansBold
        GoBtn.MouseButton1Click:Connect(function() if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then Player.Character.HumanoidRootPart.CFrame = cframe end end)
        local DelBtn = Instance.new("TextButton", ItemFrame) DelBtn.Size = UDim2.new(0.15, 0, 1, 0) DelBtn.Position = UDim2.new(0.85, 0, 0, 0)
        DelBtn.Text = "X" DelBtn.BackgroundColor3 = Color3.fromRGB(170, 0, 0) DelBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        DelBtn.MouseButton1Click:Connect(function() savedLocations[name] = nil updateCPList() end)
    end
end
local SaveBtn = Instance.new("TextButton", CheckpointPage) SaveBtn.Size = UDim2.new(0.28, 0, 0, 32) SaveBtn.Position = UDim2.new(0.67, 0, 0, 10)
SaveBtn.Text = "حفظ الموقع" SaveBtn.BackgroundColor3 = Color3.fromRGB(0, 130, 0) SaveBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SaveBtn.MouseButton1Click:Connect(function()
    if CPInput.Text ~= "" and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
        savedLocations[CPInput.Text] = Player.Character.HumanoidRootPart.CFrame CPInput.Text = "" updateCPList()
    end
end)

-- === [ شريحة 6: تعريف السيرفر ] ===
local ServerPage = Pages[6]
local infoText = "معلومات السيرفر والتعديل:\n\n• صاحب السيرفر والمطور: أيهم الأسطوري\n• نوع الهاتف المستعمل بالتعديل: تابلت أندرويد متطور\n• رابط الديسكورد الرسمي للمطور أيهم:\ndiscord.gg/aiham-legend"
local InfoLabel = Instance.new("TextLabel", ServerPage) InfoLabel.Size = UDim2.new(0.9, 0, 0, 180) InfoLabel.Position = UDim2.new(0.05, 0, 0, 10)
InfoLabel.BackgroundColor3 = Color3.fromRGB(25, 25, 25) InfoLabel.TextColor3 = Color3.fromRGB(255, 220, 0) InfoLabel.Text = infoText
InfoLabel.Font = Enum.Font.SourceSansBold InfoLabel.TextSize = 14 InfoLabel.TextWrapped = true InfoLabel.BorderSizePixel = 1 InfoLabel.BorderColor3 = Color3.fromRGB(255,200,0)

-- === [ شريحة 7 السرية: العسكرية مخصصة لماب ريفل 🎖️ ] ===
local MilitaryPage = Pages[7]

-- دالة التنقل الآمن لحمايتك من الطرد (Tween Safe Teleport)
local function safeTween(targetCFrame)
    if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
        local hrp = Player.Character.HumanoidRootPart
        local distance = (hrp.Position - targetCFrame.Position).Magnitude
        local speed = 150 -- سرعة آمنة وممتازة لمنع كشف الـ Anti-cheat
        local info = TweenInfo.new(distance / speed, Enum.EasingStyle.Linear)
        local tween = TweenService:Create(hrp, info, {CFrame = targetCFrame})
        tween:Play()
        return tween
    end
end

-- تفعيل التفاعل التلقائي مع الـ ProximityPrompt (فتح الصناديق/الدروبات)
local function autoInteract(targetInstance)
    task.spawn(function()
        while targetInstance and targetInstance.Parent do
            local prompt = targetInstance:FindFirstChildOfClass("ProximityPrompt") or targetInstance.Parent:FindFirstChildOfClass("ProximityPrompt")
            if prompt then
                fireproximityprompt(prompt, 5) -- تشغيل الضغط تلقائياً وبسرعة ثانية واحدة
            end
            task.wait(0.5)
        end
    end)
end

-- زر اوتو فارم دروب (Auto Farm Drop)
local DropBtn = Instance.new("TextButton", MilitaryPage) DropBtn.Size = UDim2.new(0.9, 0, 0, 40) DropBtn.Position = UDim2.new(0.05, 0, 0, 20)
DropBtn.Text = "Oto Farm Drop (تجميع الدروب التلقائي)" DropBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30) DropBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
local farmDropActive = false
DropBtn.MouseButton1Click:Connect(function()
    farmDropActive = not farmDropActive
    DropBtn.BackgroundColor3 = farmDropActive and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(30, 30, 30)
    
    task.spawn(function()
        while farmDropActive do
            -- يبحث عن مجلد أو عنصر اسمه Drop في الورك سبيس الخاص بالماب
            local drop = workspace:FindFirstChild("Drop") or workspace:FindFirstChild("AirDrop") or workspace:FindFirstChild("SupplyDrop")
            if drop and drop:FindFirstChild("HumanoidRootPart") or drop:IsA("BasePart") then
                local targetPos = drop:IsA("BasePart") and drop.CFrame or drop.HumanoidRootPart.CFrame
                -- النزول تحت الأرض بـ 6 خطوات للأمان من الحماية والأعداء
                local safeUnderground = targetPos * CFrame.new(0, -6, 0)
                local tw = safeTween(safeUnderground)
                if tw then tw.Completed:Wait() end
                autoInteract(drop)
            end
            task.wait(2)
        end
    end)
end)

-- زر اوتو فارم بوكس (Auto Farm Box)
local BoxBtn = Instance.new("TextButton", MilitaryPage) BoxBtn.Size = UDim2.new(0.9, 0, 0, 40) BoxBtn.Position = UDim2.new(0.05, 0, 0, 75)
BoxBtn.Text = "Oto Farm Box (تجميع ونقل الصناديق الدليفري)" BoxBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30) BoxBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
local farmBoxActive = false
BoxBtn.MouseButton1Click:Connect(function()
    farmBoxActive = not farmBoxActive
    BoxBtn.BackgroundColor3 = farmBoxActive and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(30, 30, 30)
    
    task.spawn(function()
        while farmBoxActive do
            -- ابحث عن الصندوق في الماب
            local box = workspace:FindFirstChild("Box") or workspace:FindFirstChild("Package") or workspace:FindFirstChild("AmmoBox")
            local deliveryPoint = workspace:FindFirstChild("Deliv
