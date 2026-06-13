-- [[ سكريبت Anxam المطور لفك قفل حماية رايفن - الحزب الأول V65.0 ]]
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
-- ==================== تبويب اللاعب (تخطي حماية رايفن) ====================
local PlayerPage = AllPages["اللاعب"]
PlayerPage.CanvasSize = UDim2.new(0, 0, 0, 550)

-- متغير عالمي للتحكم بوضع التخطي عبر السكريبت
getgenv().RavenBypassActive = false
local FakeBypassSeat = nil

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

-- 🔥 زر الابتكار المخصص لفك قفل سرعة وحماية ماب رايفن العسكرية 🔥
local BypassBtn = CreatePlayerButton("🔓 فك قفل السرعة والحماية (Raven Bypass)", function() end)
BypassBtn.BackgroundColor3 = Color3.fromRGB(180, 80, 0)

BypassBtn.MouseButton1Click:Connect(function()
    getgenv().RavenBypassActive = not getgenv().RavenBypassActive
    BypassBtn.Text = getgenv().RavenBypassActive and "🔓 فك القفل: شـغـال (مخفي عن الحماية)" or "🔓 فك قفل السرعة والحماية (Raven Bypass)"
    BypassBtn.BackgroundColor3 = getgenv().RavenBypassActive and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(180, 80, 0)
    
    if getgenv().RavenBypassActive and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
        -- عزل الجسد محلياً لمنع الحماية من تتبع السرعة الزائدة
        FakeBypassSeat = Instance.new("Seat", workspace)
        FakeBypassSeat.Size = Vector3.new(2, 0.5, 2)
        FakeBypassSeat.CFrame = Player.Character.HumanoidRootPart.CFrame * CFrame.new(0, -30, 0)
        FakeBypassSeat.Transparency = 1
        FakeBypassSeat.Anchored = true
        FakeBypassSeat:Sit(Player.Character.Humanoid)
    else
        if FakeBypassSeat then FakeBypassSeat:Destroy() FakeBypassSeat = nil end
        if Player.Character and Player.Character:FindFirstChild("Humanoid") then
            Player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
        end
    end
end)

-- خانة التحكم بالسرعة
local SpeedContainer = Instance.new("Frame", PlayerPage)
SpeedContainer.Size = UDim2.new(0.95, 0, 0, 40)
SpeedContainer.BackgroundTransparency = 1

local SpeedInput = Instance.new("TextBox", SpeedContainer)
SpeedInput.Size = UDim2.new(0.6, -5, 1, 0)
SpeedInput.PlaceholderText = "قيمة السرعة (مثال: 200)"
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
        -- إذا حماية رايفن شغالة، يتم كسر الحد الأقصى يدوياً أثناء التخطي
        Player.Character.Humanoid.WalkSpeed = tonumber(SpeedInput.Text) or 16 
    end 
end)

-- خانة التحكم بالنط
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

local AntiSitBtn = CreateSuperButton("مضاد السقوط والجلوس: شغال")
AntiSitBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
local AntiSitEnabled = true
AntiSitBtn.MouseButton1Click:Connect(function()
    AntiSitEnabled = not AntiSitEnabled
    AntiSitBtn.Text = AntiSitEnabled and "مضاد السقوط والجلوس: شغال" or "مضاد السقوط والجلوس: مطفأ"
    AntiSitBtn.BackgroundColor3 = AntiSitEnabled and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(45, 45, 45)
end)
RunService.Heartbeat:Connect(function() if AntiSitEnabled and Player.Character and Player.Character:FindFirstChild("Humanoid") and not getgenv().RavenBypassActive then Player.Character.Humanoid.Sit = false end end)
-- [[ نهاية الحزب الثاني ]]
-- ==================== تبويب الاستهداف المطور بتخطي الحماية ====================
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

-- دالة محلية مبتكرة للانتقال الآمن والخاطف وتخطي حماية رايفن العسكرية
local function SafeTeleport(targetCFrame)
    if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
        local hrp = Player.Character.HumanoidRootPart
        local hum = Player.Character.Humanoid
        
        -- تفعيل وضع التخطي الخاطف لأجزاء من الثانية لكسر مراقبة السيرفر
        local tempSeat = Instance.new("Seat", workspace)
        tempSeat.Size = Vector3.new(1, 0.5, 1)
        tempSeat.CFrame = targetCFrame
        tempSeat.Transparency = 1
        tempSeat.Anchored = true
        
        hrp.CFrame = targetCFrame
        task.wait(0.05)
        tempSeat:Sit(hum)
        task.wait(0.1)
        tempSeat:Destroy()
        hum:ChangeState(Enum.HumanoidStateType.GettingUp)
    end
end

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

-- 1. انتقال آمن بتخطي رايفن
local TeleportBtn = CreateTargetButton("📍 انتقال ذكي (تخطي حماية رايفن)")
TeleportBtn.MouseButton1Click:Connect(function()
    if TargetPlayer and TargetPlayer.Character and TargetPlayer.Character:FindFirstChild("HumanoidRootPart") then
        SafeTeleport(TargetPlayer.Character.HumanoidRootPart.CFrame)
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
                if bangConnection then bangConnection:Disconnect() end
            end
        end)
    else
        if bangConnection then bangConnection:Disconnect() bangConnection = nil end
    end
end)

-- 4. بانق عكسي
local RevBangBtn = CreateTargetButton("🔄 حركة بانق عكسي (سحب اللاعب إليك)")
local revBangState = false
local revBangConnection = nil
RevBangBtn.MouseButton1Click:Connect(function()
    revBangState = not revBangState
    RevBangBtn.BackgroundColor3 = revBangState and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(150, 0, 0)
    if revBangState then
        local cbCounter = 0
        revBangConnection = RunService.Heartbeat:Connect(function()
            if revBangState and TargetPlayer and TargetPlayer.Character and TargetPlayer.Character:FindFirstChild("HumanoidRootPart") and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
                cbCounter = cbCounter + 1
                local offset = (cbCounter % 2 == 0) and CFrame.new(0, 0, 0.7) or CFrame.new(0, 0, -0.7)
                TargetPlayer.Character.HumanoidRootPart.CFrame = Player.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -1) * offset
            else
                if revBangConnection then revBangConnection:Disconnect() end
            end
        end)
    else
        if revBangConnection then revBangConnection:Disconnect() revBangConnection = nil end
    end
end)

-- 5. سوهّـا عليه (Fling مطور بالفيزكس)
local FlingBtn = CreateTargetButton("🌪️ سوهّـا عليه (تطيير وفلنق المستهدف)")
local flingState = false
local flingConnection = nil
FlingBtn.MouseButton1Click:Connect(function()
    flingState = not flingState
    FlingBtn.BackgroundColor3 = flingState and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(150, 0, 0)
    if flingState then
        flingConnection = RunService.Heartbeat:Connect(function()
            if flingState and TargetPlayer and TargetPlayer.Character and TargetPlayer.Character:FindFirstChild("HumanoidRootPart") and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
                Player.Character.HumanoidRootPart.CFrame = TargetPlayer.Character.HumanoidRootPart.CFrame * CFrame.Angles(0, math.rad(tick()*1500)%360, 0) * CFrame.new(0, 0, 0.2)
                Player.Character.HumanoidRootPart.Velocity = Vector3.new(500, 500, 500)
            else
                if flingConnection then flingConnection:Disconnect() end
            end
        end)
    else
        if flingConnection then 
            flingConnection:Disconnect() 
            flingConnection = nil 
            Player.Character.HumanoidRootPart.Velocity = Vector3.new(0,0,0)
        end
    end
end)

-- 6. ضرب مؤخرة (التصاق وملاحقة خلفية)
local BehindBtn = CreateTargetButton("🍑 ضرب مؤخرة (التصاق وملاحقة خلفية)")
local behindState = false
local behindConnection = nil
BehindBtn.MouseButton1Click:Connect(function()
    behindState = not behindState
    BehindBtn.BackgroundColor3 = behindState and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(150, 0, 0)
    if behindState then
        behindConnection = RunService.Heartbeat:Connect(function()
            if behindState and TargetPlayer and TargetPlayer.Character and TargetPlayer.Character:FindFirstChild("HumanoidRootPart") and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
                Player.Character.HumanoidRootPart.CFrame = TargetPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 1.2)
            else
                if behindConnection then behindConnection:Disconnect() end
            end
        end)
    else
        if behindConnection then behindConnection:Disconnect() behindConnection = nil end
    end
end)

-- 7. جلوس في راسه
local SitHeadBtn = CreateTargetButton("🏇 جلوس في راسه (ركوب فوق رأسه)")
SitHeadBtn.MouseButton1Click:Connect(function()
    if TargetPlayer and TargetPlayer.Character and TargetPlayer.Character:FindFirstChild("HumanoidRootPart") then
        Player.Character.HumanoidRootPart.CFrame = TargetPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 3, 0)
    end
end)

-- 8. تقليد الكلام التلقائي (Chat Mimic مقتبس ذكي)
local MimicBtn = CreateTargetButton("🗣️ تقليد الكلام التلقائي (تكرار كلامه بالشات)")
local mimicState = false
local mimicConnection = nil
MimicBtn.MouseButton1Click:Connect(function()
    mimicState = not mimicState
    MimicBtn.BackgroundColor3 = mimicState and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(150, 0, 0)
    if mimicState and TargetPlayer then
        mimicConnection = TargetPlayer.Chatted:Connect(function(msg)
            if mimicState then
                local chatEvents = game:GetService("ReplicatedStorage"):FindFirstChild("DefaultChatSystemChatEvents")
                if chatEvents and chatEvents:FindFirstChild("SayMessageRequest") then
                    chatEvents.SayMessageRequest:FireServer(msg, "All")
                else
                    local textChatService = game:GetService("TextChatService")
                    if textChatService and textChatService.ChatInputBarConfiguration and textChatService.ChatInputBarConfiguration.TargetTextChannel then
                        textChatService.ChatInputBarConfiguration.TargetTextChannel:SendAsync(msg)
                    end
                end
            end
        end)
    else
        if mimicConnection then mimicConnection:Disconnect() mimicConnection = nil end
    end
end)

-- ==================== تبويب التأثيرات ====================
local EffectsPage = AllPages["التأثيرات"]
EffectsPage.CanvasSize = UDim2.new(0, 0, 0, 300)

local function CreateEffectButton(text, onClick)
    local btn = Instance.new("TextButton", EffectsPage)
    btn.Size = UDim2.new(0.95, 0, 0, 40)
    btn.Text = text
    btn.Font = Enum.Font.SourceSansBold
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    btn.MouseButton1Click:Connect(onClick)
    return btn
end

local TrailBtn = CreateEffectButton("تأثير الذيل (Trail): مطفأ", function() end)
local TrailEnabled = false
local currentTrail = nil
TrailBtn.MouseButton1Click:Connect(function()
    TrailEnabled = not TrailEnabled
    TrailBtn.Text = TrailEnabled and "تأثير الذيل: شغال" or "تأثير الذيل: مطفأ"
    TrailBtn.BackgroundColor3 = TrailEnabled and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(45, 45, 45)
    if TrailEnabled and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
        currentTrail = Instance.new("Trail", Player.Character.HumanoidRootPart)
        currentTrail.Color = ColorSequence.new(Color3.fromRGB(255, 0, 0), Color3.fromRGB(0, 0, 255))
        local a0 = Instance.new("Attachment", Player.Character.HumanoidRootPart)
        a0.Position = Vector3.new(0, 1, 0)
        local a1 = Instance.new("Attachment", Player.Character.HumanoidRootPart)
        a1.Position = Vector3.new(0, -1, 0)
        currentTrail.Attachment0 = a0
        currentTrail.Attachment1 = a1
    elseif not TrailEnabled and currentTrail then
        currentTrail:Destroy()
    end
end)

-- ==================== تبويب المحفوظات المطور بالتخطي ====================
local SavePage = AllPages["المحفوظات"]
SavePage.CanvasSize = UDim2.new(0, 0, 0, 300)

local SaveContainer = Instance.new("Frame", SavePage)
SaveContainer.Size = UDim2.new(0.95, 0, 0, 40)
SaveContainer.BackgroundTransparency = 1

local SaveInput = Instance.new("TextBox", SaveContainer)
SaveInput.Size = UDim2.new(0.7, -5, 1, 0)
SaveInput.PlaceholderText = "اسم المكان لحفظه"
SaveInput.TextColor3 = Color3.new(1,1,1)
SaveInput.BackgroundColor3 = Color3.fromRGB(40,40,40)
Instance.new("UICorner", SaveInput)

local SaveBtn = Instance.new("TextButton", SaveContainer)
SaveBtn.Size = UDim2.new(0.3, 0, 1, 0)
SaveBtn.Position = UDim2.new(0.7, 5, 0, 0)
SaveBtn.Text = "حفظ الموقع"
SaveBtn.Font = Enum.Font.SourceSansBold
SaveBtn.BackgroundColor3 = Color3.fromRGB(0, 130, 0)
SaveBtn.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", SaveBtn)

local ListArea = Instance.new("Frame", SavePage)
ListArea.Size = UDim2.new(1, 0, 1, -50)
ListArea.BackgroundTransparency = 1
local ListLayout = Instance.new("UIListLayout", ListArea)
ListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
ListLayout.Padding = UDim.new(0, 5)

local function RefreshSaves()
    for _, child in pairs(ListArea:GetChildren()) do if child:IsA("Frame") then child:Destroy() end end
    for name, pos in pairs(getgenv().AihamSavedPositions) do
        local Container = Instance.new("Frame", ListArea)
        Container.Size = UDim2.new(0.95, 0, 0, 35)
        Container.BackgroundTransparency = 1
        
        local GoBtn = Instance.new("TextButton", Container)
        GoBtn.Size = UDim2.new(0.8, -5, 1, 0)
        GoBtn.Text = "انتقال آمن إلى: " .. name
        GoBtn.Font = Enum.Font.SourceSansBold
        GoBtn.BackgroundColor3 = Color3.fromRGB(60,60,60)
        GoBtn.TextColor3 = Color3.new(1,1,1)
        Instance.new("UICorner", GoBtn)
        
        local DelBtn = Instance.new("TextButton", Container)
        DelBtn.Size = UDim2.new(0.2, 0, 1, 0)
        DelBtn.Position = UDim2.new(0.8, 5, 0, 0)
        DelBtn.Text = "X"
        DelBtn.Font = Enum.Font.SourceSansBold
        DelBtn.BackgroundColor3 = Color3.fromRGB(150,0,0)
        DelBtn.TextColor3 = Color3.new(1,1,1)
        Instance.new("UICorner", DelBtn)
        
        GoBtn.MouseButton1Click:Connect(function() 
            SafeTeleport(pos) -- استخدام دالة التخطي عند الانتقال للشيك بوينت المحفوظة
        end)
        
        DelBtn.MouseButton1Click:Connect(function() 
            getgenv().AihamSavedPositions[name] = nil 
            RefreshSaves() 
        end)
    end
end

SaveBtn.MouseButton1Click:Connect(function() 
    if SaveInput.Text ~= "" and Player.Character:FindFirstChild("HumanoidRootPart") then 
        getgenv().AihamSavedPositions[SaveInput.Text] = Player.Character.HumanoidRootPart.CFrame 
        RefreshSaves() 
        SaveInput.Text = "" 
    end 
end)
RefreshSaves()

-- ==================== تبويب العسكرية الكبرى 🎖️ ====================
local MilitaryPage = AllPages["العسكرية 🎖️"]
MilitaryPage.CanvasSize = UDim2.new(0, 0, 0, 520)

local function ChangeSkin(username)
    local chatEvents = game:GetService("ReplicatedStorage"):FindFirstChild("DefaultChatSystemChatEvents")
    if chatEvents and chatEvents:FindFirstChild("SayMessageRequest") then
        chatEvents.SayMessageRequest:FireServer("/char me " .. username, "All")
    else
        local textChatService = game:GetService("TextChatService")
        if textChatService and textChatService.ChatInputBarConfiguration and textChatService.ChatInputBarConfiguration.TargetTextChannel then
            textChatService.ChatInputBarConfiguration.TargetTextChannel:SendAsync("/char me " .. username)
        end
    end
end

local BoysSkins = {
    {"سكن سوما الاساسي", "Soooma203040"},
    {" سكن ولد 2", "Ghost_QQQ2"},
    {"سكن ولد 3", "Bogdan33518"},
    {"سكن ولد 4", "BOALAW_4"},
    {"سكن ولد 5", "YYYASSIR"},
    {"سكن ولد 6", "v5li1"},
    {"سكن ولد 7", "xd_ahlas444"},
    {"8 سكن ولد", "abod_1369"},
    {"سكن ولد 9", "yazanahmad1113"},
    {"10 سكن ولد", "KUNag08"}
}

local GirlsSkins = {
    {"سكن بنت 1", "just_ayla14"},
    {"سكن بنت 2", "iren_0o"},
    {"سكن بنت 3", "GirlSkin3"}
}

local function BuildSkinSection(titleText, skinsTable)
    local Title = Instance.new("TextLabel", MilitaryPage)
    Title.Size = UDim2.new(0.95, 0, 0, 30)
    Title.Text = titleText
    Title.Font = Enum.Font.SourceSansBold
    Title.TextSize = 15
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.BackgroundTransparency = 1
    
    local Container = Instance.new("Frame", MilitaryPage)
    local rows = math.ceil(#skinsTable / 2)
    Container.Size = UDim2.new(0.95, 0, 0, rows * 44)
    Container.BackgroundTransparency = 1
    
    local Grid = Instance.new("UIGridLayout", Container)
    Grid.CellSize = UDim2.new(0.47, 0, 0, 36)
    Grid.CellPadding = UDim2.new(0.04, 0, 0, 8)
    Grid.HorizontalAlignment = Enum.HorizontalAlignment.Center
    
    for _, skin in ipairs(skinsTable) do
        local Btn = Instance.new("TextButton", Container)
        Btn.Size = UDim2.new(0.46, 0, 0, 36)
        Btn.Text = skin[1]
        Btn.Font = Enum.Font.SourceSansBold
        Btn.TextSize = 13
        Btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
        Btn.TextColor3 = Color3.new(1, 1, 1)
        Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 6)
        Btn.MouseButton1Click:Connect(function() ChangeSkin(skin[2]) end)
    end
end

BuildSkinSection("سكنات أولاد", BoysSkins)
BuildSkinSection("سكنات بنات", GirlsSkins)
-- [[ نهاية السكريبت المتكامل بنجاح ]]
