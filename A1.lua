-- [[ سكريبت أيهم الأسطوري - النسخة المعدلة والمطورة V16 ]]
local Player = game.Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")
local Backpack = Player:WaitForChild("Backpack")
local RunService = game:GetService("RunService")
local PlayersService = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")

if PlayerGui:FindFirstChild("AihamSuperMenu") then PlayerGui.AihamSuperMenu:Destroy() end

local ScreenGui = Instance.new("ScreenGui", PlayerGui)
ScreenGui.Name = "AihamSuperMenu"
ScreenGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 480, 0, 320)
MainFrame.Position = UDim2.new(0.5, -240, 0.5, -160)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.BorderSizePixel = 3
MainFrame.BorderColor3 = Color3.fromRGB(255, 200, 0)
MainFrame.Active = true
MainFrame.Draggable = true

local yellowElements = {}
local rainbowConnection

-- دالة تحديث ألوان الثيم بالكامل (الإطار، العنوان، والأزرار الجانبية)
local function setBorderColor(mode)
    if rainbowConnection then rainbowConnection:Disconnect() rainbowConnection = nil end
    
    local function applyColor(color)
        MainFrame.BorderColor3 = color
        for _, obj in ipairs(yellowElements) do
            if obj and obj.Parent then
                if obj:IsA("TextButton") then
                    obj.BackgroundColor3 = color
                elseif obj:IsA("TextLabel") or obj:IsA("TextBox") then
                    obj.TextColor3 = color
                end
            end
        end
    end
    
    if mode == "Red" then 
        applyColor(Color3.fromRGB(255, 0, 0))
    elseif mode == "Yellow" then 
        applyColor(Color3.fromRGB(255, 200, 0))
    elseif mode == "Blue" then 
        applyColor(Color3.fromRGB(0, 100, 255))
    elseif mode == "Rainbow" then
        rainbowConnection = RunService.RenderStepped:Connect(function()
            local hue = (tick() % 4) / 4
            applyColor(Color3.fromHSV(hue, 1, 1))
        end)
    end
end

-- زر التصغير المربع الذهبي الجديد بالنقطة السوداء (مقتبس من تصميم الصورة)
local ToggleButton = Instance.new("TextButton", ScreenGui)
ToggleButton.Size = UDim2.new(0, 42, 0, 42)
ToggleButton.Position = UDim2.new(0, 10, 0.5, -21)
ToggleButton.BackgroundColor3 = Color3.fromRGB(255, 200, 0)
ToggleButton.Text = ""
ToggleButton.BorderSizePixel = 2
ToggleButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
ToggleButton.Active = true 
ToggleButton.Draggable = true

local Dot = Instance.new("Frame", ToggleButton)
Dot.Size = UDim2.new(0, 12, 0, 12)
Dot.Position = UDim2.new(0.5, -6, 0.5, -6)
Dot.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Dot.BorderSizePixel = 0
local DotCorner = Instance.new("UICorner", Dot)
DotCorner.CornerRadius = UDim.new(1, 0)

ToggleButton.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)
table.insert(yellowElements, ToggleButton)

-- عنوان السكريبت باسمك الأسطوري
local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, 0, 0, 35) Title.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
Title.Text = "صنع من قبل المطور الأسطوري أيهم"
Title.TextColor3 = Color3.fromRGB(255, 200, 0) Title.TextSize = 16 Title.Font = Enum.Font.SourceSansBold
table.insert(yellowElements, Title)

-- زر الإغلاق النهائي (X)
local CloseBtn = Instance.new("TextButton", MainFrame) 
CloseBtn.Size = UDim2.new(0, 25, 0, 25) 
CloseBtn.Position = UDim2.new(1, -28, 0, 5) 
CloseBtn.Text = "X" 
CloseBtn.Font = Enum.Font.SourceSansBold
CloseBtn.TextSize = 14
CloseBtn.BackgroundColor3 = Color3.fromRGB(180, 0, 0) 
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255) 
CloseBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

local SideMenu = Instance.new("ScrollingFrame", MainFrame)
SideMenu.Size = UDim2.new(0, 130, 1, -35) SideMenu.Position = UDim2.new(0, 0, 0, 35)
SideMenu.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
SideMenu.CanvasSize = UDim2.new(0, 0, 0, 300)
SideMenu.ScrollBarThickness = 5

local ContentArea = Instance.new("Frame", MainFrame)
ContentArea.Size = UDim2.new(1, -130, 1, -35) ContentArea.Position = UDim2.new(0, 130, 0, 35)
ContentArea.BackgroundTransparency = 1

local Pages = {}
local tabs = {"اعدادات الماب", "اللاعب", "الاستهداف", "نقاط الحفظ", "التأثيرات"}

for i, name in ipairs(tabs) do
    local btn = Instance.new("TextButton", SideMenu)
    btn.Size = UDim2.new(0.9, 0, 0, 38) btn.Position = UDim2.new(0.05, 0, 0, (i-1) * 44 + 12)
    btn.Text = name btn.BackgroundColor3 = Color3.fromRGB(235, 185, 0) btn.TextColor3 = Color3.fromRGB(0, 0, 0)
    btn.Font = Enum.Font.SourceSansBold btn.TextSize = 13
    table.insert(yellowElements, btn)
    
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
local ShaderBtn = Instance.new("TextButton", MapPage)
ShaderBtn.Size = UDim2.new(0.9, 0, 0, 35) ShaderBtn.Position = UDim2.new(0.05, 0, 0, 10)
ShaderBtn.Text = "تفعيل الشادر المتطور (Shader RTX)" ShaderBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
ShaderBtn.TextColor3 = Color3.fromRGB(255, 255, 255) ShaderBtn.Font = Enum.Font.SourceSansBold ShaderBtn.TextSize = 13
local shaderActive = false
ShaderBtn.MouseButton1Click:Connect(function()
    shaderActive = not shaderActive
    ShaderBtn.BackgroundColor3 = shaderActive and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(40, 40, 40)
    if shaderActive then
        Lighting.Brightness = 2.5
        Lighting.GlobalShadows = true
        Lighting.ShadowSoftness = 0.1
        if not Lighting:FindFirstChild("Bloom") then
            local bloom = Instance.new("BloomEffect", Lighting)
            bloom.Intensity = 1
            bloom.Size = 24
            bloom.Threshold = 0.9
        end
    else
        Lighting.Brightness = 1
        if Lighting:FindFirstChild("Bloom") then Lighting.Bloom:Destroy() end
    end
end)

local BrightBtn = Instance.new("TextButton", MapPage)
BrightBtn.Size = UDim2.new(0.9, 0, 0, 35) BrightBtn.Position = UDim2.new(0.05, 0, 0, 50)
BrightBtn.Text = "جعل الماب مضوي بالكامل (FullBright)" BrightBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
BrightBtn.TextColor3 = Color3.fromRGB(255, 255, 255) BrightBtn.Font = Enum.Font.SourceSansBold BrightBtn.TextSize = 13
local brightActive = false
local originalBrightness = Lighting.Brightness
local originalAmbient = Lighting.Ambient
BrightBtn.MouseButton1Click:Connect(function()
    brightActive = not brightActive
    BrightBtn.BackgroundColor3 = brightActive and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(40, 40, 40)
    if brightActive then 
        Lighting.Brightness = 4 
        Lighting.Ambient = Color3.fromRGB(255, 255, 255) 
        Lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
    else 
        Lighting.Brightness = originalBrightness 
        Lighting.Ambient = originalAmbient 
    end
end)

local colors = {"Rainbow", "Red", "Yellow", "Blue"}
local colorNames = {Rainbow = "شرائح قوس قزح", Red = "شرائح حمراء", Yellow = "شرائح صفراء", Blue = "شرائح زرقاء"}
for idx, mode in ipairs(colors) do
    local cBtn = Instance.new("TextButton", MapPage)
    cBtn.Size = UDim2.new(0.42, 0, 0, 32)
    cBtn.Position = UDim2.new(idx % 2 == 1 and 0.05 or 0.53, 0, 0, idx <= 2 and 90 or 130)
    cBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50) cBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    cBtn.Text = colorNames[mode] cBtn.Font = Enum.Font.SourceSansBold cBtn.TextSize = 12
    cBtn.MouseButton1Click:Connect(function() setBorderColor(mode) end)
end

-- === [ شريحة 2: اللاعب ] ===
local PlayerPage = Pages[2]
local SpeedLabel = Instance.new("TextLabel", PlayerPage)
SpeedLabel.Size = UDim2.new(0.3, 0, 0, 30) SpeedLabel.Position = UDim2.new(0.05, 0, 0, 15)
SpeedLabel.Text = "السرعة:" SpeedLabel.TextColor3 = Color3.fromRGB(255, 255, 255) SpeedLabel.BackgroundTransparency = 1
local SpeedInput = Instance.new("TextBox", PlayerPage)
SpeedInput.Size = UDim2.new(0.2, 0, 0, 30) SpeedInput.Position = UDim2.new(0.35, 0, 0, 15)
SpeedInput.BackgroundColor3 = Color3.fromRGB(40, 40, 40) SpeedInput.TextColor3 = Color3.fromRGB(255, 200, 0)
SpeedInput.Text = "65" SpeedInput.Font = Enum.Font.SourceSansBold SpeedInput.TextSize = 14
table.insert(yellowElements, SpeedInput)
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
table.insert(yellowElements, JumpInput)
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

local FlyBtn = Instance.new("TextButton", PlayerPage)
FlyBtn.Size = UDim2.new(0.9, 0, 0, 32) FlyBtn.Position = UDim2.new(0.05, 0, 0, 105)
FlyBtn.Text = "تفعيل الطيران (FlyGuiV3)" FlyBtn.BackgroundColor3 = Color3.fromRGB(120, 0, 120) FlyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
FlyBtn.Font = Enum.Font.SourceSansBold FlyBtn.TextSize = 13
FlyBtn.MouseButton1Click:Connect(function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/XNEOFF/FlyGuiV3/main/FlyGuiV3.txt"))()
end)

local GhostBtn = Instance.new("TextButton", PlayerPage)
GhostBtn.Size = UDim2.new(0.9, 0, 0, 32) GhostBtn.Position = UDim2.new(0.05, 0, 0, 145)
GhostBtn.Text = "القوست مود (Ghost Mode)" GhostBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40) GhostBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
local ghostActive = false local ghostChar
GhostBtn.MouseButton1Click:Connect(function()
    ghostActive = not ghostActive
    GhostBtn.BackgroundColor3 = ghostActive and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(40, 40, 40)
    local char = Player.Character
    if ghostActive then
        local currentPos = char.HumanoidRootPart.CFrame
        char.HumanoidRootPart.CFrame = CFrame.new(0, -99999, 0)
        char.HumanoidRootPart.Anchored = true
        ghostChar = char:Clone() ghostChar.Parent = workspace
        ghostChar.HumanoidRootPart.CFrame = currentPos
        workspace.CurrentCamera.CameraSubject = ghostChar:FindFirstChild("Humanoid")
        RunService.RenderStepped:Connect(function() if ghostActive and ghostChar then ghostChar.Humanoid:Move(char.Humanoid.MoveDirection, false) end end)
    else
        if ghostChar then
            char.HumanoidRootPart.Anchored = false
            char.HumanoidRootPart.CFrame = ghostChar.HumanoidRootPart.CFrame
            workspace.CurrentCamera.CameraSubject = char:FindFirstChild("Humanoid")
            ghostChar:Destroy() ghostChar = nil
        end
    end
end)

local LockCamBtn = Instance.new("TextButton", PlayerPage)
LockCamBtn.Size = UDim2.new(0.9, 0, 0, 32) LockCamBtn.Position = UDim2.new(0.05, 0, 0, 185)
LockCamBtn.Text = "تجميد الكاميرا" LockCamBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40) LockCamBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
local lockActive = false local cam = workspace.CurrentCamera
LockCamBtn.MouseButton1Click:Connect(function()
    lockActive = not lockActive
    LockCamBtn.BackgroundColor3 = lockActive and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(40, 40, 40)
    cam.CameraType = lockActive and Enum.CameraType.Scriptable or Enum.CameraType.Custom
end)

local NoclipBtn = Instance.new("TextButton", PlayerPage)
NoclipBtn.Size = UDim2.new(0.9, 0, 0, 32) NoclipBtn.Position = UDim2.new(0.05, 0, 0, 225)
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
InfJumpBtn.Size = UDim2.new(0.9, 0, 0, 32) InfJumpBtn.Position = UDim2.new(0.05, 0, 0, 265)
InfJumpBtn.Text = "تفعيل القفز اللانهائي (Inf Jump)" InfJumpBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40) InfJumpBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
local infJumpActive = false
UserInputService.JumpRequest:Connect(function()
    if infJumpActive and Player.Character and Player.Character:FindFirstChild("Humanoid") then Player.Character.Humanoid:ChangeState("Jumping") end
end)
InfJumpBtn.MouseButton1Click:Connect(function() infJumpActive = not infJumpActive InfJumpBtn.BackgroundColor3 = infJumpActive and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(40, 40, 40) end)

-- === [ شريحة 3: الاستهداف ] ===
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

-- === [ شريحة 4: نقاط الحفظ ] ===
local CheckpointPage = Pages[4]
local CPInput = Instance.new("TextBox", CheckpointPage)
CPInput.Size = UDim2.new(0.55, 0, 0, 32) CPInput.Position = UDim2.new(0.05, 0, 0, 10)
CPInput.BackgroundColor3 = Color3.fromRGB(30, 30, 30) CPInput.TextColor3 = Color3.fromRGB(255, 255, 255) CPInput.PlaceholderText = "اسم الموقع..."
local ListContainer = Instance.new("ScrollingFrame", CheckpointPage)
ListContainer.Size = UDim2.new(0.9, 0, 0, 160) ListContainer.Position = UDim2.new(0.05, 0, 0, 50)
ListContainer.BackgroundTransparency = 0.9 ListContainer.CanvasSize = UDim2.new(0, 0, 0, 600) ListContainer.ScrollBarThickness = 4
local savedLocations = {}
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

-- === [ شريحة 5: التأثيرات ] ===
local EffectsPage = Pages[5]
local function clearAllEffects()
    if Player.Character then
        for _, item in ipairs(Player.Character:GetChildren()) do
            if item:IsA("Highlight") or item.Name == "PlayerParticles" then item:Destroy() end
        end
        local root = Player.Character and Player.Character:FindFirstChild("HumanoidRootPart")
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
        pe.Speed = NumberRange.new(8, 12) pe.Rate = 80 pe.Lifetime = NumberRa
