-- [[ سكريبت Anxam الأسطوري - النسخة المحدثة بالكامل للموبايل V42.0 ]]
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

-- === زر الإخفاء والظهار الدائري الاحترافي للموبايل ===
local ToggleBtn = Instance.new("TextButton", ScreenGui)
ToggleBtn.Name = "ToggleBtn"
ToggleBtn.Size = UDim2.new(0, 45, 0, 45)
ToggleBtn.Position = UDim2.new(0, 15, 0, 15) -- زاوية الشاشة لتجنب أزرار اللعبة
ToggleBtn.Text = "إخفاء" 
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(150, 30, 30)
ToggleBtn.TextSize = 13
ToggleBtn.Font = Enum.Font.SourceSansBold
ToggleBtn.Draggable = true
ToggleBtn.ZIndex = 100
Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(1, 0) -- دائري تماماً

-- === اللوحة الرئيسية (ثابتة ومتناسقة هندسياً للموبايل) ===
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 520, 0, 320) -- أبعاد ثابتة ومريحة للشاشات العرضية
MainFrame.Position = UDim2.new(0.5, -260, 0.5, -160)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.Active = true 
MainFrame.Draggable = true
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)

-- ربط زر التكبير والتصغير
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

-- === القائمة الجانبية بالتمرير لمنع التقصيص ===
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

-- === منطقة عرض القوائم والميزات المحدثة ===
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
    page.Visible = (i == 2) -- فتح تبويب اللاعب افتراضياً لتسهيل الاستخدام
    
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

-- ==================== تبويب الماب ====================
local MapPage = AllPages["اعدادات الماب"]
MapPage.CanvasSize = UDim2.new(0, 0, 0, 400)

local FBButton = Instance.new("TextButton", MapPage)
FBButton.Size = UDim2.new(0.95, 0, 0, 40)
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
ShaderBtn.Size = UDim2.new(0.95, 0, 0, 40)
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
ThemeBtn.Size = UDim2.new(0.95, 0, 0, 40)
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
            while ThemeBtn.Text == "اللون: رينبو" do
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
DiscordBtn.Size = UDim2.new(0.95, 0, 0, 40)
DiscordBtn.Text = "نسخ سيرفر الديسكورد"
DiscordBtn.Font = Enum.Font.SourceSansBold
DiscordBtn.TextSize = 16
DiscordBtn.TextColor3 = Color3.new(1, 1, 1)
DiscordBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
Instance.new("UICorner", DiscordBtn)
DiscordBtn.MouseButton1Click:Connect(function() setclipboard("https://discord.gg/WrxQZDVps") end)

-- ==================== تبويب اللاعب المطور والثابت للموبايل ====================
local PlayerPage = AllPages["اللاعب"]
PlayerPage.CanvasSize = UDim2.new(0, 0, 0, 460)

-- تعديل مدخلات السرعة لتكون على سطر واحد منسق
local SpeedContainer = Instance.new("Frame", PlayerPage)
SpeedContainer.Size = UDim2.new(0.95, 0, 0, 40)
SpeedContainer.BackgroundTransparency = 1

local SpeedInput = Instance.new("TextBox", SpeedContainer)
SpeedInput.Size = UDim2.new(0.6, -5, 1, 0)
SpeedInput.PlaceholderText = "أدخل قيمة السرعة"
SpeedInput.Text = ""
SpeedInput.TextColor3 = Color3.new(1,1,1)
SpeedInput.BackgroundColor3 = Color3.fromRGB(40,40,40)
Instance.new("UICorner", SpeedInput)

local SpeedBtn = Instance.new("TextButton", SpeedContainer)
SpeedBtn.Size = UDim2.new(0.4, 0, 1, 0)
SpeedBtn.Position = UDim2.new(0.6, 5, 0, 0)
SpeedBtn.Text = "تفعيل"
SpeedBtn.Font = Enum.Font.SourceSansBold
SpeedBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
SpeedBtn.TextColor3 = Color3.new(1,1,1)
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

-- قفز لا نهائي واختراق الجدران والطيران
local InfJumpBtn = Instance.new("TextButton", PlayerPage)
InfJumpBtn.Size = UDim2.new(0.95, 0, 0, 40)
InfJumpBtn.Text = "قفز لا نهائي"
InfJumpBtn.Font = Enum.Font.SourceSansBold
InfJumpBtn.TextSize = 15
InfJumpBtn.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
InfJumpBtn.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", InfJumpBtn)
local JumpEnabled = false
InfJumpBtn.MouseButton1Click:Connect(function() 
    JumpEnabled = not JumpEnabled 
    InfJumpBtn.BackgroundColor3 = JumpEnabled and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(55, 55, 55) 
end)
UIS.JumpRequest:Connect(function() if JumpEnabled and Player.Character and Player.Character:FindFirstChild("Humanoid") then Player.Character.Humanoid:ChangeState("Jumping") end end)

local NoclipBtn = Instance.new("TextButton", PlayerPage)
NoclipBtn.Size = UDim2.new(0.95, 0, 0, 40)
NoclipBtn.Text = "اختراق الجدران"
NoclipBtn.Font = Enum.Font.SourceSansBold
NoclipBtn.TextSize = 15
NoclipBtn.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
NoclipBtn.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", NoclipBtn)
local NoclipEnabled = false
NoclipBtn.MouseButton1Click:Connect(function() 
    NoclipEnabled = not NoclipEnabled
    NoclipBtn.BackgroundColor3 = NoclipEnabled and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(55, 55, 55) 
end)
RunService.Stepped:Connect(function() if NoclipEnabled and Player.Character then for _, p in pairs(Player.Character:GetDescendants()) do if p:IsA("BasePart") then p.CanCollide = false end end end end)

local FlyV3Btn = Instance.new("TextButton", PlayerPage)
FlyV3Btn.Size = UDim2.new(0.95, 0, 0, 40)
FlyV3Btn.Text = "تفعيل الطيران (Fly V3)"
FlyV3Btn.Font = Enum.Font.SourceSansBold
FlyV3Btn.TextSize = 15
FlyV3Btn.BackgroundColor3 = Color3.fromRGB(14, 110, 200)
FlyV3Btn.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", FlyV3Btn)
FlyV3Btn.MouseButton1Click:Connect(function() loadstring(game:HttpGet("https://raw.githubusercontent.com/XNEOFF/FlyGuiV3/main/FlyGuiV3.txt"))() end)

local ResetBtn = Instance.new("TextButton", PlayerPage)
ResetBtn.Size = UDim2.new(0.95, 0, 0, 40)
ResetBtn.Text = "إعادة رسوَن فوري (Instant Reset)"
ResetBtn.Font = Enum.Font.SourceSansBold
ResetBtn.TextSize = 15
ResetBtn.BackgroundColor3 = Color3.fromRGB(150, 30, 30)
ResetBtn.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", ResetBtn)
ResetBtn.MouseButton1Click:Connect(function() if Player.Character then Player.Character:BreakJoints() end end)

local GravityBtn = Instance.new("TextButton", PlayerPage)
GravityBtn.Size = UDim2.new(0.95, 0, 0, 40)
GravityBtn.Text = "الجاذبية: طبيعية"
GravityBtn.Font = Enum.Font.SourceSansBold
GravityBtn.TextSize = 15
GravityBtn.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
GravityBtn.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", GravityBtn)
local LowGrav = false
GravityBtn.MouseButton1Click:Connect(function() 
    LowGrav = not LowGrav
    workspace.Gravity = LowGrav and 35 or 196.2
    GravityBtn.Text = LowGrav and "الجاذبية: منخفضة (قمرية)" or "الجاذبية: طبيعية"
    GravityBtn.BackgroundColor3 = LowGrav and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(55, 55, 55) 
end)

-- ==================== تبويب الاستهداف ====================
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

local BNames = {"انتقال", "استهداف", "ESP", "جلوس فوق"}
for i, bName in ipairs(BNames) do
    local b = Instance.new("TextButton", TargetPage)
    b.Size = UDim2.new(0.95, 0, 0, 38)
    b.Text = bName .. " (OFF)"
    b.Font = Enum.Font.SourceSansBold
    b.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
    b.TextColor3 = Color3.new(1, 1, 1)
    Instance.new("UICorner", b)
    local state = false
    b.MouseButton1Click:Connect(function()
        state = not state
        b.Text = bName .. (state and " (ON)" or " (OFF)")
        b.BackgroundColor3 = state and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(150, 0, 0)
        if TargetPlayer and TargetPlayer.Character and TargetPlayer.Character:FindFirstChild("HumanoidRootPart") then
            if bName == "انتقال" and state then Player.Character.HumanoidRootPart.CFrame = TargetPlayer.Character.HumanoidRootPart.CFrame
            elseif bName == "استهداف" then workspace.CurrentCamera.CameraSubject = state and TargetPlayer.Character.Humanoid or Player.Character.Humanoid
            elseif bName == "ESP" then if state and not TargetPlayer.Character:FindFirstChild("Highlight") then Instance.new("Highlight", TargetPlayer.Character) elseif not state and TargetPlayer.Character:FindFirstChild("Highlight") then TargetPlayer.Character.Highlight:Destroy() end
            elseif bName == "جلوس فوق" and state then Player.Character.HumanoidRootPart.CFrame = TargetPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 3, 0) end
        end
    end)
end

-- ==================== تبويب المحفوظات ====================
local SavePage = AllPages["المحفوظات"]
SavePage.CanvasSize = UDim2.new(0, 0, 0, 350)

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
SaveBtn.Text = "حفظ"
SaveBtn.Font = Enum.Font.SourceSansBold
SaveBtn.BackgroundColor3 = Color3.fromRGB(0, 130, 0)
SaveBtn.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", SaveBtn)

local ListArea = Instance.new("Frame", SavePage)
ListArea.Size = UDim2.new(1, 0, 1, -50)
ListArea.BackgroundTransparency = 1
local ListLayout = Instance.new("UIListLayout", ListArea)
ListLayout.Padding = UDim.new(0, 5)
ListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

local function RefreshSaves()
    for _, child in pairs(ListArea:GetChildren()) do if child:IsA("Frame") then child:Destroy() end end
    for name, pos in pairs(getgenv().AihamSavedPositions) do
        local Container = Instance.new("Frame", ListArea)
        Container.Size = UDim2.new(0.95, 0, 0, 38)
        Container.BackgroundTransparency = 1
        
        local GoBtn = Instance.new("TextButton", Container)
        GoBtn.Size = UDim2.new(0.8, -5, 1, 0)
        GoBtn.Text = name
        GoBtn.BackgroundColor3 = Color3.fromRGB(60,60,60)
        GoBtn.TextColor3 = Color3.new(1,1,1)
        Instance.new("UICorner", GoBtn)
        
        local DelBtn = Instance.new("TextButton", Container)
        DelBtn.Size = UDim2.new(0.2, 0, 1, 0)
        DelBtn.Position = UDim2.new(0.8, 5, 0, 0)
        DelBtn.Text = "X"
        DelBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
        DelBtn.TextColor3 = Color3.new(1,1,1)
        Instance.new("UICorner", DelBtn)
        
        GoBtn.MouseButton1Click:Connect(function() if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then Player.Character.HumanoidRootPart.CFrame = pos end end)
        DelBtn.MouseButton1Click:Connect(function() getgenv().AihamSavedPositions[name] = nil; RefreshSaves() end)
    end
end

SaveBtn.MouseButton1Click:Connect(function()
    if SaveInput.Text ~= "" and Player.Character:FindFirstChild("HumanoidRootPart") then
        getgenv().AihamSavedPositions[SaveInput.Text] = Player.Character.HumanoidRootPart.CFrame
        RefreshSaves()
        SaveInput.Text = ""
    end
end)

-- تفقد وحمل القوائم المسجلة قديماً تلقائياً
RefreshSaves()
