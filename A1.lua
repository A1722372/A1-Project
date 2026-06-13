-- [[ سكريبت Anxam الأسطوري الكامل والمحدث - الجزء الأول V44.0 ]]
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

-- === زر الإخفاء والظهار الدائري للموبايل ===
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

-- === اللوحة الرئيسية ===
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 520, 0, 320)
MainFrame.Position = UDim2.new(0.5, -260, 0.5, -160)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.Active = true 
MainFrame.Draggable = true
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)

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

-- === القائمة الجانبية ===
local SideMenu = Instance.new("ScrollingFrame", MainFrame)
SideMenu.Size = UDim2.new(0, 140, 1, -20)
SideMenu.Position = UDim2.new(0, 10, 0, 10)
SideMenu.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
SideMenu.BorderSizePixel = 0
SideMenu.ScrollBarThickness = 3
SideMenu.CanvasSize = UDim2.new(0, 0, 0, 280)
Instance.new("UICorner", SideMenu).CornerRadius = UDim.new(0, 8)

local SideLayout = Instance.new("UIListLayout", SideMenu)
SideLayout.Padding = UDim.new(0, 5)
SideLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

-- === منطقة عرض القوائم ===
local ContentArea = Instance.new("Frame", MainFrame)
ContentArea.Size = UDim2.new(1, -170, 1, -20)
ContentArea.Position = UDim2.new(0, 160, 0, 10)
ContentArea.BackgroundTransparency = 1

local MenuConfig = {"اعدادات الماب", "اللاعب", "الاستهداف", "التأثيرات", "المحفوظات", "العسكرية 🎖️"}
local AllPages = {}

for i, name in ipairs(MenuConfig) do
    local btn = Instance.new("TextButton", SideMenu)
    btn.Size = UDim2.new(0.95, 0, 0, 38)
    btn.Text = name
    btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 14
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
            if b:IsA("TextButton") then b.BackgroundColor3 = Color3.fromRGB(45, 45, 45) end
        end
        btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    end)
end

-- ==================== تبويب الماب (كامل الأصلي) ====================
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

-- ==================== تبويب اللاعب (بداية التبويب الكامل الأصلي) ====================
local PlayerPage = AllPages["اللاعب"]
PlayerPage.CanvasSize = UDim2.new(0, 0, 0, 500)

local function CreatePlayerButton(text, onClick)
    local btn = Instance.new("TextButton", PlayerPage)
    btn.Size = UDim2.new(0.95, 0, 0, 40)
    btn.Text = text
    btn.Font = Enum.Font.SourceSansBold
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    btn.MouseButton1Click:Connect(onClick)
    return btn
end

local SpeedContainer = Instance.new("Frame", PlayerPage)
SpeedContainer.Size = UDim2.new(0.95, 0, 0, 40)
SpeedContainer.BackgroundTransparency = 1

local SpeedInput = Instance.new("TextBox", SpeedContainer)
SpeedInput.Size = UDim2.new(0.6, -5, 1, 0)
SpeedInput.PlaceholderText = "قيمة السرعة (مثال: 50)"
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
-- [[ نهاية الجزء الأول - الصق الجزء الثاني تحته مباشرة دون أي تعديل ]]
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

CreatePlayerButton("تفعيل الطيران (Fly V3)", function() 
    loadstring(game:HttpGet("https://raw.githubusercontent.com/XNEOFF/FlyGuiV3/main/FlyGuiV3.txt"))() 
end).BackgroundColor3 = Color3.fromRGB(14, 110, 200)

local GravityBtn = CreatePlayerButton("الجاذبية: طبيعية", function() end)
local LowGrav = false
GravityBtn.MouseButton1Click:Connect(function() 
    LowGrav = not LowGrav
    workspace.Gravity = LowGrav and 35 or 196.2
    GravityBtn.Text = LowGrav and "الجاذبية: منخفضة (قمرية)" or "الجاذبية: طبيعية"
    GravityBtn.BackgroundColor3 = LowGrav and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(45, 45, 45) 
end)

CreatePlayerButton("إعادة رسوَن فوري (Instant Reset)", function() 
    if Player.Character then Player.Character:BreakJoints() end 
end).BackgroundColor3 = Color3.fromRGB(150, 30, 30)

-- ==================== تبويب الاستهداف (كامل الأصلي) ====================
local TargetPage = AllPages["الاستهداف"]
TargetPage.CanvasSize = UDim2.new(0, 0, 0, 350)

local TInput = Instance.new("TextBox", TargetPage)
TInput.Size = UDim2.new(0.95, 0, 0, 40)
TInput.PlaceholderText = "اسم اللاعب (أول 3 حروف)"
TInput.TextColor3 = Color3.new(1,1,1)
TInput.BackgroundColor3 = Color3.fromRGB(40,40,40)
Instance.new("UICorner", TInput)

local TargetPlayer = nil
TInput.FocusLost:Connect(function() 
    for _, plr in pairs(game.Players:GetPlayers()) do 
        if string.sub(string.lower(plr.Name), 1, 3) == string.lower(string.sub(TInput.Text, 1, 3)) then 
            TargetPlayer = plr
            break 
        end 
    end 
end)

local function CreateTargetButton(bName)
    local b = Instance.new("TextButton", TargetPage)
    b.Size = UDim2.new(0.95, 0, 0, 38)
    b.Text = bName .. " (OFF)"
    b.Font = Enum.Font.SourceSansBold
    b.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
    b.TextColor3 = Color3.new(1, 1, 1)
    Instance.new("UICorner", b)
    return b
end

local TeleportBtn = CreateTargetButton("انتقال")
local tpState = false
TeleportBtn.MouseButton1Click:Connect(function()
    tpState = not tpState
    TeleportBtn.Text = "انتقال" .. (tpState and " (ON)" or " (OFF)")
    TeleportBtn.BackgroundColor3 = tpState and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(150, 0, 0)
    if tpState and TargetPlayer and TargetPlayer.Character and TargetPlayer.Character:FindFirstChild("HumanoidRootPart") then
        Player.Character.HumanoidRootPart.CFrame = TargetPlayer.Character.HumanoidRootPart.CFrame
    end
end)

local ViewBtn = CreateTargetButton("استهداف")
local viewState = false
ViewBtn.MouseButton1Click:Connect(function()
    viewState = not viewState
    ViewBtn.Text = "استهداف" .. (viewState and " (ON)" or " (OFF)")
    ViewBtn.BackgroundColor3 = viewState and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(150, 0, 0)
    if TargetPlayer and TargetPlayer.Character and TargetPlayer.Character:FindFirstChild("Humanoid") then
        workspace.CurrentCamera.CameraSubject = viewState and TargetPlayer.Character.Humanoid or Player.Character.Humanoid
    end
end)

local EspBtn = CreateTargetButton("ESP")
local espState = false
EspBtn.MouseButton1Click:Connect(function()
    espState = not espState
    EspBtn.Text = "ESP" .. (espState and " (ON)" or " (OFF)")
    EspBtn.BackgroundColor3 = espState and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(150, 0, 0)
    if TargetPlayer and TargetPlayer.Character then
        if espState and not TargetPlayer.Character:FindFirstChild("Highlight") then
            Instance.new("Highlight", TargetPlayer.Character)
        elseif not espState and TargetPlayer.Character:FindFirstChild("Highlight") then
            TargetPlayer.Character.Highlight:Destroy()
        end
    end
end)

local SitBtn = CreateTargetButton("جلوس فوق")
local sitState = false
SitBtn.MouseButton1Click:Connect(function()
    sitState = not sitState
    SitBtn.Text = "جلوس فوق" .. (sitState and " (ON)" or " (OFF)")
    SitBtn.BackgroundColor3 = sitState and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(150, 0, 0)
    if sitState and TargetPlayer and TargetPlayer.Character and TargetPlayer.Character:FindFirstChild("HumanoidRootPart") then
        Player.Character.HumanoidRootPart.CFrame = TargetPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 3, 0)
    end
end)

-- ==================== تبويب التأثيرات (كامل الأصلي) ====================
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

local ParticleBtn = CreateEffectButton("تأثير الهالة (Particles): مطفأ", function() end)
local ParticleEnabled = false
local currentParticles = nil
ParticleBtn.MouseButton1Click:Connect(function()
    ParticleEnabled = not ParticleEnabled
    ParticleBtn.Text = ParticleEnabled and "تأثير الهالة: شغال" or "تأثير الهالة: مطفأ"
    ParticleBtn.BackgroundColor3 = ParticleEnabled and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(45, 45, 45)
    if ParticleEnabled and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
        currentParticles = Instance.new("ParticleEmitter", Player.Character.HumanoidRootPart)
        currentParticles.Rate = 20
        currentParticles.Speed = NumberRange.new(5)
    elseif not ParticleEnabled and currentParticles then
        currentParticles:Destroy()
    end
end)
-- [[ نهاية الجزء الثاني - الصق الجزء الثالث تحته مباشرة دون أي تعديل ]]
-- ==================== تبويب المحفوظات (كامل الأصلي) ====================
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
        GoBtn.Text = "انتقال إلى: " .. name
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
            if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then 
                Player.Character.HumanoidRootPart.CFrame = pos 
            end 
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

-- ==================== تبويب العسكرية الذكي المخفض 🎖️ ====================
local MilitaryPage = AllPages["العسكرية 🎖️"]
MilitaryPage.CanvasSize = UDim2.new(0, 0, 0, 560)

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

-- بيانات سكنات الأولاد (الاسم المعروض، اسم الحساب)
local BoysSkins = {
    {"سكن سوما الاساسي", "Soooma203040"},
    {" سكن ولد 2", "Ghost_QQQ2"},
    {"سكن ولد 3", "Bogdan33518"},
    {"سكن ولد 4", "BOALAW_4"},
    {"سكن ولد 5", "YYYASSIR"},
    {"سكن ولد 6", "v5li1"},
    {"سكن ولد 7", "xd_ahlas444"},
    {"سكن ولد 8", "BoyName8"},
    {"سكن ولد 9", "BoyName9"},
    {"10 سكن ولد", "BoyName10"}
}

-- بيانات سكنات البنات (الاسم المعروض، اسم الحساب)
local GirlsSkins = {
    {"سكن بنت 1", "GirlName1"},
    {"سكن بنت 2", "GirlName2"},
    {"سكن بنت 3", "GirlName3"},
    {"سكن بنت 4", "GirlName4"},
    {"سكن بنت 5", "GirlName5"},
    {"سكن بنت 6", "GirlName6"},
    {"سكن بنت 7", "GirlName7"},
    {"سكن بنت 8", "GirlName8"},
    {"سكن بنت 9", "GirlName9"},
    {"10 سكن بنت", "GirlName10"}
}

local function BuildSkinSection(titleText, skinsTable)
    local Title = Instance.new("TextLabel", MilitaryPage)
    Title.Size = UDim2.new(0.95, 0, 0, 30)
    Title.Text = "—— " .. titleText .. " ——"
    Title.Font = Enum.Font.SourceSansBold
    Title.TextSize = 14
    Title.TextColor3 = Color3.fromRGB(255, 215, 0)
    Title.BackgroundTransparency = 1

    local Container = Instance.new("Frame", MilitaryPage)
    Container.Size = UDim2.new(0.95, 0, 0, 210)
    Container.BackgroundTransparency = 1

    local Grid = Instance.new("UIGridLayout", Container)
    Grid.CellSize = UDim2.new(0.47, 0, 0, 35)
    Grid.CellPadding = UDim2.new(0.04, 0, 0, 6)
    Grid.HorizontalAlignment = Enum.HorizontalAlignment.Center

    for _, skin in ipairs(skinsTable) do
        local Btn = Instance.new("TextButton", Container)
        Btn.Size = UDim2.new(0.46, 0, 0, 35)
        Btn.Text = skin[1]
        Btn.Font = Enum.Font.SourceSansBold
        Btn.TextSize = 13
        Btn.BackgroundColor3 = Color3.fromRGB(45, 55, 45)
        Btn.TextColor3 = Color3.new(1, 1, 1)
        Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 5)

        Btn.MouseButton1Click:Connect(function()
            ChangeSkin(skin[2])
        end)
    end
end

-- بناء الأقسام كاملة ومضمونة داخل التبويب
BuildSkinSection("سكنات أولاد", BoysSkins)
BuildSkinSection("سكنات بنات", GirlsSkins)
