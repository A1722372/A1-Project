-- [[ سكريبت أيهم الأسطوري - نسخة إعادة البناء الكاملة والتشغيل الإجباري المضمون ]]
if not game:IsLoaded() then game.Loaded:Wait() end
task.wait(0.5)

local Player = game:GetService("Players").LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui", 10)
local RunService = game:GetService("RunService")
local PlayersService = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")

if not PlayerGui then return end

-- توليد اسم عشوائي تماماً للواجهة لمنع الكراش والتعارض مع النسخ القديمة
local randomName = "AihamMenu_" .. tostring(math.random(10000, 99999))

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = randomName
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = PlayerGui

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

local ToggleButton = Instance.new("TextButton", ScreenGui)
ToggleButton.Size = UDim2.new(0, 40, 0, 40)
ToggleButton.Position = UDim2.new(0, 10, 0.5, -20)
ToggleButton.BackgroundColor3 = Color3.fromRGB(255, 200, 0)
ToggleButton.Text = "●"
ToggleButton.TextColor3 = Color3.fromRGB(0, 0, 0)
ToggleButton.TextSize = 22 ToggleButton.Font = Enum.Font.SourceSansBold
ToggleButton.Active = true ToggleButton.Draggable = true
ToggleButton.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)
table.insert(yellowElements, ToggleButton)

local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, 0, 0, 35) Title.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
Title.Text = "صنع من قبل المطور الأسطوري أيهم"
Title.TextColor3 = Color3.fromRGB(255, 200, 0) Title.TextSize = 16 Title.Font = Enum.Font.SourceSansBold
table.insert(yellowElements, Title)

local SideMenu = Instance.new("ScrollingFrame", MainFrame)
SideMenu.Size = UDim2.new(0, 130, 1, -35) SideMenu.Position = UDim2.new(0, 0, 0, 35)
SideMenu.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
SideMenu.CanvasSize = UDim2.new(0, 0, 0, 250)
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
    page.CanvasSize = UDim2.new(0, 0, 0, i == 2 and 530 or 400)
    page.ScrollBarThickness = 5
    page.Visible = (i == 1) Pages[i] = page
    
    btn.MouseButton1Click:Connect(function()
        for _, p in ipairs(Pages) do p.Visible = false end
        page.Visible = true
    end)
    task.wait(0.02) -- تأخير برميجي طفيف جداً لمنع الـ Timeout أثناء التحميل
end

-- === [ شريحة 1: اعدادات الماب ] ===
local MapPage = Pages[1]
local ShaderBtn = Instance.new("TextButton", MapPage)
ShaderBtn.Size = UDim2.new(0.9, 0, 0, 35) ShaderBtn.Position = UDim2.new(0.05, 0, 0, 10)
ShaderBtn.Text = "تفعيل الشادر (Shader)" ShaderBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
ShaderBtn.TextColor3 = Color3.fromRGB(255, 255, 255) ShaderBtn.Font = Enum.Font.SourceSansBold ShaderBtn.TextSize = 13
local shaderActive = false
ShaderBtn.MouseButton1Click:Connect(function()
    shaderActive = not shaderActive
    ShaderBtn.BackgroundColor3 = shaderActive and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(40, 40, 40)
    Lighting.Brightness = shaderActive and 2 or 1
    Lighting.ClockTime = shaderActive and 12 or 14
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
    if brightActive then Lighting.Brightness = 4 Lighting.Ambient = Color3.fromRGB(255, 255, 255) Lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
    else Lighting.Brightness = originalBrightness Lighting.Ambient = originalAmbient end
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

-- === [ شريحة 2: اللاعب (شامل ومدمج بالكامل ومصلح جذرين) ] ===
local PlayerPage = Pages[2]

local function createPlayerButton(text, yPos, callback)
    local btn = Instance.new("TextButton", PlayerPage)
    btn.Size = UDim2.new(0.9, 0, 0, 32)
    btn.Position = UDim2.new(0.05, 0, 0, yPos)
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 13
    btn.Text = text

    local active = false
    btn.MouseButton1Click:Connect(function()
        active = not active
        btn.BackgroundColor3 = active and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(40, 40, 40)
        callback(active)
    end)
    return btn
end

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
    if speedActive then if Player.Character and Player.Character:FindFirstChild("Humanoid") then Player.Character.Humanoid.WalkSpeed = tonumber(SpeedInput.Text) or 65 end else if Player.Character and Player.Character:FindFirstChild("Humanoid") then Player.Character.Humanoid.WalkSpeed = 16 end end
end)

local JumpLabel = Instance.new("TextLabel", PlayerPage)
JumpLabel.Size = UDim2.new(0.3, 0, 0, 30) JumpLabel.Position = UDim2.new(0.05, 0, 0, 55)
JumpLabel.Text = "القفز:" JumpLabel.TextColor3 = Color3.fromRGB(255, 255, 255) JumpLabel.BackgroundTransparency = 1
local JumpInput = Instance.new("TextBox", PlayerPage)
JumpInput.Size = UDim2.new(0.2, 0, 0, 30) JumpInput.Position = UDim2.new(0.35, 0, 0, 55)
JumpInput.BackgroundColor3 = Color3.fromRGB(40, 40, 40) JumpInput.TextColor3 = Color3.fromRGB(255, 200, 0)
JumpInput.Text = "120" JumpInput.Font = Enum.Font.SourceSansBold JumpInput.TextSize = 14
table.insert(yellowElements, JumpInput)
local JumpBtn = Instance.new("TextButton", PlayerPage)
JumpBtn.Size = UDim2.new(0.35, 0, 0, 30) JumpBtn.Position = UDim2.new(0.6, 0, 0, 55)
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

local flying = false local flyBody
local FlyBtn = createPlayerButton("تفعيل الطيران المدمج والآمن (Fly)", 95, function(state)
    flying = state
    local root = Player.Character and Player.Character:FindFirstChild("HumanoidRootPart")
    if not root then return end
    if flying then
        flyBody = Instance.new("BodyVelocity", root)
        flyBody.MaxForce = Vector3.new(1,1,1) * 9e9
        task.spawn(function()
            while flying and task.wait() do
                local camCFrame = workspace.CurrentCamera.CFrame
                local dir = Vector3.new()
                if UserInputService:IsKeyDown(Enum.KeyCode.W) then dir = dir + camCFrame.LookVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.S) then dir = dir - camCFrame.LookVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.D) then dir = dir + camCFrame.RightVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.A) then dir = dir - camCFrame.RightVector end
                flyBody.Velocity = dir.Magnitude > 0 and dir.Unit * 80 or Vector3.new(0,0,0)
            end
            if flyBody then flyBody:Destroy() end
        end)
    else
        if flyBody then flyBody:Destroy() end
    end
end)
FlyBtn.BackgroundColor3 = Color3.fromRGB(120, 0, 120)

local ghostActive = false local ghostChar
createPlayerButton("القوست مود (Ghost Mode)", 135, function(state)
    ghostActive = state local char = Player.Character
    if ghostActive and char and char:FindFirstChild("HumanoidRootPart") then
        ghostChar = char:Clone() ghostChar.Parent = workspace
        ghostChar.HumanoidRootPart.CFrame = char.HumanoidRootPart.CFrame
        workspace.CurrentCamera.CameraSubject = ghostChar.Humanoid
        char.HumanoidRootPart.CFrame = CFrame.new(0, -5000, 0)
    elseif ghostChar and char and char:FindFirstChild("HumanoidRootPart") then
        workspace.CurrentCamera.CameraSubject = char.Humanoid
        char.HumanoidRootPart.CFrame = ghostChar.HumanoidRootPart.CFrame
        ghostChar:Destroy()
    end
end)

local lockActive = false local cam = workspace.CurrentCamera
createPlayerButton("قفل الكاميرا", 175, function(state)
    lockActive = state
    cam.CameraType = lockActive and Enum.CameraType.Scriptable or Enum.CameraType.Custom
end)

local noclipActive = false local noclipConnection
createPlayerButton("تفعيل اختراق الجدران (Noclip)", 215, function(state)
    noclipActive = state
    if noclipActive then
        noclipConnection = RunService.Stepped:Connect(function()
            if Player.Character then for _, part in ipairs(Player.Character:GetChildren()) do if part:IsA("BasePart") then part.CanCollide = false end end end
        end)
    else
        if noclipConnection then noclipConnection:Disconnect() noclipConnection = nil end
    end
end)

local infJumpActive = false
UserInputService.JumpRequest:Connect(function()
    if infJumpActive and Player.Character and Player.Character:FindFirstChild("Humanoid") then Player.Character.Humanoid:ChangeState("Jumping") end
end)
createPlayerButton("تفعيل القفز اللانهائي (Inf Jump)", 255, function(state) infJumpActive = state end)

local ringHighlight local ringConnection
createPlayerButton("💫 حلقة الألوان النيون حول الشخصية", 295, function(state)
    if ringConnection then ringConnection:Disconnect() ringConnection = nil end
    if ringHighlight then ringHighlight:Destroy() ringHighlight = nil end
    if state and Player.Character then
        ringHighlight = Instance.new("Highlight")
        ringHighlight.Name = "AihamRainbowRing"
        ringHighlight.FillTransparency = 0.5 ringHighlight.OutlineTransparency = 0
        ringHighlight.Parent = Player.Character
        ringConnection = RunService.RenderStepped:Connect(function()
            if ringHighlight and ringHighlight.Parent then
                local color = Color3.fromHSV((tick() % 4) / 4, 1, 1)
                ringHighlight.FillColor = color ringHighlight.OutlineColor = color
            end
        end)
    end
end)

local topCamConnection
createPlayerButton("👁️ رؤية الأعلى — كاميرا من فوق (Top View)", 335, function(state)
    if topCamConnection then topCamConnection:Disconnect() topCamConnection = nil end
    local cam = workspace.CurrentCamera
    if state then
        cam.CameraType = Enum.CameraType.Scriptable
        topCamConnection = RunService.RenderStepped:Connect(function()
            if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
                local rootPos = Player.Character.HumanoidRootPart.Position
                cam.CFrame = CFrame.new(rootPos + Vector3.new(0, 35, 0), rootPos)
            end
        end)
    else
        cam.CameraType = Enum.CameraType.Custom
        if Player.Character and Player.Character:FindFirstChild("Humanoid") then cam.CameraSubject = Player.Character.Humanoid end
    end
end)

local wallWalkConnection
createPlayerButton("🧱 WallWalk — المشي على الجدران بالـ Raycast", 375, function(state)
    if wallWalkConnection then wallWalkConnection:Disconnect() wallWalkConnection = nil end
    if state then
        wallWalkConnection = RunService.Heartbeat:Connect(function()
            if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
                local root = Player.Character.HumanoidRootPart
                local params = RaycastParams.new()
                params.FilterDescendantsInstances = {Player.Character}
                params.FilterType = Enum.RaycastFilterType.Exclude
                local result = workspace:Raycast(root.Position, root.CFrame.LookVector * 3, params)
                if result then root.Velocity = Vector3.new(root.Velocity.X, 20, root.Velocity.Z) end
            end
        end)
    end
end)

local antiAfkConnection
createPlayerButton("⏱️ Anti-AFK — منع الطرد تلقائياً من الماب", 415, function(state)
    if antiAfkConnection then antiAfkConnection:Disconnect() antiAfkConnection = nil end
    if state then
        antiAfkConnection = Player.Idled:Connect(function()
            local vu = game:GetService("VirtualUser")
            vu:CaptureController() vu:ClickButton2(Vector2.new())
        end)
    end
end)

local spinLoopConnection
createPlayerButton("🌀 Spin — تدوير الشخصية باستمرار", 455, function(state)
    if spinLoopConnection then spinLoopConnection:Disconnect() spinLoopConnection = nil end
    if state then
        spinLoopConnection = RunService.RenderStepped:Connect(function()
            if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
                Player.Character.HumanoidRootPart.CFrame = Player.Character.HumanoidRootPart.CFrame * CFrame.Angles(0, math.rad(15), 0)
            end
        end)
    end
end)

createPlayerButton("👻 Invisible — إخفاء الشخصية كاملاً", 495, function(state)
    if Player.Character then
        for _, obj in ipairs(Player.Character:GetDescendants()) do
            if obj:IsA("BasePart") and obj.Name ~= "HumanoidRootPart" then obj.Transparency = state and 1 or 0
            elseif obj:IsA("Decal") then obj.Transparency = state and 1 or 0 end
        end
    end
end)

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
        if p.Name:lower():sub(1, #tName) == tName and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then 
            Player.Character.HumanoidRootPart.CFrame = p.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3) 
        end
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
        GoBtn.Size = U
