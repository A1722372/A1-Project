-- [[ سكريبت Anxam الأسطوري - نسخة معالجة ومفككة بالكامل لـ Delta ]]
local Player = game.Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")
local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")

-- === [قسم إحداثيات المواقع الثلاثة لتسليم الصناديق] ===
local MilitaryPositions = {
    Location1 = CFrame.new(250, 10, -150), 
    Location2 = CFrame.new(-300, 10, 400), 
    Location3 = CFrame.new(500, 10, 50),   
}

if not getgenv().AihamSavedPositions then 
    getgenv().AihamSavedPositions = {} 
end

if PlayerGui:FindFirstChild("AihamScript_Main") then 
    PlayerGui.AihamScript_Main:Destroy() 
end

local ScreenGui = Instance.new("ScreenGui", PlayerGui)
ScreenGui.Name = "AihamScript_Main"
ScreenGui.ResetOnSpawn = false
ScreenGui.DisplayOrder = 2147483647 

-- === دالة السحب المخصصة للجوال ===
local function makeElementDraggable(frame)
    local dragging, dragInput, dragStart, startPos
    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then 
                    dragging = false 
                end
            end)
        end
    end)
    frame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    UIS.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

-- زر التفعيل
local ToggleBtn = Instance.new("TextButton", ScreenGui)
ToggleBtn.Name = "ToggleBtn"
ToggleBtn.Size = UDim2.new(0, 50, 0, 50)
ToggleBtn.Position = UDim2.new(0.9, -60, 0.1, 0)
ToggleBtn.Text = "⚫" 
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 0)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
ToggleBtn.TextSize = 30
ToggleBtn.ZIndex = 100
Instance.new("UICorner", ToggleBtn)
makeElementDraggable(ToggleBtn)

-- القائمة الرئيسية
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 420, 0, 390) 
MainFrame.Position = UDim2.new(0.5, -210, 0.5, -195)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.Active = true 
Instance.new("UICorner", MainFrame)
makeElementDraggable(MainFrame)

local MenuConfig = {"اعدادات الماب", "اللاعب", "الاستهداف", "التأثيرات", "المحفوظات", "العسكرية 🎖️"}
local SideMenu = Instance.new("ScrollingFrame", MainFrame)
SideMenu.Size = UDim2.new(0, 120, 1, 0)
SideMenu.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Instance.new("UICorner", SideMenu)

local ContentArea = Instance.new("Frame", MainFrame)
ContentArea.Size = UDim2.new(1, -120, 1, 0)
ContentArea.Position = UDim2.new(0, 120, 0, 0)
ContentArea.BackgroundTransparency = 1

local AllPages = {}
for i, name in ipairs(MenuConfig) do
    local btn = Instance.new("TextButton", SideMenu)
    btn.Size = UDim2.new(0.9, 0, 0, 40)
    btn.Position = UDim2.new(0.05, 0, 0, (i-1) * 45 + 5)
    btn.Text = name
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    btn.TextColor3 = Color3.new(1, 1, 1)
    Instance.new("UICorner", btn)
    
    local page = Instance.new("ScrollingFrame", ContentArea)
    page.Size = UDim2.new(1, 0, 1, 0)
    page.BackgroundTransparency = 1
    page.Visible = (i == 1)
    AllPages[name] = page
    
    btn.MouseButton1Click:Connect(function()
        for _, p in pairs(AllPages) do 
            p.Visible = false 
        end
        page.Visible = true
    end)
end

-- ==================== إعدادات الماب ====================
local MapPage = AllPages["اعدادات الماب"]
MapPage.CanvasSize = UDim2.new(0, 0, 0, 430)

local FBButton = Instance.new("TextButton", MapPage)
FBButton.Size = UDim2.new(0.9, 0, 0, 40)
FBButton.Position = UDim2.new(0.05, 0, 0, 10)
FBButton.Text = "السطوع: مطفأ"
FBButton.Font = Enum.Font.SourceSansBold
FBButton.TextSize = 16
FBButton.TextColor3 = Color3.new(1, 1, 1)
FBButton.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
Instance.new("UICorner", FBButton)

local FBEnabled = false
FBButton.MouseButton1Click:Connect(function()
    FBEnabled = not FBEnabled
    Lighting.Ambient = FBEnabled and Color3.new(1,1,1) or Color3.new(0,0,0)
    FBButton.Text = FBEnabled and "السطوع: شغال" or "السطوع: مطفأ"
    FBButton.BackgroundColor3 = FBEnabled and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(150, 0, 0)
end)

local ShaderBtn = Instance.new("TextButton", MapPage)
ShaderBtn.Size = UDim2.new(0.9, 0, 0, 40)
ShaderBtn.Position = UDim2.new(0.05, 0, 0, 60)
ShaderBtn.Text = "الشادر: مطفأ"
ShaderBtn.Font = Enum.Font.SourceSansBold
ShaderBtn.TextSize = 16
ShaderBtn.TextColor3 = Color3.new(1, 1, 1)
ShaderBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
Instance.new("UICorner", ShaderBtn)

local ShaderEnabled = false
ShaderBtn.MouseButton1Click:Connect(function()
    ShaderEnabled = not ShaderEnabled
    Lighting.Brightness = ShaderEnabled and 3 or 2
    Lighting.ClockTime = ShaderEnabled and 12 or 14
    ShaderBtn.Text = ShaderEnabled and "الشادر: شغال" or "الشادر: مطفأ"
    ShaderBtn.BackgroundColor3 = ShaderEnabled and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(150, 0, 0)
end)

local ThemeBtn = Instance.new("TextButton", MapPage)
ThemeBtn.Size = UDim2.new(0.9, 0, 0, 40)
ThemeBtn.Position = UDim2.new(0.05, 0, 0, 110)
ThemeBtn.Text = "اللون: أسود"
ThemeBtn.Font = Enum.Font.SourceSansBold
ThemeBtn.TextSize = 16
ThemeBtn.TextColor3 = Color3.new(1, 1, 1)
ThemeBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
Instance.new("UICorner", ThemeBtn)

local Themes = {
    {Name = "أسود", Color = Color3.fromRGB(20, 20, 20)},
    {Name = "أبيض", Color = Color3.fromRGB(200, 200, 200)},
    {Name = "أزرق", Color = Color3.fromRGB(0, 50, 100)},
    {Name = "رينبو", Color = "Rainbow"}
}
local currentTheme = 1
ThemeBtn.MouseButton1Click:Connect(function()
    currentTheme = currentTheme % #Themes + 1
    local choice = Themes[currentTheme]
    ThemeBtn.Text = "اللون: " .. choice.Name
    if choice.Color == "Rainbow" then
        task.spawn(function()
            while choice.Color == "Rainbow" and ThemeBtn.Text == "اللون: رينبو" do
                local c = Color3.fromHSV(tick() % 5 / 5, 1, 1)
                MainFrame.BackgroundColor3 = c
                SideMenu.BackgroundColor3 = Color3.new(c.r*0.5, c.g*0.5, c.b*0.5)
                task.wait(0.1)
            end
        end)
    else
        MainFrame.BackgroundColor3 = choice.Color
        SideMenu.BackgroundColor3 = Color3.new(choice.Color.r*0.5, choice.Color.g*0.5, choice.Color.b*0.5)
    end
end)

local DiscordBtn = Instance.new("TextButton", MapPage)
DiscordBtn.Size = UDim2.new(0.9, 0, 0, 40)
DiscordBtn.Position = UDim2.new(0.05, 0, 0, 160)
DiscordBtn.Text = "نسخ سيرفر الديسكورد"
DiscordBtn.Font = Enum.Font.SourceSansBold
DiscordBtn.TextSize = 16
DiscordBtn.TextColor3 = Color3.new(1, 1, 1)
DiscordBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
Instance.new("UICorner", DiscordBtn)
DiscordBtn.MouseButton1Click:Connect(function() 
    if setclipboard then 
        setclipboard("https://discord.gg/WrxQZDVps") 
    end 
end)

local InfoBox = Instance.new("Frame", MapPage)
InfoBox.Size = UDim2.new(0.9, 0, 0, 180)
InfoBox.Position = UDim2.new(0.05, 0, 0, 215)
InfoBox.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Instance.new("UICorner", InfoBox)

local CreditsLabel = Instance.new("TextLabel", InfoBox)
CreditsLabel.Size = UDim2.new(1, 0, 0, 25)
CreditsLabel.Position = UDim2.new(0, 0, 0, 5)
CreditsLabel.Text = "تم صناعة هذا السكربت بواسطة anxam"
CreditsLabel.Font = Enum.Font.SourceSansBold
CreditsLabel.TextSize = 15
CreditsLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
CreditsLabel.BackgroundTransparency = 1

local DevLabel = Instance.new("TextLabel", InfoBox)
DevLabel.Size = UDim2.new(1, 0, 0, 20)
DevLabel.Position = UDim2.new(0, 0, 0, 25)
DevLabel.Text = "Developers: Anxam, Osama & User"
DevLabel.Font = Enum.Font.SourceSansItalic
DevLabel.TextSize = 14
DevLabel.TextColor3 = Color3.fromRGB(0, 180, 255)
DevLabel.BackgroundTransparency = 1

local Img1 = Instance.new("ImageLabel", InfoBox)
Img1.Size = UDim2.new(0, 50, 0, 50)
Img1.Position = UDim2.new(0.15, -25, 0, 60)
Img1.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
Img1.Image = "rbxassetid://81945110813195"
Instance.new("UICorner", Img1).CornerRadius = UDim.new(0, 8)

local Img2 = Instance.new("ImageLabel", InfoBox)
Img2.Size = UDim2.new(0, 50, 0, 50)
Img2.Position = UDim2.new(0.5, -25, 0, 60)
Img2.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
Img2.Image = "rbxassetid://124623074543613"
Instance.new("UICorner", Img2).CornerRadius = UDim.new(0, 8)

local Img3 = Instance.new("ImageLabel", InfoBox)
Img3.Size = UDim2.new(0, 50, 0, 50)
Img3.Position = UDim2.new(0.85, -25, 0, 60)
Img3.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
Img3.Image = "rbxassetid://90056440530951"
Instance.new("UICorner", Img3).CornerRadius = UDim.new(0, 8)

local ScriptUsersLabel = Instance.new("TextLabel", InfoBox)
ScriptUsersLabel.Size = UDim2.new(1, 0, 0, 25)
ScriptUsersLabel.Position = UDim2.new(0, 0, 1, -30)
ScriptUsersLabel.Font = Enum.Font.SourceSansBold
ScriptUsersLabel.TextSize = 14
ScriptUsersLabel.TextColor3 = Color3.fromRGB(0, 255, 100)
ScriptUsersLabel.BackgroundTransparency = 1

local function UpdateScriptUsers()
    local activeCount = 0
    for _, p in pairs(game.Players:GetPlayers()) do
        if p:FindFirstChild("Using_AihamScript") then
            activeCount = activeCount + 1
        end
    end
    ScriptUsersLabel.Text = "مستخدمي السكريبت النشطين حالياً: " .. tostring(activeCount)
end

local tag = Player:FindFirstChild("Using_AihamScript") or Instance.new("StringValue", Player)
tag.Name = "Using_AihamScript"

task.spawn(function()
    while task.wait(1) do
        UpdateScriptUsers()
    end
end)

-- ==================== تبويب العسكرية 🎖️ ====================
local MilitaryPage = AllPages["العسكرية 🎖️"]
MilitaryPage.CanvasSize = UDim2.new(0, 0, 0, 260)

local function TeleportToLocation(targetCFrame)
    if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
        Player.Character.HumanoidRootPart.CFrame = targetCFrame
    end
end

local MilBtn1 = Instance.new("TextButton", MilitaryPage)
MilBtn1.Size = UDim2.new(0.9, 0, 0, 40)
MilBtn1.Position = UDim2.new(0.05, 0, 0, 10)
MilBtn1.Text = "انتقال تلقائي للصندوق 📦"
MilBtn1.Font = Enum.Font.SourceSansBold
MilBtn1.TextSize = 15
MilBtn1.TextColor3 = Color3.new(1, 1, 1)
MilBtn1.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
Instance.new("UICorner", MilBtn1)

MilBtn1.MouseButton1Click:Connect(function()
    local char = Player.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    local targetChest = workspace:FindFirstChild("TakeChest", true)
    
    if hrp and targetChest then
        hrp.CFrame = targetChest:GetPivot() * CFrame.new(0, 0, 2)
        task.spawn(function()
            while true do
                if not Player.Character or not Player.Character:FindFirstChild("HumanoidRootPart") then break end
                local currentHrp = Player.Character.HumanoidRootPart
                local dist = (currentHrp.Position - targetChest:GetPivot().Position).Magnitude
                if dist > 10 then break end 
                
                local prompt = targetChest:FindFirstChildWhichIsA("ProximityPrompt", true)
                if prompt then 
                    fireproximityprompt(prompt) 
                end
                task.wait(0.1)
            end
        end)
    end
end)

local MilBtn2 = Instance.new("TextButton", MilitaryPage)
MilBtn2.Size = UDim2.new(0.9, 0, 0, 40)
MilBtn2.Position = UDim2.new(0.05, 0, 0, 60)
MilBtn2.Text = "انتقال إلى الموقع [1]📍"
MilBtn2.Font = Enum.Font.SourceSansBold
MilBtn2.TextSize = 15
MilBtn2.TextColor3 = Color3.new(1, 1, 1)
MilBtn2.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Instance.new("UICorner", MilBtn2)
MilBtn2.MouseButton1Click:Connect(function() 
    TeleportToLocation(MilitaryPositions.Location1) 
end)

local MilBtn3 = Instance.new("TextButton", MilitaryPage)
MilBtn3.Size = UDim2.new(0.9, 0, 0, 40)
MilBtn3.Position = UDim2.new(0.05, 0, 0, 110)
MilBtn3.Text = "انتقال إلى الموقع [2]📍"
MilBtn3.Font = Enum.Font.SourceSansBold
MilBtn3.TextSize = 15
MilBtn3.TextColor3 = Color3.new(1, 1, 1)
MilBtn3.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Instance.new("UICorner", MilBtn3)
MilBtn3.MouseButton1Click:Connect(function() 
    TeleportToLocation(MilitaryPositions.Location2) 
end)

local MilBtn4 = Instance.new("TextButton", MilitaryPage)
MilBtn4.Size = UDim2.new(0.9, 0, 0, 40)
MilBtn4.Position = UDim2.new(0.05, 0, 0, 160)
MilBtn4.Text = "انتقال إلى الموقع [3]📍"
MilBtn4.Font = Enum.Font.SourceSansBold
MilBtn4.TextSize = 15
MilBtn4.TextColor3 = Color3.new(1, 1, 1)
MilBtn4.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Instance.new("UICorner", MilBtn4)
MilBtn4.MouseButton1Click:Connect(function() 
    TeleportToLocation(MilitaryPositions.Location3) 
end)

-- ==================== تبويب اللاعب ====================
local PlayerPage = AllPages["اللاعب"]

local FlyV3Btn = Instance.new("TextButton", PlayerPage)
FlyV3Btn.Size = UDim2.new(0.9, 0, 0, 40)
FlyV3Btn.Position = UDim2.new(0.05, 0, 0, 210)
FlyV3Btn.Text = "تفعيل الطيران (Fly V3)"
FlyV3Btn.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
FlyV3Btn.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", FlyV3Btn)

FlyV3Btn.MouseButton1Click:Connect(function() 
    loadstring(game:HttpGet("https://raw.githubusercontent.com/XNEOFF/FlyGuiV3/main/FlyGuiV3.txt"))() 
end)

local SpeedInput = Instance.new("TextBox", PlayerPage)
SpeedInput.Size = UDim2.new(0.5, 0, 0, 40)
SpeedInput.Position = UDim2.new(0.05, 0, 0, 10)
SpeedInput.PlaceholderText = "السرعة"
SpeedInput.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", SpeedInput)

local SpeedBtn = Instance.new("TextButton", PlayerPage)
SpeedBtn.Size = UDim2.new(0.35, 0, 0, 40)
SpeedBtn.Position = UDim2.new(0.6, 0, 0, 10)
SpeedBtn.Text = "تفعيل"
SpeedBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
Instance.new("UICorner", SpeedBtn)

local SpeedEnabled = false
SpeedBtn.MouseButton1Click:Connect(function() 
    SpeedEnabled = not SpeedEnabled
    SpeedBtn.Text = SpeedEnabled and "مفعل" or "تفعيل"
    SpeedBtn.BackgroundColor3 = SpeedEnabled and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(150, 0, 0) 
end)

RunService.Heartbeat:Connect(function() 
    if SpeedEnabled and Player.Character and Player.Character:FindFirstChild("Humanoid") then 
        Player.Character.Humanoid.WalkSpeed = tonumber(SpeedInput.Text) or 16 
    end 
end)

local JumpInput = Instance.new("TextBox", PlayerPage)
JumpInput.Size = UDim2.new(0.5, 0, 0, 40)
JumpInput.Position = UDim2.new(0.05, 0, 0, 60)
JumpInput.PlaceholderText = "قوة القفز"
JumpInput.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", JumpInput)

local JumpBtn = Instance.new("TextButton", PlayerPage)
JumpBtn.Size = UDim2.new(0.35, 0, 0, 40)
JumpBtn.Position = UDim2.new(0.6, 0, 0, 60)
JumpBtn.Text = "تفعيل"
JumpBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
Instance.new("UICorner", JumpBtn)

local JumpEnabledInput = false
JumpBtn.MouseButton1Click:Connect(function() 
    JumpEnabledInput = not JumpEnabledInput
    JumpBtn.Text = JumpEnabledInput and "مفعل" or "تفعيل"
    JumpBtn.BackgroundColor3 = JumpEnabledInput and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(150, 0, 0) 
end)

RunService.Heartbeat:Connect(function() 
    if JumpEnabledInput and Player.Character and Player.Character:FindFirstChild("Humanoid") then 
        Player.Character.Humanoid.UseJumpPower = true
        Player.Character.Humanoid.JumpPower = tonumber(JumpInput.Text) or 50 
    end 
end)

local InfJumpBtn = Instance.new("TextButton", PlayerPage)
InfJumpBtn.Size = UDim2.new(0.9, 0, 0, 40)
InfJumpBtn.Position = UDim2.new(0.05, 0, 0, 110)
InfJumpBtn.Text = "قفز لا نهائي"
InfJumpBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
Instance.new("UICorner", InfJumpBtn)

local JumpEnabled = false
InfJumpBtn.MouseButton1Click:Connect(function() 
    JumpEnabled = not JumpEnabled
    InfJumpBtn.BackgroundColor3 = JumpEnabled and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(80, 80, 80) 
end)

UIS.JumpRequest:Connect(function() 
    if JumpEnabled then 
        Player.Character.Humanoid:ChangeState("Jumping") 
    end 
end)

local NoclipBtn = Instance.new("TextButton", PlayerPage)
NoclipBtn.Size = UDim2.new(0.9, 0, 0, 40)
NoclipBtn.Position = UDim2.new(0.05, 0, 0, 160)
NoclipBtn.Text = "اختراق الجدران"
NoclipBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
Instance.new("UICorner", NoclipBtn)

local NoclipEnabled = false
NoclipBtn.MouseButton1Click:Connect(function() 
    NoclipEnabled = not NoclipEnabled
    NoclipBtn.BackgroundColor3 = NoclipEnabled and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(80, 80, 80) 
end)

RunService.Stepped:Connect(function() 
    if NoclipEnabled and Player.Character then 
        for _, p in pairs(Player.Character:GetDescendants()) do 
            if p:IsA("BasePart") then 
                p.CanCollide = false 
            end 
        end 
    end 
end)

-- ==================== تبويب الاستهداف ====================
local TargetPage = AllPages["الاستهداف"]

local TInput = Instance.new("TextBox", TargetPage)
TInput.Size = UDim2.new(0.9, 0, 0, 40)
TInput.Position = UDim2.new(0.05, 0, 0, 10)
TInput.PlaceholderText = "أول 3 حروف"
TInput.TextColor3 = Color3.new(1,1,1)
TInput.BackgroundColor3 = Color3.fromRGB(40,40,40)
Instance.new("UICorner", TInput)

local PlayerImg = Instance.new("ImageLabel", TargetPage)
PlayerImg.Size = UDim2.new(0, 80, 0, 80)
PlayerImg.Position = UDim2.new(0.35, 0, 0, 60)
PlayerImg.BackgroundColor3 = Color3.fromRGB(60,60,60)
Instance.new("UICorner", PlayerImg)

local TargetPlayer = nil
TInput.FocusLost:Connect(function() 
    for _, plr in pairs(game.Players:GetPlayers()) do 
        if string.sub(string.lower(plr.Name), 1, 3) == string.lower(string.sub(TInput.Text, 1, 3)) then 
            TargetPlayer = plr
            PlayerImg.Image = "rbxthumb://type=AvatarHeadShot&id=" .. plr.UserId .. "&w=420&h=420"
            break 
        end 
    end 
end)

local BNames = {"انتقال", "استهداف", "ESP", "جلوس فوق"}
for i, bName in ipairs(BNames) do
    local b = Instance.new("TextButton", TargetPage)
    b.Size = UDim2.new(0.9, 0, 0, 35)
    b.Position = UDim2.new(0.05, 0, 0, 120 + (i-1) * 40)
    b.Text = bName .. " (OFF)"
    b.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
    Instance.new("UICorner", b)
    
    local state = false
    b.MouseButton1Click:Connect(function()
        state = not state
        b.Text = bName .. (state and " (ON)" or " (OFF)")
        b.BackgroundColor3 = state and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(150, 0, 0)
        if TargetPlayer and TargetPlayer.Character and TargetPlayer.Character:FindFirstChild("HumanoidRootPart") then
            if bName == "انتقال" and state then 
                Player.Character.HumanoidRootPart.CFrame = TargetPlayer.Character.HumanoidRootPart.CFrame
            elseif bName == "استهداف" then 
                workspace.CurrentCamera.CameraSubject = state and TargetPlayer.Character.Humanoid or Player.Character.Humanoid
            elseif bName == "ESP" then 
                if state and not TargetPlayer.Character:FindFirstChild("Highlight") then 
                    Instance.new("Highlight", TargetPlayer.Character) 
                elseif not state and TargetPlayer.Character:FindFirstChild("Highlight") then 
                    TargetPlayer.Character.Highlight:Destroy() 
                end
            elseif bName == "جلوس فوق" and state then 
  
