-- [[ سكريبت Anxam المطور الإبداعي الخارق - الحزب الأول V64.0 ]]
local Player = game.Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")
local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")

if not getgenv().AihamSavedPositions then getgenv().AihamSavedPositions = {} end
if PlayerGui:FindFirstChild("AihamScript_Main") then PlayerGui.AihamScript_Main:Destroy() end

local ScreenGui = Instance.new("ScreenGui", PlayerGui)
ScreenGui.Name = "AihamScript_Main"
ScreenGui.ResetOnSpawn = false
ScreenGui.DisplayOrder = 2147483647 

local ToggleBtn = Instance.new("TextButton", ScreenGui)
ToggleBtn.Name = "ToggleBtn"
ToggleBtn.Size = UDim2.new(0, 45, 0, 45)
ToggleBtn.Position = UDim2.new(0, 15, 0, 15)
ToggleBtn.Text = "إخفاء" 
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(150, 30, 30)
ToggleBtn.TextSize = 13
ToggleBtn.Font = Enum.Font.SourceSansBold
ToggleBtn.Draggable = true
ToggleBtn.ZIndex = 100
Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(1, 0)

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 530, 0, 340)
MainFrame.Position = UDim2.new(0.5, -265, 0.5, -170)
MainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
MainFrame.Active = true 
MainFrame.Draggable = true
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 12)

ToggleBtn.MouseButton1Click:Connect(function()
    if MainFrame.Visible then
        MainFrame.Visible = false
        ToggleBtn.Text = "إظهار"
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(14, 110, 200)
    else
        MainFrame.Visible = true
        ToggleBtn.Text = "إخفاء"
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(150, 30, 30)
    end
end)

local SideMenu = Instance.new("ScrollingFrame", MainFrame)
SideMenu.Size = UDim2.new(0, 145, 1, -20)
SideMenu.Position = UDim2.new(0, 10, 0, 10)
SideMenu.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
SideMenu.BorderSizePixel = 0
SideMenu.ScrollBarThickness = 3
SideMenu.CanvasSize = UDim2.new(0, 0, 0, 350)
Instance.new("UICorner", SideMenu).CornerRadius = UDim.new(0, 8)

local SideLayout = Instance.new("UIListLayout", SideMenu)
SideLayout.Padding = UDim.new(0, 6)
SideLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

local ContentArea = Instance.new("Frame", MainFrame)
ContentArea.Size = UDim2.new(1, -175, 1, -20)
ContentArea.Position = UDim2.new(0, 165, 0, 10)
ContentArea.BackgroundTransparency = 1

local MenuConfig = {"اعدادات الماب", "اللاعب", "ميزات خارقة 🔥", "الاستهداف", "التأثيرات", "المحفوظات", "العسكرية 🎖️"}
local AllPages = {}

for i, name in ipairs(MenuConfig) do
    local btn = Instance.new("TextButton", SideMenu)
    btn.Size = UDim2.new(0.95, 0, 0, 36)
    btn.Text = name
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 13
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    
    local page = Instance.new("ScrollingFrame", ContentArea)
    page.Size = UDim2.new(1, 0, 1, 0)
    page.BackgroundTransparency = 1
    page.BorderSizePixel = 0
    page.ScrollBarThickness = 4
    page.Visible = (i == 2)
    
    local PageLayout = Instance.new("UIListLayout", page)
    PageLayout.Padding = UDim.new(0, 6)
    PageLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    
    AllPages[name] = page
    
    btn.MouseButton1Click:Connect(function()
        for _, p in pairs(AllPages) do p.Visible = false end
        page.Visible = true
        for _, b in pairs(SideMenu:GetChildren()) do
            if b:IsA("TextButton") then b.BackgroundColor3 = Color3.fromRGB(40, 40, 40) end
        end
        btn.BackgroundColor3 = Color3.fromRGB(65, 65, 65)
    end)
end

local MapPage = AllPages["اعدادات الماب"]
MapPage.CanvasSize = UDim2.new(0, 0, 0, 350)

local function CreateMapButton(text, onClick)
    local btn = Instance.new("TextButton", MapPage)
    btn.Size = UDim2.new(0.95, 0, 0, 40)
    btn.Text = text
    btn.Font = Enum.Font.SourceSansBold
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    btn.MouseButton1Click:Connect(onClick)
    return btn
end

local FBButton = CreateMapButton("السطوع: مطفأ", function() end)
local FBEnabled = false
FBButton.MouseButton1Click:Connect(function()
    FBEnabled = not FBEnabled
    Lighting.Ambient = FBEnabled and Color3.new(1,1,1) or Color3.new(0,0,0)
    FBButton.Text = FBEnabled and "السطوع: شغال" or "السطوع: مطفأ"
    FBButton.BackgroundColor3 = FBEnabled and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(150, 0, 0)
end)

CreateMapButton("إزالة الضباب والغيوم", function()
    Lighting.FogEnd = 999999
    Lighting.GlobalShadows = false
    local atmosphere = Lighting:FindFirstChildOfClass("Atmosphere")
    if atmosphere then atmosphere:Destroy() end
end)

CreateMapButton("تسريع رندر الماب (إزالة اللق)", function()
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") and not obj:IsA("MeshPart") then
            obj.Material = Enum.Material.SmoothPlastic
        end
    end
end)

local DiscordBtn = CreateMapButton("نسخ سيرفر الديسكورد", function()
    setclipboard("https://discord.gg/WrxQZDVps")
end)
DiscordBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
-- [[ نهاية الحزب الأول ]]
-- ==================== تبويب اللاعب المطور (خانات السرعة والنط) ====================
local PlayerPage = AllPages["اللاعب"]
PlayerPage.CanvasSize = UDim2.new(0, 0, 0, 500)

local function CreatePlayerButton(text, onClick)
    local btn = Instance.new("TextButton", PlayerPage)
    btn.Size = UDim2.new(0.95, 0, 0, 38)
    btn.Text = text
    btn.Font = Enum.Font.SourceSansBold
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    btn.MouseButton1Click:Connect(onClick)
    return btn
end

-- خانة التحكم بالسرعة (Speed)
local SpeedContainer = Instance.new("Frame", PlayerPage)
SpeedContainer.Size = UDim2.new(0.95, 0, 0, 40)
SpeedContainer.BackgroundTransparency = 1

local SpeedInput = Instance.new("TextBox", SpeedContainer)
SpeedInput.Size = UDim2.new(0.6, -5, 1, 0)
SpeedInput.PlaceholderText = "قيمة السرعة (مثال: 60)"
SpeedInput.TextColor3 = Color3.new(1,1,1)
SpeedInput.BackgroundColor3 = Color3.fromRGB(40,40,40)
Instance.new("UICorner", SpeedInput)

local SpeedBtn = Instance.new("TextButton", SpeedContainer)
SpeedBtn.Size = UDim2.new(0.4, 0, 1, 0)
SpeedBtn.Position = UDim2.new(0.6, 5, 0, 0)
SpeedBtn.Text = "تفعيل السرعة"
SpeedBtn.Font = Enum.Font.SourceSansBold
SpeedBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
SpeedBtn.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", SpeedBtn)

local SpeedEnabled = false
SpeedBtn.MouseButton1Click:Connect(function() 
    SpeedEnabled = not SpeedEnabled
    SpeedBtn.Text = SpeedEnabled and "السرعة: مفعلة" or "تفعيل السرعة"
    SpeedBtn.BackgroundColor3 = SpeedEnabled and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(150, 0, 0) 
end)

RunService.Heartbeat:Connect(function() 
    if SpeedEnabled and Player.Character and Player.Character:FindFirstChild("Humanoid") then 
        Player.Character.Humanoid.WalkSpeed = tonumber(SpeedInput.Text) or 16 
    end 
end)

-- خانة التحكم بالنط والقفز (Jump Power)
local JumpContainer = Instance.new("Frame", PlayerPage)
JumpContainer.Size = UDim2.new(0.95, 0, 0, 40)
JumpContainer.BackgroundTransparency = 1

local JumpInput = Instance.new("TextBox", JumpContainer)
JumpInput.Size = UDim2.new(0.6, -5, 1, 0)
JumpInput.PlaceholderText = "قوة النط (مثال: 100)"
JumpInput.TextColor3 = Color3.new(1,1,1)
JumpInput.BackgroundColor3 = Color3.fromRGB(40,40,40)
Instance.new("UICorner", JumpInput)

local JumpBtn = Instance.new("TextButton", JumpContainer)
JumpBtn.Size = UDim2.new(0.4, 0, 1, 0)
JumpBtn.Position = UDim2.new(0.6, 5, 0, 0)
JumpBtn.Text = "تفعيل النط"
JumpBtn.Font = Enum.Font.SourceSansBold
JumpBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
JumpBtn.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", JumpBtn)

local JumpPowerEnabled = false
JumpBtn.MouseButton1Click:Connect(function()
    JumpPowerEnabled = not JumpPowerEnabled
    JumpBtn.Text = JumpPowerEnabled and "النط: مفعل" or "تفعيل النط"
    JumpBtn.BackgroundColor3 = JumpPowerEnabled and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(150, 0, 0)
end)

RunService.Heartbeat:Connect(function()
    if JumpPowerEnabled and Player.Character and Player.Character:FindFirstChild("Humanoid") then
        Player.Character.Humanoid.UseJumpPower = true
        Player.Character.Humanoid.JumpPower = tonumber(JumpInput.Text) or 50
    end
end)

local InfJumpBtn = CreatePlayerButton("قفز لا نهائي: مطفأ", function() end)
local JumpEnabled = false
InfJumpBtn.MouseButton1Click:Connect(function() 
    JumpEnabled = not JumpEnabled 
    InfJumpBtn.Text = JumpEnabled and "قفز لا نهائي: شغال" or "قفز لا نهائي: مطفأ"
    InfJumpBtn.BackgroundColor3 = JumpEnabled and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(45, 45, 45) 
end)
UIS.JumpRequest:Connect(function() if JumpEnabled and Player.Character and Player.Character:FindFirstChild("Humanoid") then Player.Character.Humanoid:ChangeState("Jumping") end end)

local NoclipBtn = CreatePlayerButton("اختراق الجدران: مطفأ", function() end)
local NoclipEnabled = false
NoclipBtn.MouseButton1Click:Connect(function() 
    NoclipEnabled = not NoclipEnabled
    NoclipBtn.Text = NoclipEnabled and "اختراق الجدران: شغال" or "اختراق الجدران: مطفأ"
    NoclipBtn.BackgroundColor3 = NoclipEnabled and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(45, 45, 45) 
end)
RunService.Stepped:Connect(function() if NoclipEnabled and Player.Character then for _, p in pairs(Player.Character:GetDescendants()) do if p:IsA("BasePart") then p.CanCollide = false end end end end)

CreatePlayerButton("أداة الانتقال بالضغط (Click TP)", function()
    local Backpack = Player:FindFirstChildOfClass("Backpack")
    if Backpack then
        local Tool = Instance.new("Tool")
        Tool.Name = "انتقال بالضغط 📍"
        Tool.RequiresHandle = false
        Tool.Parent = Backpack
        Tool.Activated:Connect(function()
            local mouse = Player:GetMouse()
            if mouse and mouse.Hit and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
                Player.Character.HumanoidRootPart.CFrame = CFrame.new(mouse.Hit.X, mouse.Hit.Y + 3, mouse.Hit.Z)
            end
        end)
    end
end).BackgroundColor3 = Color3.fromRGB(0, 120, 120)

-- ==================== تبويب ميزات خارقة 🔥 ====================
local SuperPage = AllPages["ميزات خارقة 🔥"]
SuperPage.CanvasSize = UDim2.new(0, 0, 0, 450)

local function CreateSuperButton(text)
    local btn = Instance.new("TextButton", SuperPage)
    btn.Size = UDim2.new(0.95, 0, 0, 40)
    btn.Text = text
    btn.Font = Enum.Font.SourceSansBold
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    return btn
end

local FlyBtn = CreateSuperButton("تفعيل الطيران الذاتي: مطفأ")
local Flying = false
local FlySpeed = 45
local BodyVelocity, BodyGyro

FlyBtn.MouseButton1Click:Connect(function()
    Flying = not Flying
    FlyBtn.Text = Flying and "تفعيل الطيران الذاتي: شغال" or "تفعيل الطيران الذاتي: مطفأ"
    FlyBtn.BackgroundColor3 = Flying and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(45, 45, 45)
    if Flying and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
        local tor = Player.Character.HumanoidRootPart
        BodyVelocity = Instance.new("BodyVelocity", tor)
        BodyVelocity.MaxForce = Vector3.new(9e9, 9e9, 9e9)
        BodyGyro = Instance.new("BodyGyro", tor)
        BodyGyro.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
        task.spawn(function()
            while Flying and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") do
                local cam = workspace.CurrentCamera.CFrame
                local move = Vector3.new(0,0,0)
                if UIS:IsKeyDown(Enum.KeyCode.W) then move = move + cam.LookVector end
                if UIS:IsKeyDown(Enum.KeyCode.S) then move = move - cam.LookVector end
                if UIS:IsKeyDown(Enum.KeyCode.A) then move = move - cam.RightVector end
                if UIS:IsKeyDown(Enum.KeyCode.D) then move = move + cam.RightVector end
                BodyVelocity.Velocity = move.Unit * FlySpeed
                if move == Vector3.new(0,0,0) then BodyVelocity.Velocity = Vector3.new(0,0,0) end
                BodyGyro.CFrame = cam
                task.wait()
            end
            if BodyVelocity then BodyVelocity:Destroy() end
            if BodyGyro then BodyGyro:Destroy() end
        end)
    end
end)

local InvisibleBtn = CreateSuperButton("إخفاء السيرفر الحقيقي: مطفأ")
local RealInvisible = false
local FakeSeat = nil
InvisibleBtn.MouseButton1Click:Connect(function()
    RealInvisible = not RealInvisible
    InvisibleBtn.Text = RealInvisible and "إخفاء السيرفر الحقيقي: شغال" or "إخفاء السيرفر الحقيقي: مطفأ"
    InvisibleBtn.BackgroundColor3 = RealInvisible and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(45, 45, 45)
    if RealInvisible and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
        FakeSeat = Instance.new("Seat", workspace)
        FakeSeat.Size = Vector3.new(2, 0.5, 2)
        FakeSeat.CFrame = Player.Character.HumanoidRootPart.CFrame * CFrame.new(0, -25, 0)
        FakeSeat.Transparency = 1
        FakeSeat.Anchored = true
        FakeSeat:Sit(Player.Character.Humanoid)
        for _, p in pairs(Player.Character:GetDescendants()) do
            if p:IsA("BasePart") or p:IsA("Decal") then p.Transparency = 0.8 end
        end
    else
        if FakeSeat then FakeSeat:Destroy() FakeSeat = nil end
        if Player.Character then
            Player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
            for _, p in pairs(Player.Character:GetDescendants()) do
                if p:IsA("BasePart") or p:IsA("Decal") then p.Transparency = p.Name == "HumanoidRootPart" and 1 or 0 end
            end
        end
    end
end)

local AntiSitBtn = CreateSuperButton("مضاد السقوط والجلوس: شغال")
AntiSitBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
local AntiSitEnabled = true
AntiSitBtn.MouseButton1Click:Connect(function()
    AntiSitEnabled = not AntiSitEnabled
    AntiSitBtn.Text = AntiSitEnabled and "مضاد السقوط والجلوس: شغال" or "مضاد السقوط والجلوس: مطفأ"
    AntiSitBtn.BackgroundColor3 = AntiSitEnabled and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(45, 45, 45)
end)
RunService.Heartbeat:Connect(function() if AntiSitEnabled and Player.Character and Player.Character:FindFirstChild("Humanoid") and not RealInvisible then Player.Character.Humanoid.Sit = false end end)
-- [[ نهاية الحزب الثاني ]]
-- ==================== تبويب الاستهداف الإبداعي الخارق ====================
local TargetPage = AllPages["الاستهداف"]
TargetPage.CanvasSize = UDim2.new(0, 0, 0, 580)

local DropdownTitle = Instance.new("TextLabel", TargetPage)
DropdownTitle.Size = UDim2.new(0.95, 0, 0, 25)
DropdownTitle.Text = "اختر لاعب من السيرفر 👇:"
DropdownTitle.Font = Enum.Font.SourceSansBold
DropdownTitle.TextSize = 14
DropdownTitle.TextColor3 = Color3.fromRGB(200, 200, 200)
DropdownTitle.BackgroundTransparency = 1

local PlayersContainer = Instance.new("ScrollingFrame", TargetPage)
PlayersContainer.Size = UDim2.new(0.95, 0, 0, 100)
PlayersContainer.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
PlayersContainer.ScrollBarThickness = 4
PlayersContainer.CanvasSize = UDim2.new(0, 0, 0, 250)
Instance.new("UICorner", PlayersContainer).CornerRadius = UDim.new(0, 6)

local PlrListLayout = Instance.new("UIListLayout", PlayersContainer)
PlrListLayout.Padding = UDim.new(0, 4)
PlrListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

local TargetPlayer = nil
local CurrentSelectedLabel = Instance.new("TextLabel", TargetPage)
CurrentSelectedLabel.Size = UDim2.new(0.95, 0, 0, 25)
CurrentSelectedLabel.Text = "اللاعب المحدد حالياً: لم يتم اختيار أحد"
CurrentSelectedLabel.Font = Enum.Font.SourceSansBold
CurrentSelectedLabel.TextSize = 13
CurrentSelectedLabel.TextColor3 = Color3.fromRGB(255, 165, 0)
CurrentSelectedLabel.BackgroundTransparency = 1

local function UpdatePlayersDropdown()
    for _, child in pairs(PlayersContainer:GetChildren()) do
        if child:IsA("TextButton") then child:Destroy() end
    end
    for _, plr in pairs(game.Players:GetPlayers()) do
        if plr ~= Player then
            local pBtn = Instance.new("TextButton", PlayersContainer)
            pBtn.Size = UDim2.new(0.95, 0, 0, 28)
            pBtn.Text = plr.DisplayName .. " (@" .. plr.Name .. ")"
            pBtn.Font = Enum.Font.SourceSans
            pBtn.TextSize = 12
            pBtn.TextColor3 = Color3.new(1, 1, 1)
            pBtn.BackgroundColor3 = (TargetPlayer == plr) and Color3.fromRGB(65, 65, 65) or Color3.fromRGB(45, 45, 45)
            Instance.new("UICorner", pBtn).CornerRadius = UDim.new(0, 4)
            
            pBtn.MouseButton1Click:Connect(function()
                TargetPlayer = plr
                CurrentSelectedLabel.Text = "اللاعب المحدد حالياً: " .. plr.Name
                UpdatePlayersDropdown()
            end)
        end
    end
end

game.Players.PlayerAdded:Connect(UpdatePlayersDropdown)
game.Players.PlayerRemoving:Connect(UpdatePlayersDropdown)
UpdatePlayersDropdown()

local function CreateTargetButton(bName)
    local b = Instance.new("TextButton", TargetPage)
    b.Size = UDim2.new(0.95, 0, 0, 36)
    b.Text = bName
    b.Font = Enum.Font.SourceSansBold
    b.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
    b.TextColor3 = Color3.new(1, 1, 1)
    Instance.new("UICorner", b)
    return b
end

-- 1. انتقال
local TeleportBtn = CreateTargetButton("📍 انتقال فوراً إلى اللاعب")
TeleportBtn.MouseButton1Click:Connect(function()
    if TargetPlayer and TargetPlayer.Character and TargetPlayer.Character:FindFirstChild("HumanoidRootPart") then
        Player.Character.HumanoidRootPart.CFrame = TargetPlayer.Character.HumanoidRootPart.CFrame
    end
end)

-- 2. مشاهدة
local ViewBtn = CreateTargetButton("👁️ مشاهدة / مراقبة الكاميرا (ON/OFF)")
local viewState = false
ViewBtn.MouseButton1Click:Connect(function()
    viewState = not viewState
    ViewBtn.BackgroundColor3 = viewState and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(150, 0, 0)
    if TargetPlayer and TargetPlayer.Character and TargetPlayer.Character:FindFirstChild("Humanoid") then
        workspace.CurrentCamera.CameraSubject = viewState and TargetPlayer.Character.Humanoid or Player.Character.Humanoid
    else
        workspace.CurrentCamera.CameraSubject = Player.Character.Humanoid
        viewState = false
        ViewBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
    end
end)

-- 3. بانق
local BangBtn = CreateTargetButton("🔥 حركة البانق التلقائية (ON/OFF)")
local bangState = false
local bangConnection = nil
BangBtn.MouseButton1Click:Connect(function()
    bangState = not bangState
    BangBtn.BackgroundColor3 = bangState and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(150, 0, 0)
    if bangState then
        local bangCounter = 0
        bangConnection = RunService.Heartbeat:Connect(function()
            if bangState and TargetPlayer and TargetPlayer.Character and TargetPlayer.Character:FindFirstChild("HumanoidRootPart") and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
                bangCounter = bangCounter + 1
                local offset = (bangCounter % 2 == 0) and CFrame.new(0, 0, 0.7) or CFrame.new(0, 0, -0.7)
                Player.Character.HumanoidRootPart.CFrame = TargetPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 1) * offset
            else
                if bangConne
