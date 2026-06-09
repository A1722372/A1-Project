-- [[ سكريبت أيهم الأسطوري V15 (الكامل) ]]
local Player = game.Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")
local Backpack = Player:WaitForChild("Backpack")
local RunService = game:GetService("RunService")
local PlayersService = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")

if PlayerGui:FindFirstChild("AihamSuperMenu") then 
    PlayerGui.AihamSuperMenu:Destroy() 
end

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

local function setBorderColor(mode)
    if rainbowConnection then 
        rainbowConnection:Disconnect() 
        rainbowConnection = nil 
    end
    
    local function applyColor(color)
        for _, obj in ipairs(yellowElements) do
            if obj and obj.Parent then
                if obj:IsA("TextButton") or obj:IsA("Frame") then 
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

local ToggleButton = Instance.new("TextButton", ScreenGui)
ToggleButton.Size = UDim2.new(0, 40, 0, 40)
ToggleButton.Position = UDim2.new(0, 10, 0.5, -20)
ToggleButton.BackgroundColor3 = Color3.fromRGB(255, 200, 0)
ToggleButton.Text = "●"
ToggleButton.TextColor3 = Color3.fromRGB(0, 0, 0)
ToggleButton.TextSize = 22 
ToggleButton.Font = Enum.Font.SourceSansBold
ToggleButton.Active = true 
ToggleButton.Draggable = true
ToggleButton.MouseButton1Click:Connect(function() 
    MainFrame.Visible = not MainFrame.Visible 
end)
table.insert(yellowElements, ToggleButton)

local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, 0, 0, 35) 
Title.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
Title.Text = "صنع من قبل المطور الأسطوري أيهم"
Title.TextColor3 = Color3.fromRGB(255, 200, 0) 
Title.TextSize = 16 
Title.Font = Enum.Font.SourceSansBold
table.insert(yellowElements, Title)

local SideMenu = Instance.new("ScrollingFrame", MainFrame)
SideMenu.Size = UDim2.new(0, 130, 1, -35) 
SideMenu.Position = UDim2.new(0, 0, 0, 35)
SideMenu.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
SideMenu.CanvasSize = UDim2.new(0, 0, 0, 300)
SideMenu.ScrollBarThickness = 5

local ContentArea = Instance.new("Frame", MainFrame)
ContentArea.Size = UDim2.new(1, -130, 1, -35) 
ContentArea.Position = UDim2.new(0, 130, 0, 35)
ContentArea.BackgroundTransparency = 1

local Pages = {}
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
    table.insert(yellowElements, btn)
    
    local page = Instance.new("ScrollingFrame", ContentArea)
    page.Size = UDim2.new(1, 0, 1, 0) 
    page.BackgroundTransparency = 1
    page.CanvasSize = UDim2.new(0, 0, 0, 450) 
    page.ScrollBarThickness = 5
    page.Visible = (i == 1) 
    Pages[i] = page
    
    btn.MouseButton1Click:Connect(function()
        for _, p in ipairs(Pages) do 
            p.Visible = false 
        end
        page.Visible = true
    end)
end

-- === [ شريحة 1: اعدادات الماب ] ===
local MapPage = Pages[1]
local ShaderBtn = Instance.new("TextButton", MapPage)
ShaderBtn.Size = UDim2.new(0.9, 0, 0, 35) 
ShaderBtn.Position = UDim2.new(0.05, 0, 0, 10)
ShaderBtn.Text = "تفعيل الشادر (Shader)" 
ShaderBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
ShaderBtn.TextColor3 = Color3.fromRGB(255, 255, 255) 
ShaderBtn.Font = Enum.Font.SourceSansBold 
ShaderBtn.TextSize = 13
local shaderActive = false
ShaderBtn.MouseButton1Click:Connect(function()
    shaderActive = not shaderActive
    ShaderBtn.BackgroundColor3 = shaderActive and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(40, 40, 40)
    Lighting.Brightness = shaderActive and 2 or 1
    Lighting.ClockTime = shaderActive and 12 or 14
end)

local BrightBtn = Instance.new("TextButton", MapPage)
BrightBtn.Size = UDim2.new(0.9, 0, 0, 35) 
BrightBtn.Position = UDim2.new(0.05, 0, 0, 50)
BrightBtn.Text = "جعل الماب مضوي بالكامل (FullBright)" 
BrightBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
BrightBtn.TextColor3 = Color3.fromRGB(255, 255, 255) 
BrightBtn.Font = Enum.Font.SourceSansBold 
BrightBtn.TextSize = 13
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
    cBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50) 
    cBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    cBtn.Text = colorNames[mode] 
    cBtn.Font = Enum.Font.SourceSansBold 
    cBtn.TextSize = 12
    cBtn.MouseButton1Click:Connect(function() 
        setBorderColor(mode) 
    end)
end

-- === [ شريحة 2: اللاعب ] ===
local PlayerPage = Pages[2]
local SpeedLabel = Instance.new("TextLabel", PlayerPage)
SpeedLabel.Size = UDim2.new(0.3, 0, 0, 30) 
SpeedLabel.Position = UDim2.new(0.05, 0, 0, 15)
SpeedLabel.Text = "السرعة:" 
SpeedLabel.TextColor3 = Color3.fromRGB(255, 255, 255) 
SpeedLabel.BackgroundTransparency = 1

local SpeedInput = Instance.new("TextBox", PlayerPage)
SpeedInput.Size = UDim2.new(0.2, 0, 0, 30) 
SpeedInput.Position = UDim2.new(0.35, 0, 0, 15)
SpeedInput.BackgroundColor3 = Color3.fromRGB(40, 40, 40) 
SpeedInput.TextColor3 = Color3.fromRGB(255, 200, 0)
SpeedInput.Text = "65" 
SpeedInput.Font = Enum.Font.SourceSansBold 
SpeedInput.TextSize = 14
table.insert(yellowElements, SpeedInput)

local SpeedBtn = Instance.new("TextButton", PlayerPage)
SpeedBtn.Size = UDim2.new(0.35, 0, 0, 30) 
SpeedBtn.Position = UDim2.new(0.6, 0, 0, 15)
SpeedBtn.Text = "تفعيل السرعة" 
SpeedBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50) 
SpeedBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
local speedActive = false

SpeedInput:GetPropertyChangedSignal("Text"):Connect(function()
    if speedActive and Player.Character and Player.Character:FindFirstChild("Humanoid") then
        Player.Character.Humanoid.WalkSpeed = tonumber(SpeedInput.Text) or 65
    end
end)

SpeedBtn.MouseButton1Click:Connect(function()
    speedActive = not speedActive
    SpeedBtn.BackgroundColor3 = speedActive and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(50, 50, 50)
    if speedActive then 
        Player.Character.Humanoid.WalkSpeed = tonumber(SpeedInput.Text) or 65 
    else 
        Player.Character.Humanoid.WalkSpeed = 16 
    end
end)

local JumpLabel = Instance.new("TextLabel", PlayerPage)
JumpLabel.Size = UDim2.new(0.3, 0, 0, 30) 
JumpLabel.Position = UDim2.new(0.05, 0, 0, 60)
JumpLabel.Text = "القفز:" 
JumpLabel.TextColor3 = Color3.fromRGB(255, 255, 255) 
JumpLabel.BackgroundTransparency = 1

local JumpInput = Instance.new("TextBox", PlayerPage)
JumpInput.Size = UDim2.new(0.2, 0, 0, 30) 
JumpInput.Position = UDim2.new(0.35, 0, 0, 60)
JumpInput.BackgroundColor3 = Color3.fromRGB(40, 40, 40) 
JumpInput.TextColor3 = Color3.fromRGB(255, 200, 0)
JumpInput.Text = "120" 
JumpInput.Font = Enum.Font.SourceSansBold 
JumpInput.TextSize = 14
table.insert(yellowElements, JumpInput)

local JumpBtn = Instance.new("TextButton", PlayerPage)
JumpBtn.Size = UDim2.new(0.35, 0, 0, 30) 
JumpBtn.Position = UDim2.new(0.6, 0, 0, 60)
JumpBtn.Text = "تفعيل القفز" 
JumpBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50) 
JumpBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
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
FlyBtn.Size = UDim2.new(0.9, 0, 0, 32) 
FlyBtn.Position = UDim2.new(0.05, 0, 0, 105)
FlyBtn.Text = "تفعيل الطيران (FlyGuiV3)" 
FlyBtn.BackgroundColor3 = Color3.fromRGB(120, 0, 120) 
FlyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
FlyBtn.Font = Enum.Font.SourceSansBold 
FlyBtn.TextSize = 13
FlyBtn.MouseButton1Click:Connect(function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/XNEOFF/FlyGuiV3/main/FlyGuiV3.txt"))()
end)

local GhostBtn = Instance.new("TextButton", PlayerPage)
GhostBtn.Size = UDim2.new(0.9, 0, 0, 32) 
GhostBtn.Position = UDim2.new(0.05, 0, 0, 145)
GhostBtn.Text = "القفست مود (Ghost Mode)" 
GhostBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40) 
GhostBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
local ghostActive = false 
local ghostChar

GhostBtn.MouseButton1Click:Connect(function()
    ghostActive = not ghostActive
    GhostBtn.BackgroundColor3 = ghostActive and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(40, 40, 40)
    local char = Player.Character
    if ghostActive then
        ghostChar = char:Clone() 
        ghostChar.Parent = workspace
        ghostChar.HumanoidRootPart.CFrame = char.HumanoidRootPart.CFrame
        workspace.CurrentCamera.CameraSubject = ghostChar.Humanoid
        char.HumanoidRootPart.CFrame = CFrame.new(0, -5000, 0)
        RunService.RenderStepped:Connect(function() 
            if ghostActive and ghostChar then 
                ghostChar.Humanoid:Move(char.Humanoid.MoveDirection, true) 
            end 
        end)
    else
        workspace.CurrentCamera.CameraSubject = char.Humanoid
        char.HumanoidRootPart.CFrame = ghostChar.HumanoidRootPart.CFrame
        ghostChar:Destroy()
    end
end)

local LockCamBtn = Instance.new("TextButton", PlayerPage)
LockCamBtn.Size = UDim2.new(0.9, 0, 0, 32) 
LockCamBtn.Position = UDim2.new(0.05, 0, 0, 185)
LockCamBtn.Text = "قفل الكاميرا" 
LockCamBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40) 
LockCamBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
local lockActive = false 
local cam = workspace.CurrentCamera

LockCamBtn.MouseButton1Click:Connect(function()
    lockActive = not lockActive
    LockCamBtn.BackgroundColor3 = lockActive and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(40, 40, 40)
    cam.CameraType = lockActive and Enum.CameraType.Scriptable or Enum.CameraType.Custom
end)

local NoclipBtn = Instance.new("TextButton", PlayerPage)
NoclipBtn.Size = UDim2.new(0.9, 0, 0, 32) 
NoclipBtn.Position = UDim2.new(0.05, 0, 0, 225)
NoclipBtn.Text = "تفعيل اختراق الجدران (Noclip)" 
NoclipBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40) 
NoclipBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
local noclipActive = false 
local noclipConnection

NoclipBtn.MouseButton1Click:Connect(function()
    noclipActive = not noclipActive
    NoclipBtn.BackgroundColor3 = noclipActive and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(40, 40, 40)
    if noclipActive then
        noclipConnection = RunService.Stepped:Connect(function()
            if Player.Character then 
                for _, part in ipairs(Player.Character:GetChildren()) do 
                    if part:IsA("BasePart") then 
                        part.CanCollide = false 
                    end 
                end 
            end
        end)
    else
        if noclipConnection then 
            noclipConnection:Disconnect() 
            noclipConnection = nil 
        end
    end
end)

local InfJumpBtn = Instance.new("TextButton", PlayerPage)
InfJumpBtn.Size = UDim2.new(0.9, 0, 0, 32) 
InfJumpBtn.Position = UDim2.new(0.05, 0, 0, 265)
InfJumpBtn.Text = "تفعيل القفز اللانهائي (Inf Jump)" 
InfJumpBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40) 
InfJumpBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
local infJumpActive = false

UserInputService.JumpRequest:Connect(function()
    if infJumpActive and Player.Character and Player.Character:FindFirstChild("Humanoid") then 
        Player.Character.Humanoid:ChangeState("Jumping") 
    end
end)

InfJumpBtn.MouseButton1Click:Connect(function() 
    infJumpActive = not infJumpActive 
    InfJumpBtn.BackgroundColor3 = infJumpActive and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(40, 40, 40) 
end)

local SpinBtn = Instance.new("TextButton", PlayerPage)
SpinBtn.Size = UDim2.new(0.9, 0, 0, 32) 
SpinBtn.Position = UDim2.new(0.05, 0, 0, 305)
SpinBtn.Text = "تفعيل الدوران (Spin)" 
SpinBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40) 
SpinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
local spinActive = false 
local spinConnection

SpinBtn.MouseButton1Click:Connect(function()
    spinActive = not spinActive
    SpinBtn.BackgroundColor3 = spinActive and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(40, 40, 40)
    if spinActive then
        spinConnection = RunService.RenderStepped:Connect(function()
            if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
                Player.Character.HumanoidRootPart.CFrame = Player.Character.HumanoidRootPart.CFrame * CFrame.Angles(0, math.rad(20), 0)
            end
        end)
    else
        if spinConnection then 
            spinConnection:Disconnect() 
            spinConnection = nil 
        end
    end
end)

local WallwalkBtn = Instance.new("TextButton", PlayerPage)
WallwalkBtn.Size = UDim2.new(0.9, 0, 0, 32) 
WallwalkBtn.Position = UDim2.new(0.05, 0, 0, 345)
WallwalkBtn.Text = "تفعيل مشي الجدران (Wallwalk)" 
WallwalkBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40) 
WallwalkBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
local wallwalkActive = false 
local wallwalkConnection

WallwalkBtn.MouseButton1Click:Connect(function()
    wallwalkActive = not wallwalkActive
    WallwalkBtn.BackgroundColor3 = wallwalkActive and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(40, 40, 40)
    if wallwalkActive then
        wallwalkConnection = RunService.Stepped:Connect(function()
            if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
                local ray = Ray.new(Player.Character.HumanoidRootPart.Position, Player.Character.HumanoidRootPart.CFrame.LookVector * 3)
                local part = workspace:FindPartOnRay(ray, Player.Character)
                if part then
                    Player.Character.HumanoidRootPart.Velocity = Vector3.new(Player.Character.HumanoidRootPart.Velocity.X, 25, Player.Character.HumanoidRootPart.Velocity.Z)
                end
            end
        end)
    else
        if wallwalkConnection then 
            wallwalkConnection:Disconnect() 
            wallwalkConnection = nil 
        end
    end
end)

local ClickTpBtn = Instance.new("TextButton", PlayerPage)
ClickTpBtn.Size = UDim2.new(0.9, 0, 0, 32) 
ClickTpBtn.Position = UDim2.new(0.05, 0, 0, 385)
ClickTpBtn.Text = "تفعيل الانتقال بالضغط (Click TP)" 
ClickTpBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40) 
ClickTpBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
local clickTpActive = false 
local clickTpConnection

ClickTpBtn.MouseButton1Click:Connect(function()
    clickTpActive = not clickTpActive
    ClickTpBtn.BackgroundColor3 = clickTpActive and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(40, 40, 40)
    if clickTpActive then
        clickTpConnection = UserInputService.InputBegan:Connect(function(input, processed)
            if not processed and input.UserInputType == Enum.UserInputType.MouseButton1 and clickTpActive then
                local mouse = Player:GetMouse()
                if mouse and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
                    Player.Character.HumanoidRootPart.CFrame = CFrame.new(mouse.Hit.Position + Vector3.new(0, 3, 0))
                end
            end
        end)
    else
        if clickTpConnection then 
            clickTpConnection:Disconnect() 
            clickTpConnection = nil 
        end
    end
end)

local TargetPage = Pages[3]
local NameBox = Instance.new("TextBox", TargetPage)
NameBox.Size = UDim2.new(0.9, 0, 0, 35) 
NameBox.Position = UDim2.new(0.05, 0, 0, 10)
NameBox.BackgroundColor3 = Color3.fromRGB(30, 30, 30) 
NameBox.TextColor3 = Color3.fromRGB(255, 255, 255) 
NameBox.PlaceholderText = "اسم اللاعب..."

local TeleBtn = Instance.new("TextButton", TargetPage)
TeleBtn.Size = UDim2.new(0.9, 0, 0, 32) 
TeleBtn.Position = UDim2.new(0.05, 0, 0, 55)
TeleBtn.Text = "انتقال فوري للاعب" 
TeleBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50) 
TeleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
TeleBtn.MouseButton1Click:Connect(function()
    local tName = NameBox.Text:lower()
    for _, p in ipairs(PlayersService:GetPlayers()) do
        if p.Name:lower():sub(1, #tName) == tName and p.Character then 
            Player.Character.HumanoidRootPart.CFrame = p.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3) 
        end
    end
end)

local CheckpointPage = Pages[4]
local CPInput = Instance.new("TextBox", CheckpointPage)
CPInput.Size = UDim2.new(0.55, 0, 0, 32) 
CPInput.Position = UDim2.new(0.05, 0, 0, 10)
CPInput.BackgroundColor3 = Color3.fromRGB(30, 30, 30) 
CPInput.TextColor3 = Color3.fromRGB(255, 255, 255) 
CPInput.PlaceholderText = "اسم الموقع..."

local ListContainer = Instance.new("ScrollingFrame", CheckpointPage)
ListContainer.Size = UDim2.new(0.9, 0, 0, 160) 
ListContainer.Position = UDim2.new(0.05, 0, 0, 50)
ListContainer.BackgroundTransparency = 0.9 
ListContainer.CanvasSize = UDim2.new(0, 0, 0, 600) 
ListContainer.ScrollBarThickness = 4
local savedLocations = {}

local function updateCPList()
    ListContainer:ClearAllChildren()
    local count = 0
    for name, cframe in pairs(savedLocations) do
        local ItemFrame = Instance.new("Frame", ListContainer)
        ItemFrame.Size = UDim2.new(0.95, 0, 0, 30) 
        ItemFrame.Position = UDim2.new(0, 0, 0, count * 34)
        ItemFrame.BackgroundTransparency = 1
        
        local GoBtn = Instance.new("TextButton", ItemFrame)
        GoBtn.Size = UDim2.new(0.8, 0, 1, 0) 
        GoBtn.Text = name
        GoBtn.BackgroundCol
