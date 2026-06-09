-- [[ سكريبت أيهم الأسطوري V12 - المظهر العسكري الملكي المطور (أسود وذهبي) ]]
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

-- الإطار الرئيسي للشاشة (تم تحديث الألوان لخلفية حديدية داكنة وفخمة)
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 520, 0, 340) -- تكبير طفيف ليتناسب مع فخامة التصميم
MainFrame.Position = UDim2.new(0.5, -260, 0.5, -170)
MainFrame.BackgroundColor3 = Color3.fromRGB(24, 25, 28) -- أسود حديدي داكن
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true

-- إضافة زوايا دائرية ناعمة للإطار الرئيسي
local MainCorner = Instance.new("UICorner", MainFrame)
MainCorner.CornerRadius = UDim.new(0, 8)

-- إضافة حواف ذهبية فخمة للإطار الرئيسي (تأثير المعدن)
local MainStroke = Instance.new("UIStroke", MainFrame)
MainStroke.Thickness = 2
MainStroke.Color = Color3.fromRGB(184, 134, 11) -- ذهبي داكن ملكي
MainStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

local savedLocations = {}

-- نظام ألوان الحواف الكامل لجميع الشرائح
local rainbowConnection
local function setBorderColor(mode)
    if rainbowConnection then rainbowConnection:Disconnect() rainbowConnection = nil end
    if mode == "Red" then MainStroke.Color = Color3.fromRGB(200, 0, 0)
    elseif mode == "Yellow" then MainStroke.Color = Color3.fromRGB(184, 134, 11)
    elseif mode == "Blue" then MainStroke.Color = Color3.fromRGB(0, 90, 180)
    elseif mode == "Rainbow" then
        rainbowConnection = RunService.RenderStepped:Connect(function()
            local hue = (tick() % 4) / 4
            MainStroke.Color = Color3.fromHSV(hue, 0.8, 0.8)
        end)
    end
end

-- زر الفتح والإغلاق الجانبي الصغير المطور (تصميم دائري ذهبي محاط بالأسود)
local ToggleButton = Instance.new("TextButton", ScreenGui)
ToggleButton.Size = UDim2.new(0, 45, 0, 45)
ToggleButton.Position = UDim2.new(0, 15, 0.5, -22)
ToggleButton.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
ToggleButton.Text = "●"
ToggleButton.TextColor3 = Color3.fromRGB(184, 134, 11)
ToggleButton.TextSize = 24 
ToggleButton.Font = Enum.Font.FredokaOne
ToggleButton.Active = true 
ToggleButton.Draggable = true

local ToggleCorner = Instance.new("UICorner", ToggleButton)
ToggleCorner.CornerRadius = UDim.new(1, 0) -- دائري بالكامل

local ToggleStroke = Instance.new("UIStroke", ToggleButton)
ToggleStroke.Thickness = 2
ToggleStroke.Color = Color3.fromRGB(184, 134, 11)

ToggleButton.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)

-- العنوان العلوي الثابت بتصميم عسكري ملكي
local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, 0, 0, 40) 
Title.BackgroundColor3 = Color3.fromRGB(17, 18, 20)
Title.Text = "صنع من قبل المطور الأسطوري أيهم"
Title.TextColor3 = Color3.fromRGB(212, 175, 55) -- لون ذهبي ساطع للخط
Title.TextSize = 16 
Title.Font = Enum.Font.GothamBold

local TitleCorner = Instance.new("UICorner", Title)
TitleCorner.CornerRadius = UDim.new(0, 8)

-- القائمة الجانبية للتنقل
local SideMenu = Instance.new("Frame", MainFrame)
SideMenu.Size = UDim2.new(0, 140, 1, -40) 
SideMenu.Position = UDim2.new(0, 0, 0, 40)
SideMenu.BackgroundColor3 = Color3.fromRGB(19, 20, 22)

local ContentArea = Instance.new("Frame", MainFrame)
ContentArea.Size = UDim2.new(1, -140, 1, -40) 
ContentArea.Position = UDim2.new(0, 140, 0, 40)
ContentArea.BackgroundTransparency = 1

local Pages = {}
local tabs = {"اعدادات الماب", "اللاعب", "الاستهداف", "نقاط الحفظ", "التأثيرات", "الصناديق", "الرقصات"}

for i, name in ipairs(tabs) do
    local btn = Instance.new("TextButton", SideMenu)
    btn.Size = UDim2.new(0.88, 0, 0, 34) 
    btn.Position = UDim2.new(0.06, 0, 0, (i-1) * 40 + 12)
    btn.Text = name 
    btn.BackgroundColor3 = Color3.fromRGB(32, 34, 37) -- أزرار جانبية رمادية حديدية
    btn.TextColor3 = Color3.fromRGB(200, 200, 200)
    btn.Font = Enum.Font.GothamBold 
    btn.TextSize = 12
    
    local btnCorner = Instance.new("UICorner", btn)
    btnCorner.CornerRadius = UDim.new(0, 4)
    
    local btnStroke = Instance.new("UIStroke", btn)
    btnStroke.Thickness = 1
    btnStroke.Color = Color3.fromRGB(50, 52, 55)
    
    local page = Instance.new("ScrollingFrame", ContentArea)
    page.Size = UDim2.new(1, 0, 1, 0) 
    page.BackgroundTransparency = 1
    page.CanvasSize = UDim2.new(0, 0, 0, 450) 
    page.ScrollBarThickness = 3
    page.ScrollBarImageColor3 = Color3.fromRGB(184, 134, 11)
    page.Visible = (i == 1) 
    Pages[i] = page
    
    -- تأثير عند الضغط والتبديل لتمييز الزر النشط بالذهبي
    if i == 1 then
        btn.BackgroundColor3 = Color3.fromRGB(45, 40, 25)
        btn.TextColor3 = Color3.fromRGB(212, 175, 55)
        btnStroke.Color = Color3.fromRGB(184, 134, 11)
    end

    btn.MouseButton1Click:Connect(function()
        for idx, p in ipairs(Pages) do 
            p.Visible = false 
            SideMenu:GetChildren()[idx+2].BackgroundColor3 = Color3.fromRGB(32, 34, 37)
            SideMenu:GetChildren()[idx+2].TextColor3 = Color3.fromRGB(200, 200, 200)
            SideMenu:GetChildren()[idx+2].UIStroke.Color = Color3.fromRGB(50, 52, 55)
        end
        page.Visible = true
        btn.BackgroundColor3 = Color3.fromRGB(45, 40, 25)
        btn.TextColor3 = Color3.fromRGB(212, 175, 55)
        btnStroke.Color = Color3.fromRGB(184, 134, 11)
    end)
end

-- تعيين الثيم الأساسي الذهبي البادئ
setBorderColor("Yellow")

-- === [ شريحة 1: اعدادات الماب ] ===
local MapPage = Pages[1]

local ShaderBtn = Instance.new("TextButton", MapPage)
ShaderBtn.Size = UDim2.new(0.9, 0, 0, 35) ShaderBtn.Position = UDim2.new(0.05, 0, 0, 10)
ShaderBtn.Text = "تفعيل الشادر (Shader)" ShaderBtn.BackgroundColor3 = Color3.fromRGB(45, 20, 50)
ShaderBtn.TextColor3 = Color3.fromRGB(230, 200, 255) ShaderBtn.Font = Enum.Font.GothamBold ShaderBtn.TextSize = 12
Instance.new("UICorner", ShaderBtn).CornerRadius = UDim.new(0, 4)
local shaderStroke = Instance.new("UIStroke", ShaderBtn) shaderStroke.Color = Color3.fromRGB(100, 30, 120)

local shaderActive = false local shaderEffect
ShaderBtn.MouseButton1Click:Connect(function()
    shaderActive = not shaderActive
    ShaderBtn.BackgroundColor3 = shaderActive and Color3.fromRGB(90, 30, 100) or Color3.fromRGB(45, 20, 50)
    if shaderActive then
        shaderEffect = Instance.new("ColorCorrectionEffect", Lighting)
        shaderEffect.Name = "CustomShader"
        shaderEffect.Brightness = 0.1 shaderEffect.Contrast = 0.2 shaderEffect.Saturation = 0.4
    elseif shaderEffect then shaderEffect:Destroy() shaderEffect = nil end
end)

local BrightBtn = Instance.new("TextButton", MapPage)
BrightBtn.Size = UDim2.new(0.9, 0, 0, 35) BrightBtn.Position = UDim2.new(0.05, 0, 0, 52)
BrightBtn.Text = "جعل الماب مضوي بالكامل (FullBright)" BrightBtn.BackgroundColor3 = Color3.fromRGB(35, 37, 40)
BrightBtn.TextColor3 = Color3.fromRGB(220, 220, 220) BrightBtn.Font = Enum.Font.GothamBold BrightBtn.TextSize = 12
Instance.new("UICorner", BrightBtn).CornerRadius = UDim.new(0, 4)
local brightStroke = Instance.new("UIStroke", BrightBtn) brightStroke.Color = Color3.fromRGB(60, 62, 65)

local brightActive = false
local originalBrightness = Lighting.Brightness
local originalAmbient = Lighting.Ambient
BrightBtn.MouseButton1Click:Connect(function()
    brightActive = not brightActive
    BrightBtn.BackgroundColor3 = brightActive and Color3.fromRGB(20, 50, 20) or Color3.fromRGB(35, 37, 40)
    brightStroke.Color = brightActive and Color3.fromRGB(0, 180, 0) or Color3.fromRGB(60, 62, 65)
    if brightActive then
        Lighting.Brightness = 4 Lighting.Ambient = Color3.fromRGB(255, 255, 255) Lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
    else
        Lighting.Brightness = originalBrightness Lighting.Ambient = originalAmbient
    end
end)

local colors = {"Rainbow", "Red", "Yellow", "Blue"}
local colorNames = {Rainbow = "حواف قوس قزح 🌈", Red = "حواف حمراء 🔴", Yellow = "حواف صفراء 🟡", Blue = "حواف زرقاء 🔵"}
for idx, mode in ipairs(colors) do
    local cBtn = Instance.new("TextButton", MapPage)
    cBtn.Size = UDim2.new(0.43, 0, 0, 32)
    cBtn.Position = UDim2.new(idx % 2 == 1 and 0.05 or 0.52, 0, 0, idx <= 2 and 96 or 136)
    cBtn.BackgroundColor3 = Color3.fromRGB(32, 34, 37) cBtn.TextColor3 = Color3.fromRGB(220, 220, 220)
    cBtn.Text = colorNames[mode] cBtn.Font = Enum.Font.GothamBold cBtn.TextSize = 11
    Instance.new("UICorner", cBtn).CornerRadius = UDim.new(0, 4)
    local cStroke = Instance.new("UIStroke", cBtn) cStroke.Color = Color3.fromRGB(55, 57, 60)
    cBtn.MouseButton1Click:Connect(function() setBorderColor(mode) end)
end

-- === [ شريحة 2: اللاعب ] ===
local PlayerPage = Pages[2]

local SpeedLabel = Instance.new("TextLabel", PlayerPage)
SpeedLabel.Size = UDim2.new(0.25, 0, 0, 30) SpeedLabel.Position = UDim2.new(0.05, 0, 0, 15)
SpeedLabel.Text = "السرعة:" SpeedLabel.TextColor3 = Color3.fromRGB(212, 175, 55) SpeedLabel.BackgroundTransparency = 1 SpeedLabel.Font = Enum.Font.GothamBold SpeedLabel.TextSize = 13

local SpeedInput = Instance.new("TextBox", PlayerPage)
SpeedInput.Size = UDim2.new(0.2, 0, 0, 30) SpeedInput.Position = UDim2.new(0.32, 0, 0, 15)
SpeedInput.BackgroundColor3 = Color3.fromRGB(20, 21, 23) SpeedInput.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedInput.Text = "65" SpeedInput.Font = Enum.Font.GothamBold SpeedInput.TextSize = 13
Instance.new("UICorner", SpeedInput).CornerRadius = UDim.new(0, 4)
Instance.new("UIStroke", SpeedInput).Color = Color3.fromRGB(184, 134, 11)

local SpeedBtn = Instance.new("TextButton", PlayerPage)
SpeedBtn.Size = UDim2.new(0.38, 0, 0, 30) SpeedBtn.Position = UDim2.new(0.57, 0, 0, 15)
SpeedBtn.Text = "تفعيل السرعة" SpeedBtn.BackgroundColor3 = Color3.fromRGB(35, 37, 40) SpeedBtn.TextColor3 = Color3.fromRGB(255, 255, 255) SpeedBtn.Font = Enum.Font.GothamBold SpeedBtn.TextSize = 12
Instance.new("UICorner", SpeedBtn).CornerRadius = UDim.new(0, 4)
local sBtnStroke = Instance.new("UIStroke", SpeedBtn) sBtnStroke.Color = Color3.fromRGB(60, 62, 65)

local speedActive = false
SpeedInput:GetPropertyChangedSignal("Text"):Connect(function()
    if speedActive and Player.Character and Player.Character:FindFirstChild("Humanoid") then
        Player.Character.Humanoid.WalkSpeed = tonumber(SpeedInput.Text) or 65
    end
end)
SpeedBtn.MouseButton1Click:Connect(function()
    speedActive = not speedActive
    SpeedBtn.BackgroundColor3 = speedActive and Color3.fromRGB(20, 50, 20) or Color3.fromRGB(35, 37, 40)
    sBtnStroke.Color = speedActive and Color3.fromRGB(0, 180, 0) or Color3.fromRGB(60, 62, 65)
    if Player.Character and Player.Character:FindFirstChild("Humanoid") then
        if speedActive then Player.Character.Humanoid.WalkSpeed = tonumber(SpeedInput.Text) or 65 else Player.Character.Humanoid.WalkSpeed = 16 end
    end
end)

local JumpLabel = Instance.new("TextLabel", PlayerPage)
JumpLabel.Size = UDim2.new(0.25, 0, 0, 30) JumpLabel.Position = UDim2.new(0.05, 0, 0, 55)
JumpLabel.Text = "القفز:" JumpLabel.TextColor3 = Color3.fromRGB(212, 175, 55) JumpLabel.BackgroundTransparency = 1 JumpLabel.Font = Enum.Font.GothamBold JumpLabel.TextSize = 13

local JumpInput = Instance.new("TextBox", PlayerPage)
JumpInput.Size = UDim2.new(0.2, 0, 0, 30) JumpInput.Position = UDim2.new(0.32, 0, 0, 55)
JumpInput.BackgroundColor3 = Color3.fromRGB(20, 21, 23) JumpInput.TextColor3 = Color3.fromRGB(255, 255, 255)
JumpInput.Text = "120" JumpInput.Font = Enum.Font.GothamBold JumpInput.TextSize = 13
Instance.new("UICorner", JumpInput).CornerRadius = UDim.new(0, 4)
Instance.new("UIStroke", JumpInput).Color = Color3.fromRGB(184, 134, 11)

local JumpBtn = Instance.new("TextButton", PlayerPage)
JumpBtn.Size = UDim2.new(0.38, 0, 0, 30) JumpBtn.Position = UDim2.new(0.57, 0, 0, 55)
JumpBtn.Text = "تفعيل القفز" JumpBtn.BackgroundColor3 = Color3.fromRGB(35, 37, 40) JumpBtn.TextColor3 = Color3.fromRGB(255, 255, 255) JumpBtn.Font = Enum.Font.GothamBold JumpBtn.TextSize = 12
Instance.new("UICorner", JumpBtn).CornerRadius = UDim.new(0, 4)
local jBtnStroke = Instance.new("UIStroke", JumpBtn) jBtnStroke.Color = Color3.fromRGB(60, 62, 65)

local jumpActive = false
JumpBtn.MouseButton1Click:Connect(function()
    jumpActive = not jumpActive
    JumpBtn.BackgroundColor3 = jumpActive and Color3.fromRGB(20, 50, 20) or Color3.fromRGB(35, 37, 40)
    jBtnStroke.Color = jumpActive and Color3.fromRGB(0, 180, 0) or Color3.fromRGB(60, 62, 65)
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
NoclipBtn.Size = UDim2.new(0.9, 0, 0, 32) NoclipBtn.Position = UDim2.new(0.05, 0, 0, 95)
NoclipBtn.Text = "تفعيل اختراق الجدران (Noclip)" NoclipBtn.BackgroundColor3 = Color3.fromRGB(35, 37, 40) NoclipBtn.TextColor3 = Color3.fromRGB(220, 220, 220) NoclipBtn.Font = Enum.Font.GothamBold NoclipBtn.TextSize = 12
Instance.new("UICorner", NoclipBtn).CornerRadius = UDim.new(0, 4)
local ncStroke = Instance.new("UIStroke", NoclipBtn) ncStroke.Color = Color3.fromRGB(60, 62, 65)

local noclipActive = false local noclipConnection
NoclipBtn.MouseButton1Click:Connect(function()
    noclipActive = not noclipActive
    NoclipBtn.BackgroundColor3 = noclipActive and Color3.fromRGB(20, 50, 20) or Color3.fromRGB(35, 37, 40)
    ncStroke.Color = noclipActive and Color3.fromRGB(0, 180, 0) or Color3.fromRGB(60, 62, 65)
    if noclipActive then
        noclipConnection = RunService.Stepped:Connect(function()
            if Player.Character then for _, part in ipairs(Player.Character:GetChildren()) do if part:IsA("BasePart") then part.CanCollide = false end end end
        end)
    else
        if noclipConnection then noclipConnection:Disconnect() noclipConnection = nil end
    end
end)

local InfJumpBtn = Instance.new("TextButton", PlayerPage)
InfJumpBtn.Size = UDim2.new(0.9, 0, 0, 32) InfJumpBtn.Position = UDim2.new(0.05, 0, 0, 133)
InfJumpBtn.Text = "تفعيل القفز اللانهائي (Inf Jump)" InfJumpBtn.BackgroundColor3 = Color3.fromRGB(35, 37, 40) InfJumpBtn.TextColor3 = Color3.fromRGB(220, 220, 220) InfJumpBtn.Font = Enum.Font.GothamBold InfJumpBtn.TextSize = 12
Instance.new("UICorner", InfJumpBtn).CornerRadius = UDim.new(0, 4)
local ijStroke = Instance.new("UIStroke", InfJumpBtn) ijStroke.Color = Color3.fromRGB(60, 62, 65)

local infJumpActive = false
UserInputService.JumpRequest:Connect(function()
    if infJumpActive and Player.Character and Player.Character:FindFirstChild("Humanoid") then Player.Character.Humanoid:ChangeState("Jumping") end
end)
InfJumpBtn.MouseButton1Click:Connect(function() 
    infJumpActive = not infJumpActive 
    InfJumpBtn.BackgroundColor3 = infJumpActive and Color3.fromRGB(20, 50, 20) or Color3.fromRGB(35, 37, 40) 
    ijStroke.Color = infJumpActive and Color3.fromRGB(0, 180, 0) or Color3.fromRGB(60, 62, 65)
end)

local FlyBtn = Instance.new("TextButton", PlayerPage)
FlyBtn.Size = UDim2.new(0.9, 0, 0, 32) FlyBtn.Position = UDim2.new(0.05, 0, 0, 171)
FlyBtn.Text = "تشغيل قائمة الطيران (Fly V3) 🚀" FlyBtn.BackgroundColor3 = Color3.fromRGB(25, 45, 70) FlyBtn.TextColor3 = Color3.fromRGB(200, 225, 255) FlyBtn.Font = Enum.Font.GothamBold FlyBtn.TextSize = 12
Instance.new("UICorner", FlyBtn).CornerRadius = UDim.new(0, 4)
Instance.new("UIStroke", FlyBtn).Color = Color3.fromRGB(40, 80, 140)
FlyBtn.MouseButton1Click:Connect(function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/XNEOFF/FlyGuiV3/main/FlyGuiV3.txt"))()
end)

-- === [ شريحة 3: الاستهداف ] ===
local TargetPage = Pages[3]

local NameBox = Instance.new("TextBox", TargetPage)
NameBox.Size = UDim2.new(0.9, 0, 0, 35) NameBox.Position = UDim2.new(0.05, 0, 0, 10)
NameBox.BackgroundColor3 = Color3.fromRGB(20, 21, 23) NameBox.TextColor3 = Color3.fromRGB(255, 255, 255) NameBox.PlaceholderText = "اسم اللاعب المراد استهدافه..." NameBox.Font = Enum.Font.GothamBold NameBox.TextSize = 12
Instance.new("UICorner", NameBox).CornerRadius = UDim.new(0, 4)
Instance.new("UIStroke", NameBox).Color = Color3.fromRGB(184, 134, 11)

local TeleBtn = Instance.new("TextButton", TargetPage)
TeleBtn.Size = UDim2.new(0.9, 0, 0, 35) TeleBtn.Position = UDim2.new(0.05, 0, 0, 53)
TeleBtn.Text = "انتقال فوري للاعب 🎯" TeleBtn.BackgroundColor3 = Color3.fromRGB(35, 37, 40) TeleBtn.TextColor3 = Color3.fromRGB(255, 255, 255) TeleBtn.Font = Enum.Font.GothamBold TeleBtn.TextSize = 12
Instance.new("UICorner", TeleBtn).CornerRadius = UDim.new(0, 4)
Instance.new("UIStroke", TeleBtn).Color = Color3.fromRGB(184, 134, 11)
TeleBtn.MouseButton1Click:Connect(function()
    local tName = NameBox.Text:lower()
    for _, p in ipairs(PlayersService:GetPlayers()) do
        if p.Name:lower():sub(1, #tName) == tName and p.Character then Player.Character.HumanoidRootPart.CFrame = p.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3) end
    end
end)

-- === [ شريحة 4: نقاط الحفظ ] ===
local CheckpointPage = Pages[4]

local CPInput = Instance.new("TextBox", CheckpointPage)
CPInput.Size = UDim2.new(0.58, 0, 0, 32) CPInput.Position = UDim2.new(0.05, 0, 0, 10)
CPInput.BackgroundColor3 = Color3.fromRGB(20, 21, 23) CPInput.TextColor3 = Color3.fromRGB(255, 255, 255) CPInput.PlaceholderText = "اسم الموقع الجغرافي..." CPInput.Font = Enum.Font.GothamBold CPInput.TextSize = 12
Instance.new("UICorner", CPInput).CornerRadius = UDim.new(0, 4)
Instance.new("UIStroke", CPInput).Color = Color3.fromRGB(80, 82, 85)

local ListContainer = Instance.new("ScrollingFrame", CheckpointPage)
ListContainer.Size = UDim2.new(0.9, 0, 0, 160) ListContainer.Position = UDim2.new(0.05, 0, 0, 52)
ListContainer.BackgroundTransparency = 0.95 ListContainer.CanvasSize = UDim2.new(0, 0, 0, 600) ListContainer.ScrollBarThickness = 3
ListContainer.ScrollBarImageColor3 = Color3.fromRGB(184, 134, 11)

local function updateCPList()
    ListContainer:ClearAllChildren()
    local count = 0
    for name, cframe in pairs(savedLocations) do
        local ItemFrame = Instance.new("Frame", ListContainer)
        ItemFrame.Size = UDim2.new(0.95, 0, 0, 32) ItemFrame.Position = UDim2.new(0, 0, 0, count * 36)
        ItemFrame.BackgroundTransparency = 1
        
        local GoBtn = Instance.new("TextButton", ItemFrame)
        GoBtn.Size = UDim2.new(0.78, 0, 1, 0) GoBtn.Text = "📍 " .. name
        GoBtn.BackgroundColor3 = Color3.fromRGB(32, 34, 37) GoBtn.TextColor3 = Color3.fromRGB(255, 255, 255) GoBtn.Font = Enum.Font.GothamBold GoBtn.TextSize = 11
        Instance.new("UICorner", GoBtn).CornerRadius = UDim.new(0, 4)
        Instance.new("UIStroke", GoBtn).Color = Color3.fromRGB(55, 57, 60)
        GoBtn.MouseButton1Click:Connect(function() if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then Player.Character.HumanoidRootPart.CFrame = cframe end end)
        
        local DelBtn = Instance.new("TextButton", ItemFrame)
        DelBtn.Size = UDim2.new(0.18, 0, 1, 0) DelBtn.Position = UDim2.new(0.82, 0, 0, 0)
        DelBtn.Text = "✕" DelBtn.BackgroundColor3 = Color3.fromRGB(70, 20, 20) DelBtn.TextColor3 = Color3.fromRGB(255, 150, 150) DelBtn.Font = Enum.Font.GothamBold DelBtn.TextSize = 11
        Instance.new("UICorner", DelBtn).CornerRadius = UDim.new(0, 4)
        Instance.new("UIStroke", DelBtn).Color = Colo
